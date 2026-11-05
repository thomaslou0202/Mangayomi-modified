import 'dart:async';
import 'dart:isolate';

import 'package:flutter/services.dart';
import 'package:isar_community/isar.dart';
import 'package:mangayomi/main.dart' as app;
import 'package:mangayomi/models/chapter.dart';
import 'package:mangayomi/models/download.dart';
import 'package:mangayomi/models/manga.dart';
import 'package:mangayomi/providers/storage_provider.dart';
import 'package:mangayomi/services/library_chapter_summary.dart';
import 'package:mangayomi/services/sync/sync_change_collector.dart';
import 'package:mangayomi/services/sync/sync_entity_applier.dart';
import 'package:mangayomi/utils/client_id.dart';
import 'package:mangayomi/utils/extensions/manga_extensions.dart';
import 'package:mangayomi/utils/linovelib_chapters.dart';

/// One serial database worker. Native Isar transactions arbitrate writes across
/// isolates; no Flutter Ref, lazy Isar link, or UI object crosses this boundary.
class DatabaseWorker {
  static final instance = DatabaseWorker();
  Future<SendPort>? _starting;
  Isolate? _isolate;
  final _pending = <int, Completer<Object?>>{};
  int _nextId = 0;
  Completer<void>? _exited;

  Future<SendPort> _start() async {
    _exited = Completer<void>();
    final responses = ReceivePort();
    final ready = Completer<SendPort>();
    late StreamSubscription<dynamic> subscription;
    subscription = responses.listen((message) {
      if (message is SendPort) {
        ready.complete(message);
      } else if (message is List && message.length == 3) {
        final completion = _pending.remove(message[0]);
        if (message[1] == true) {
          completion?.complete(message[2]);
        } else {
          completion?.completeError(StateError(message[2].toString()));
        }
      } else {
        // Isolate error/exit: don't leave callers and progress bars hanging.
        _starting = null;
        final error = StateError('Database background worker stopped');
        if (!ready.isCompleted) ready.completeError(error);
        for (final pending in _pending.values) {
          pending.completeError(error);
        }
        _pending.clear();
        subscription.cancel();
        responses.close();
        _exited?.complete();
      }
    });
    try {
      _isolate = await Isolate.spawn(
        _databaseEntry,
        [
          responses.sendPort,
          app.isar.directory!,
          RootIsolateToken.instance,
          app.isar.name,
        ],
        onError: responses.sendPort,
        onExit: responses.sendPort,
        debugName: 'library-sync-database',
      );
      return await ready.future;
    } catch (_) {
      _starting = null;
      await subscription.cancel();
      responses.close();
      rethrow;
    }
  }

  Future<T> run<T>(String operation, [Object? argument]) async {
    final port = await (_starting ??= _start());
    final id = _nextId++;
    final completion = Completer<Object?>();
    _pending[id] = completion;
    port.send([id, operation, argument]);
    return await completion.future as T;
  }

  /// Used by database replacement/tests, never by ordinary screen navigation.
  Future<void> close() async {
    if (_starting == null) return;
    await run<void>('close');
    _isolate?.kill(priority: Isolate.immediate);
    await _exited?.future;
  }
}

Future<void> _databaseEntry(List<Object?> arguments) async {
  final response = arguments[0] as SendPort;
  final token = arguments[2] as RootIsolateToken?;
  if (token != null) BackgroundIsolateBinaryMessenger.ensureInitialized(token);
  app.isar = await Isar.open(
    StorageProvider.databaseSchemas,
    directory: arguments[1] as String,
    name: arguments[3] as String,
    inspector: false,
  );
  final requests = ReceivePort();
  response.send(requests.sendPort);
  await for (final message in requests) {
    final request = message as List;
    try {
      final Object? result;
      switch (request[1]) {
        case 'summary':
          final downloaded = app.isar.downloads
              .filter()
              .isDownloadEqualTo(true)
              .idProperty()
              .findAllSync()
              .toSet();
          final builder = LibrarySummaryBuilder();
          final linovelibBooks = {
            for (final manga in app.isar.mangas.where().findAllSync())
              if (manga.isLinovelib) manga.id: manga,
          };
          // Only the worker deserializes the large chapter collection.
          for (final chapter in app.isar.chapters.where().findAllSync()) {
            final book = linovelibBooks[chapter.mangaId];
            if (book != null &&
                !linovelibChapterBelongsToBook(book.link, chapter.url)) {
              continue;
            }
            builder.add(
              mangaId: chapter.mangaId,
              read: chapter.isRead ?? false,
              bookmarked: chapter.isBookmarked ?? false,
              downloaded: downloaded.contains(chapter.id),
              scanlator: chapter.scanlator,
              dateUpload: chapter.dateUpload,
            );
          }
          result = builder.finish();
        case 'collect':
          result = app.isar.txnSync(
            () => ChangedRows.collectSnapshot(request[2] as int),
          );
        case 'collectAll':
          result = app.isar.txnSync(
            () => ChangedRows.collectAll(forcedUpdatedAt: request[2] as int),
          );
        case 'apply':
          result = await const SyncEntityApplier().apply(
            request[2] as Map<String, dynamic>,
          );
        case 'barrier':
          result = null;
        case 'close':
          await app.isar.close();
          response.send([request[0], true, null]);
          requests.close();
          return;
        case 'backfill':
          await backfillMissingClientIds();
          result = null;
        default:
          throw ArgumentError('Unknown database operation');
      }
      response.send([request[0], true, result]);
    } catch (error) {
      response.send([request[0], false, error.toString()]);
    }
  }
}
