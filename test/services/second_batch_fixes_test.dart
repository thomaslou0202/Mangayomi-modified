import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:isar_community/isar.dart';
import 'package:mangayomi/main.dart' as app;
import 'package:mangayomi/models/manga.dart';
import 'package:mangayomi/models/source.dart';
import 'package:mangayomi/modules/more/about/providers/app_release.dart';
import 'package:mangayomi/modules/more/about/providers/check_for_update.dart';
import 'package:mangayomi/repositories/db_write_queue.dart';
import 'package:mangayomi/repositories/source_repository.dart';
import 'package:mangayomi/services/get_html_content.dart';

const _hex =
    'cafee3d189e41f806b19b84fd4814047812a72059ee072ed9c23ad31940c3076';

Map<String, dynamic> _release({bool draft = false}) {
  const tag = 'v0.9.95+148';
  return {
    'tag_name': tag,
    'draft': draft,
    'prerelease': false,
    'html_url': '$appReleaseRepositoryUrl/releases/tag/v0.9.95%2B148',
    'body': '',
    'assets': <dynamic>[
      {
        'state': 'uploaded',
        'size': 134514391,
        'digest': 'sha256:${_hex.toUpperCase()}',
        'browser_download_url':
            '$appReleaseRepositoryUrl/releases/download/v0.9.95%2B148/Mangayomi-android.apk',
      },
      {
        'state': 'uploaded',
        'size': 176,
        'browser_download_url':
            '$appReleaseRepositoryUrl/releases/download/v0.9.95%2B148/SHA256SUMS.txt',
      },
    ],
  };
}

void main() {
  group('update assets', () {
    test('carry size and digest of the files the release offers', () {
      final assets = releaseUpdateAssets(_release())!;
      expect(assets, hasLength(1));
      expect(assets.single.url, endsWith('/Mangayomi-android.apk'));
      expect(assets.single.size, 134514391);
      expect(assets.single.sha256, _hex);
    });

    test('are not offered from a draft', () {
      expect(releaseUpdateAssets(_release(draft: true)), isNull);
    });

    test('digest is read only in the sha256:<hex> form', () {
      expect(sha256OfDigest('sha256:$_hex'), _hex);
      expect(sha256OfDigest('md5:abc'), isNull);
      expect(sha256OfDigest(null), isNull);
    });
  });

  group('novel html', () {
    test('keeps escaped angle brackets as text', () {
      final html = buildNovelHtml('<p>獲得 &lt;技能&gt; 與 a &amp;lt; b</p>');
      expect(html, contains('&lt;技能&gt;'));
      expect(html, isNot(contains('<技能>')));
      expect(html, contains('&amp;lt;'));
    });

    test('still decodes typographic entities', () {
      expect(buildNovelHtml('<p>a&hellip;b</p>'), contains('a…b'));
    });
  });

  group('with a database', () {
    late Directory directory;
    late Isar database;

    setUpAll(() async {
      await Isar.initializeIsarCore(download: true);
    });

    setUp(() async {
      directory = await Directory.systemTemp.createTemp('second-batch-');
      database = await Isar.open(
        [SourceSchema],
        directory: directory.path,
        name: 'second_batch',
      );
      app.isar = database;
    });

    tearDown(() async {
      await dbWriteQueue.whenIdle();
      await database.close(deleteFromDisk: true);
      if (await directory.exists()) await directory.delete(recursive: true);
    });

    test('marking a source last used writes only the ones that change', () async {
      Source source(int id, {bool lastUsed = false, ItemType? type}) =>
          Source(id: id, name: 's$id', lang: 'en', lastUsed: lastUsed)
            ..itemType = type ?? ItemType.manga
            ..updatedAt = 1;
      await database.writeTxn(
        () => database.sources.putAll([
          source(1, lastUsed: true),
          source(2),
          source(3),
          source(4, lastUsed: true, type: ItemType.anime),
        ]),
      );

      await sourceRepository.markLastUsed(ItemType.manga, 2);

      final byId = {
        for (final s in await database.sources.where().findAll()) s.id: s,
      };
      expect(byId[1]!.lastUsed, isFalse);
      expect(byId[2]!.lastUsed, isTrue);
      expect(byId[3]!.updatedAt, 1, reason: 'unchanged, so not rewritten');
      expect(byId[4]!.lastUsed, isTrue, reason: 'another media type');
    });
  });
}
