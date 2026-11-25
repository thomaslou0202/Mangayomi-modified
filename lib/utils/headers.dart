import 'dart:async';
import 'dart:convert';

import 'package:mangayomi/eval/http_response_extensions.dart';
import 'package:mangayomi/providers/general_state_provider.dart';
import 'package:mangayomi/models/source.dart';
import 'package:mangayomi/services/isolate_service.dart';
import 'package:mangayomi/services/source_code_errors.dart';
import 'package:mangayomi/utils/utils.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'headers.g.dart';

/// Headers per source, keyed by the provider's arguments.
///
/// Working them out runs the whole extension, and finding the source reads
/// every installed source (code and all) from the database. Both used to
/// happen on the UI thread whenever covers of a source were first drawn, and
/// again after the provider had been idle for a while, which is what made
/// switching library categories or tabs stall. Now a source is looked up once,
/// its stored headers are used straight away, and the extension's own headers
/// are worked out in the extension pool and filled in when they arrive.
final _sourceHeadersCache =
    <String, ({bool mihon, Map<String, String> headers})>{};

/// Forgets every source's headers, after an extension was installed or updated.
void clearSourceHeadersCache() => _sourceHeadersCache.clear();

@riverpod
Map<String, String> headers(
  Ref ref, {
  required String source,
  required String lang,
  required int? sourceId,
  String androidProxyServer = "",
}) {
  // Once the last listener drops, wait before actually disposing — this is
  // what covers rapid tab-switch unmount/remount without caching forever.
  // If a new listener shows up before the timer fires, onResume cancels it.
  final link = ref.keepAlive();
  Timer? timer;
  ref.onCancel(() {
    timer = Timer(const Duration(minutes: 5), link.close);
  });
  ref.onResume(() => timer?.cancel());
  ref.onDispose(() => timer?.cancel());

  final cacheKey = '$lang|$source|$sourceId|$androidProxyServer';
  var entry = _sourceHeadersCache[cacheKey];
  if (entry == null) {
    final mSource = getSource(lang, source, sourceId, installedOnly: true);
    if (mSource == null) return {};
    final stored = <String, String>{};
    // A source whose code will not run (empty, broken, half installed) has
    // no headers of its own, but its covers still load: before, the error
    // reached every cover of it, and the calendar failed to build.
    try {
      final fromSource = mSource.headers;
      if (fromSource != null && fromSource.isNotEmpty) {
        stored.addAll((jsonDecode(fromSource) as Map).toMapStringString!);
      }
    } catch (e, stack) {
      SourceCodeErrors.report(mSource, 'Headers', e, stack);
    }
    entry = (
      mihon: mSource.sourceCodeLanguage == SourceCodeLanguage.mihon,
      headers: stored,
    );
    _sourceHeadersCache[cacheKey] = entry;
    unawaited(
      getIsolateService
          .get<Map<String, String>>(
            source: mSource,
            serviceType: 'getHeaders',
            proxyServer: androidProxyServer,
          )
          .then(
            (fromExtension) {
              if (fromExtension.isEmpty) return;
              _sourceHeadersCache[cacheKey] = (
                mihon: entry!.mihon,
                headers: {...stored, ...fromExtension},
              );
              if (ref.mounted) ref.invalidateSelf();
            },
            onError: (Object e, StackTrace stack) =>
                SourceCodeErrors.report(mSource, 'Headers', e, stack),
          ),
    );
  }

  // A copy: callers add cookies and page headers to what they get, and
  // that must not end up in the cache for every later request.
  final headers = Map<String, String>.of(entry.headers);
  if (!entry.mihon) return headers;

  headers['user-agent'] = ref.watch(userAgentStateProvider);
  return headers;
}
