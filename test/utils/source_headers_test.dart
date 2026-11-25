import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:isar_community/isar.dart';
import 'package:mangayomi/main.dart' as app;
import 'package:mangayomi/models/manga.dart';
import 'package:mangayomi/models/settings.dart';
import 'package:mangayomi/models/source.dart';
import 'package:mangayomi/utils/headers.dart';

void main() {
  late Directory directory;
  late Isar database;

  setUpAll(() async {
    await Isar.initializeIsarCore(download: true);
  });

  setUp(() async {
    clearSourceHeadersCache();
    directory = await Directory.systemTemp.createTemp('source-headers-');
    database = await Isar.open(
      [SettingsSchema, SourceSchema],
      directory: directory.path,
      name: 'source_headers',
    );
    app.isar = database;
    await database.writeTxn(() async {
      await database.settings.put(Settings());
      await database.sources.put(
        Source(id: 7, name: 'Test', lang: 'zh')
          ..isAdded = true
          ..isActive = true
          ..itemType = ItemType.novel
          ..sourceCodeLanguage = SourceCodeLanguage.javascript
          ..headers = '{"x-stored":"1"}'
          ..sourceCode = 'class DefaultExtension extends MProvider { getHeaders(url) { return {Referer: "https://site.test/"}; } }',
      );
    });
  });

  tearDown(() async {
    await database.close(deleteFromDisk: true);
    if (await directory.exists()) await directory.delete(recursive: true);
  });

  test(
    'answers with stored headers at once and adds the extension\'s own later',
    () async {
      final container = ProviderContainer();
      addTearDown(container.dispose);
      final provider = headersProvider(source: 'Test', lang: 'zh', sourceId: 7);
      final seen = <Map<String, String>>[];
      container.listen(
        provider,
        (_, next) => seen.add(next),
        fireImmediately: true,
      );

      // Drawing a cover never waits for the extension to run.
      expect(seen.first, {'x-stored': '1'});

      for (var i = 0; i < 50 && seen.length < 2; i++) {
        await Future<void>.delayed(const Duration(milliseconds: 20));
      }
      expect(seen.last, {'x-stored': '1', 'Referer': 'https://site.test/'});
    },
  );

  test('callers adding headers do not change what the next caller gets', () {
    final container = ProviderContainer();
    addTearDown(container.dispose);
    final provider = headersProvider(source: 'Test', lang: 'zh', sourceId: 7);
    container.read(provider)['cookie'] = 'session=1';
    container.invalidate(provider);
    expect(container.read(provider).containsKey('cookie'), isFalse);
  });
}
