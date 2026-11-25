import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:isar_community/isar.dart';
import 'package:mangayomi/main.dart' as app;
import 'package:mangayomi/models/category.dart';
import 'package:mangayomi/models/chapter.dart';
import 'package:mangayomi/models/history.dart';
import 'package:mangayomi/models/manga.dart';
import 'package:mangayomi/models/settings.dart';
import 'package:mangayomi/models/source.dart';
import 'package:mangayomi/models/sync_preference.dart';
import 'package:mangayomi/models/track.dart';
import 'package:mangayomi/models/update.dart';
import 'package:mangayomi/modules/library/providers/library_filter_provider.dart';
import 'package:mangayomi/providers/sync_providers.dart';
import 'package:mangayomi/repositories/db_write_queue.dart';
import 'package:mangayomi/services/http/m_client.dart';
import 'package:mangayomi/services/library_chapter_summary.dart';
import 'package:mangayomi/services/sync/sync_entity_applier.dart';

void main() {
  group('cookies', () {
    final cookies = [MCookie(host: 'x.org', cookie: 'session=1')];

    test('reach the host and its subdomains', () {
      expect(MClient.getCookiesPref('https://x.org/a', cookiesList: cookies), {
        'cookie': 'session=1',
      });
      expect(
        MClient.getCookiesPref('https://www.x.org/a', cookiesList: cookies),
        isNotEmpty,
      );
    });

    test('never reach a different host that merely contains the name', () {
      for (final url in ['https://myx.org.evil.com/', 'https://abcx.org/']) {
        expect(MClient.getCookiesPref(url, cookiesList: cookies), isEmpty);
      }
    });
  });

  group('unread and started filters', () {
    const unreadOnly = LibraryChapterSummary(total: 10, unread: 10);
    const started = LibraryChapterSummary(total: 10, unread: 4);
    const finished = LibraryChapterSummary(total: 10, unread: 0);

    bool passes(LibraryChapterSummary s, {int unread = 0, int startedF = 0}) =>
        passesReadFilters(
          s,
          unreadFilterType: unread,
          startedFilterType: startedF,
        );

    test('started means at least one chapter read', () {
      expect(passes(unreadOnly, startedF: 1), isFalse);
      expect(passes(started, startedF: 1), isTrue);
      expect(passes(finished, startedF: 1), isTrue);
      expect(passes(unreadOnly, startedF: 2), isTrue);
      expect(passes(started, startedF: 2), isFalse);
    });

    test('unread keeps its meaning', () {
      expect(passes(unreadOnly, unread: 1), isTrue);
      expect(passes(finished, unread: 1), isFalse);
      expect(passes(finished, unread: 2), isTrue);
    });
  });

  group('with a database', () {
    late Directory directory;
    late Isar database;

    setUpAll(() async {
      await Isar.initializeIsarCore(download: true);
    });

    setUp(() async {
      directory = await Directory.systemTemp.createTemp('first-batch-');
      database = await Isar.open(
        [
          SettingsSchema,
          MangaSchema,
          SourceSchema,
          ChapterSchema,
          HistorySchema,
          TrackSchema,
          UpdateSchema,
          CategorySchema,
          SyncPreferenceSchema,
        ],
        directory: directory.path,
        name: 'first_batch',
      );
      app.isar = database;
    });

    tearDown(() async {
      await dbWriteQueue.whenIdle();
      await database.close(deleteFromDisk: true);
      if (await directory.exists()) await directory.delete(recursive: true);
    });

    test('a new sync checkpoint is not undone by the next save', () async {
      await database.writeTxn(
        () => database.syncPreferences.put(SyncPreference(syncId: 1, since: 5)),
      );
      final container = ProviderContainer();
      addTearDown(container.dispose);
      final notifier = container.read(synchingProvider(syncId: 1).notifier);

      notifier.setSince(100);
      notifier.setLastSync(200);
      await dbWriteQueue.whenIdle();

      expect(container.read(synchingProvider(syncId: 1)).since, 100);
      final saved = await database.syncPreferences
          .filter()
          .syncIdEqualTo(1)
          .findFirst();
      expect(saved?.since, 100);
      expect(saved?.lastSync, 200);
    });

    test('a synced update is linked to its chapter by name', () async {
      final manga = Manga(
        source: 's',
        author: '',
        artist: '',
        genre: const [],
        imageUrl: '',
        lang: 'zh',
        link: '/m',
        name: 'M',
        status: Status.ongoing,
        description: '',
        sourceId: 1,
        favorite: true,
      )..clientId = 70;
      await database.writeTxn(() async {
        await database.settings.put(Settings());
        final mangaId = await database.mangas.put(manga);
        await database.chapters.put(
          Chapter(mangaId: mangaId, name: '第 5 話', url: '/c/5'),
        );
      });

      await const SyncEntityApplier().apply({
        'updates': [
          {
            'clientId': 9,
            'mangaClientId': 70,
            'chapterName': '第 5 話',
            'date': 1,
            'updatedAt': 10,
          },
        ],
      });

      final update = await database.updates.where().findFirst();
      await update!.chapter.load();
      expect(update.chapter.value?.name, '第 5 話');
    });

    test('device paths and local-id lists stay on this device', () async {
      await database.writeTxn(
        () => database.settings.put(
          Settings()
            ..updatedAt = 100
            ..downloadLocation = 'D:\\Downloads'
            ..chapterPageIndexList = [
              ChapterPageIndex()
                ..chapterId = 3
                ..index = 7,
            ],
        ),
      );
      final remote = Settings()
        ..downloadLocation = '/storage/emulated/0/Mangayomi'
        ..chapterPageIndexList = [
          ChapterPageIndex()
            ..chapterId = 3
            ..index = 99,
        ];

      await const SyncEntityApplier().apply({
        'settings': {'updatedAt': 200, 'data': remote.toJson()},
      });

      final saved = (await database.settings.get(227))!;
      expect(saved.downloadLocation, 'D:\\Downloads');
      expect(saved.chapterPageIndexList?.single.index, 7);
    });
  });
}
