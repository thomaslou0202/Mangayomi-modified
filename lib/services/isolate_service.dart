import 'dart:async';
import 'dart:io';
import 'dart:isolate';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:mangayomi/eval/interface.dart';
import 'package:mangayomi/eval/lib.dart';
import 'package:mangayomi/repositories/db.dart';
import 'package:mangayomi/models/source.dart';
import 'package:mangayomi/providers/storage_provider.dart';
import 'package:mangayomi/services/http/m_client.dart';
import 'package:mangayomi/src/rust/frb_generated.dart';
import 'package:mangayomi/utils/log/log.dart';

/// Whether [source]'s extension can run in a worker isolate.
///
/// Building an extension service evaluates the whole extension, and its
/// parsing runs synchronously. On the root isolate that blocks the UI, which
/// is what froze the app while opening a title or loading a list. Everything
/// a JavaScript, Dart, Mihon or LNReader extension needs from the root isolate
/// (WebView pages, Cloudflare solving) goes through the loopback bridge in
/// m_client.dart, so those run in the pool.
///
/// Aidoku is the exception: it drives HeadlessInAppWebView and CookieManager
/// itself, and the plugin's callbacks into Dart only reach the root isolate.
bool runsInWorkerIsolate(Source source) =>
    source.sourceCodeLanguage != SourceCodeLanguage.aidoku;

/// Runs one service call. Shared by the worker isolates and the root-isolate
/// fallback so both answer the same way.
Future<Object?> _dispatch(
  ExtensionService service, {
  required String? serviceType,
  String? url,
  int? page,
  String? query,
  List<dynamic>? filterList,
}) async {
  switch (serviceType) {
    case 'getDetail':
      return await service.getDetail(url!);
    case 'getPopular':
      return await service.getPopular(page!);
    case 'getLatestUpdates':
      return await service.getLatestUpdates(page!);
    case 'search':
      return await service.search(query!, page!, filterList!);
    case 'getVideoList':
      return await service.getVideoList(url!);
    case 'getPageList':
      return await service.getPageList(url!);
    case 'getHtmlContent':
      return await service.getHtmlContent(query ?? '', url!);
    case 'getHeaders':
      return service.getHeaders();
    default:
      throw Exception('Unknown service type: $serviceType');
  }
}

class _IsolateData {
  final SendPort sendPort;
  final RootIsolateToken rootIsolateToken;

  _IsolateData({required this.sendPort, required this.rootIsolateToken});
}

class _IsolateWorker {
  Isolate? isolate;
  ReceivePort? receivePort;
  StreamSubscription? receiveSub;
  SendPort? sendPort;
  bool isBusy = false;

  /// Whether the call it is running was started by background work.
  bool background = false;

  Future<void> start(RootIsolateToken rootToken) async {
    receivePort = ReceivePort();
    isolate = await Isolate.spawn(
      GetIsolateService._getIsolateServiceEntryPoint,
      _IsolateData(
        sendPort: receivePort!.sendPort,
        rootIsolateToken: rootToken,
      ),
    );

    final completer = Completer<SendPort>();
    receiveSub = receivePort!.listen((message) {
      if (message is SendPort) {
        if (!completer.isCompleted) completer.complete(message);
        return;
      }
      if (message is Map && message['workerInitError'] != null) {
        // The worker could not open the database or its libraries. Say so now
        // instead of making the caller wait out the handshake timeout.
        if (!completer.isCompleted) {
          completer.completeError(
            StateError('Isolate worker failed: ${message['workerInitError']}'),
          );
        }
        return;
      }
      if (message is Map && message['cloudflareAlert'] == true) {
        // An extension in this worker hit a Cloudflare challenge. The toast
        // and its "open in WebView" button only exist on the root isolate.
        try {
          showCloudflareAlertFor(
            url: message['url'] as String?,
            statusCode: message['statusCode'] as int? ?? 0,
          );
        } catch (_) {
          // No toast host yet (very early in launch); the call itself still
          // reports its failure to whoever made it.
        }
        return;
      }
      if (message is String) {
        final logged = redactHeadersInText(message);
        if (logged.startsWith('LoggerLevel.warning:')) {
          Logger.add(
            LoggerLevel.warning,
            logged.replaceFirst('LoggerLevel.warning:', ''),
          );
        } else {
          Logger.add(LoggerLevel.info, logged);
        }
        if (kDebugMode) {
          print(message.replaceFirst('LoggerLevel.warning:', ''));
        }
      }
    });

    // The worker opens the database and the Rust library before it answers,
    // so give a slow phone more room than a bare spawn would need.
    sendPort = await completer.future.timeout(
      const Duration(seconds: 20),
      onTimeout: () => throw StateError('Isolate handshake timed out'),
    );
  }

  Future<void> stop() async {
    sendPort?.send('dispose');
    isolate?.kill(priority: Isolate.immediate);
    await receiveSub?.cancel();
    receivePort?.close();
  }
}

class GetIsolateService {
  bool _isRunning = false;
  Future<void>? _starting;
  final List<_IsolateWorker> _workers = [];
  final List<Completer<_IsolateWorker>> _pendingWorkers = [];

  /// Calls from background work (downloads) waiting for a worker. Served only
  /// after [_pendingWorkers], and never with the last free worker.
  final List<Completer<_IsolateWorker>> _pendingBackground = [];
  static const int _poolSize = 4;

  /// Off under `flutter test`: a worker reaches the platform through
  /// BackgroundIsolateBinaryMessenger, which the test binding does not answer,
  /// so it would wait forever opening the database.
  static bool usePool = !Platform.environment.containsKey('FLUTTER_TEST');

  /// How long one call may run before its worker is replaced. Generous on
  /// purpose: a large catalogue or a WebView-backed page can take a while,
  /// and before the pool handled these sources they had no limit at all.
  static const Duration _callTimeout = Duration(minutes: 3);

  /// Starts the pool. Concurrent callers share one start, so a burst of
  /// requests on launch does not spawn the pool several times over.
  Future<void> start() {
    if (_isRunning) return Future.value();
    // A pool that just failed to start would fail again; don't respawn it on
    // every call while the root isolate covers for it.
    final failedAt = _startFailedAt;
    if (failedAt != null &&
        DateTime.now().difference(failedAt) < _retryStartAfter) {
      return Future.value();
    }
    return _starting ??= _start().whenComplete(() => _starting = null);
  }

  DateTime? _startFailedAt;
  static const Duration _retryStartAfter = Duration(minutes: 1);

  Future<void> _start() async {
    final rootToken = RootIsolateToken.instance;
    if (rootToken == null) return;
    final started = await Future.wait(
      List.generate(_poolSize, (_) => _spawnWorker(rootToken)),
    );
    _workers.addAll(started.whereType<_IsolateWorker>());
    _isRunning = _workers.isNotEmpty;
    _startFailedAt = _isRunning ? null : DateTime.now();
  }

  Future<_IsolateWorker?> _spawnWorker(RootIsolateToken rootToken) async {
    final worker = _IsolateWorker();
    try {
      await worker.start(rootToken);
      return worker;
    } catch (_) {
      await worker.stop();
      return null;
    }
  }

  static Future<void> _getIsolateServiceEntryPoint(
    _IsolateData isolateData,
  ) async {
    BackgroundIsolateBinaryMessenger.ensureInitialized(
      isolateData.rootIsolateToken,
    );

    // The Rust library holds the HTTP client extensions use (rhttp). Without
    // it here, MClient quietly falls back to dart:io, which handshakes
    // differently and is turned away by some sites. Each isolate needs its own
    // init; the library has no one-time Rust initializers.
    try {
      await RustLib.init();
    } catch (_) {}

    try {
      await initializeDateFormatting();
      isar = await StorageProvider().initDB(null, inspector: kDebugMode);
    } catch (e) {
      isolateData.sendPort.send({'workerInitError': e.toString()});
      return;
    }

    // Raised from m_client when a request hits a Cloudflare challenge; handed
    // to the root isolate, which owns the toast.
    cloudflareAlertForwarder = (url, statusCode) {
      isolateData.sendPort.send({
        'cloudflareAlert': true,
        'url': url,
        'statusCode': statusCode,
      });
    };

    final receivePort = ReceivePort();
    Zone.current
        .fork(
          specification: ZoneSpecification(
            print: (self, parent, zone, line) {
              isolateData.sendPort.send(line);
            },
          ),
        )
        .run(() async {
          isolateData.sendPort.send(receivePort.sendPort);
          receivePort.listen((message) async {
            if (message is Map<String, dynamic>) {
              final responsePort = message['responsePort'] as SendPort;
              try {
                final source = message['source'] as Source?;
                final proxyServer = message['proxyServer'] as String?;
                final useLoggerValue = message['useLogger'] as bool?;
                cfPort = message['cfPort'] as int;
                webviewBridgeToken =
                    message['webviewBridgeToken'] as String? ?? '';
                customDns = message['customDns'] as String?;
                if (useLoggerValue != null) {
                  useLogger = useLoggerValue;
                }
                final result = await withExtensionService(
                  source!,
                  proxyServer ?? '',
                  (service) => _dispatch(
                    service,
                    serviceType: message['serviceType'] as String?,
                    url: message['url'] as String?,
                    page: message['page'] as int?,
                    query: message['query'] as String?,
                    filterList: message['filterList'] as List?,
                  ),
                );
                responsePort.send({'success': true, 'data': result});
              } catch (e) {
                responsePort.send({'success': false, 'error': e.toString()});
              } finally {
                useLogger = false;
              }
            } else if (message == 'dispose') {
              receivePort.close();
            }
          });
        });
  }

  int get _busyBackground =>
      _workers.where((w) => w.isBusy && w.background).length;

  /// Background work may hold every worker but one, so opening a source or a
  /// chapter never queues behind a batch of downloads.
  /// (A pool down to one worker shares it, or downloads would never start.)
  bool get _backgroundMayStart =>
      _workers.length <= 1 || _busyBackground < _workers.length - 1;

  _IsolateWorker? _claimFree({required bool background}) {
    if (background && !_backgroundMayStart) return null;
    for (final worker in _workers) {
      if (!worker.isBusy) {
        worker
          ..isBusy = true
          ..background = background;
        return worker;
      }
    }
    return null;
  }

  Future<_IsolateWorker> _getAvailableWorker({bool background = false}) async {
    if (!_isRunning) {
      throw Exception('Isolate service not running');
    }
    final free = _claimFree(background: background);
    if (free != null) return free;
    final completer = Completer<_IsolateWorker>();
    (background ? _pendingBackground : _pendingWorkers).add(completer);
    return completer.future;
  }

  void _releaseWorker(_IsolateWorker worker) {
    worker
      ..isBusy = false
      ..background = false;
    _dispatchPending();
  }

  /// Hands free workers to waiting calls: interactive ones first.
  void _dispatchPending() {
    while (_pendingWorkers.isNotEmpty) {
      final worker = _claimFree(background: false);
      if (worker == null) return;
      _pendingWorkers.removeAt(0).complete(worker);
    }
    while (_pendingBackground.isNotEmpty) {
      final worker = _claimFree(background: true);
      if (worker == null) return;
      _pendingBackground.removeAt(0).complete(worker);
    }
  }

  /// Replaces a worker whose call timed out. Handing it the next call instead
  /// would run two calls in one isolate at once, and they share its globals
  /// (proxy port, logger flag).
  void _retireWorker(_IsolateWorker worker) {
    _workers.remove(worker);
    unawaited(worker.stop());
    final rootToken = RootIsolateToken.instance;
    if (rootToken == null) return;
    unawaited(
      _spawnWorker(rootToken).then((fresh) {
        if (fresh == null || !_isRunning) {
          if (fresh != null) unawaited(fresh.stop());
          if (_workers.isEmpty) _failPending('No isolate worker available');
          return;
        }
        _workers.add(fresh);
        _releaseWorker(fresh);
      }),
    );
  }

  void _failPending(String reason) {
    for (final pending in [..._pendingWorkers, ..._pendingBackground]) {
      if (!pending.isCompleted) pending.completeError(StateError(reason));
    }
    _pendingWorkers.clear();
    _pendingBackground.clear();
    if (_workers.isEmpty) _isRunning = false;
  }

  /// Runs the call on the root isolate. Only for sources that cannot leave it
  /// ([runsInWorkerIsolate]) and for when the pool is unavailable.
  Future<T> _runHere<T>({
    required Source source,
    required String? serviceType,
    String? url,
    int? page,
    String? query,
    List<dynamic>? filterList,
    String? proxyServer,
  }) async {
    return await withExtensionService(
      source,
      proxyServer ?? '',
      (service) => _dispatch(
        service,
        serviceType: serviceType,
        url: url,
        page: page,
        query: query,
        filterList: filterList,
      ),
    ) as T;
  }

  Future<T> get<T>({
    String? url,
    int? page,
    String? query,
    List<dynamic>? filterList,
    Source? source,
    String? serviceType,
    String? proxyServer,
    bool? autoUpdateExtensions,
    String? androidProxyServer,
    bool? useLogger,
  }) async {
    if (source == null) {
      throw ArgumentError.notNull('source');
    }
    Future<T> runHere() => _runHere<T>(
      source: source,
      serviceType: serviceType,
      url: url,
      page: page,
      query: query,
      filterList: filterList,
      proxyServer: proxyServer,
    );

    if (!usePool || !runsInWorkerIsolate(source)) return runHere();
    if (!_isRunning) {
      await start();
    }
    // Spawning failed (no root token in a test, out of memory): keep the app
    // working the way it did before the pool took these sources.
    if (!_isRunning) return runHere();

    final _IsolateWorker worker;
    try {
      worker = await _getAvailableWorker(
        background: Zone.current[_backgroundWorkKey] == true,
      );
    } on StateError {
      return runHere();
    }
    final responsePort = ReceivePort();
    final completer = Completer<T>();
    late final StreamSubscription sub;

    final timer = Timer(_callTimeout, () {
      if (!completer.isCompleted) {
        sub.cancel();
        responsePort.close();
        _retireWorker(worker);
        completer.completeError('Isolate response timeout');
      }
    });

    sub = responsePort.listen((response) {
      timer.cancel();
      sub.cancel();
      responsePort.close();
      _releaseWorker(worker);
      if (response is Map<String, dynamic>) {
        if (response['success'] == true) {
          completer.complete(response['data'] as T);
        } else {
          completer.completeError(response['error']);
        }
      } else {
        completer.completeError('Invalid isolate response: $response');
      }
    });

    try {
      worker.sendPort!.send({
        'url': ?url,
        'page': ?page,
        'query': ?query,
        'filterList': ?filterList,
        'serviceType': ?serviceType,
        'source': source,
        'proxyServer': ?proxyServer,
        'responsePort': responsePort.sendPort,
        'useLogger': ?useLogger,
        'cfPort': cfPort,
        'webviewBridgeToken': webviewBridgeToken,
        'customDns': ?customDns,
      });
    } catch (_) {
      // Something in the call cannot cross isolates (a filter list holding a
      // Dart-extension object, say). Run it here rather than fail it.
      timer.cancel();
      sub.cancel();
      responsePort.close();
      _releaseWorker(worker);
      return runHere();
    }

    return completer.future;
  }

  Future<void> stop() async {
    if (!_isRunning) {
      return;
    }

    for (final worker in _workers) {
      await worker.stop();
    }
    _workers.clear();
    _isRunning = false;
    _failPending('Isolate service stopped');
  }
}

final getIsolateService = GetIsolateService();

final _backgroundWorkKey = Object();

/// Runs [body] as background work: extension calls made inside it wait behind
/// interactive ones and leave one worker free for them. For downloads, which
/// can otherwise keep every worker busy while the reader opens a source.
Future<T> runAsBackgroundWork<T>(Future<T> Function() body) =>
    runZoned(body, zoneValues: {_backgroundWorkKey: true});
