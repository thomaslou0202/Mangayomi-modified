import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:isar_community/isar.dart';
import 'package:mangayomi/main.dart' as app;
import 'package:mangayomi/models/category.dart';
import 'package:mangayomi/models/chapter.dart';
import 'package:mangayomi/models/history.dart';
import 'package:mangayomi/models/manga.dart';
import 'package:mangayomi/models/settings.dart';
import 'package:mangayomi/models/source.dart';
import 'package:mangayomi/models/track.dart';
import 'package:mangayomi/models/update.dart';
import 'package:mangayomi/services/sync/sync_entity_applier.dart';

void main() {
  late Directory directory;
  late Isar database;

  setUpAll(() async {
    await Isar.initializeIsarCore(download: true);
  });

  setUp(() async {
    directory = await Directory.systemTemp.createTemp('sync-settings-');
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
      ],
      directory: directory.path,
      name: 'sync_settings_local_fields',
    );
    app.isar = database;
  });

  tearDown(() async {
    await database.close(deleteFromDisk: true);
    if (await directory.exists()) await directory.delete(recursive: true);
  });

  test(
    'newer settings from another device keep this device\'s library filters',
    () async {
      final local = Settings()
        ..updatedAt = 100
        ..libraryFilterNovelUnreadType = 1
        ..sortLibraryNovel = (SortLibraryManga()..index = 3)
        ..novelLibraryShowCategoryTabs = true
        ..incognitoMode = false
        ..sortChapterList = [SortChapter()..mangaId = 42];
      await database.writeTxn(() => database.settings.put(local));

      final remote = Settings()
        ..libraryFilterNovelUnreadType = 2
        ..sortLibraryNovel = (SortLibraryManga()..index = 0)
        ..novelLibraryShowCategoryTabs = false
        ..incognitoMode = true
        ..sortChapterList = [SortChapter()..mangaId = 7];
      final applied = await const SyncEntityApplier().apply({
        'settings': {'updatedAt': 200, 'data': remote.toJson()},
      });

      expect(applied, isTrue);
      final saved = (await database.settings.get(227))!;
      expect(saved.updatedAt, 200);
      expect(saved.incognitoMode, isTrue, reason: 'other settings still sync');
      expect(saved.libraryFilterNovelUnreadType, 1);
      expect(saved.sortLibraryNovel?.index, 3);
      expect(saved.novelLibraryShowCategoryTabs, isTrue);
      expect(saved.sortChapterList?.single.mangaId, 42);
    },
  );
}
