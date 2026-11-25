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
import 'package:mangayomi/models/track.dart';
import 'package:mangayomi/models/update.dart';
import 'package:mangayomi/modules/library/providers/library_state_provider.dart';
import 'package:mangayomi/repositories/db_write_queue.dart';
import 'package:mangayomi/services/sync/sync_entity_applier.dart';

void main() {
  late Directory directory;
  late Isar database;

  setUpAll(() async {
    await Isar.initializeIsarCore(download: true);
  });

  setUp(() async {
    directory = await Directory.systemTemp.createTemp('category-sort-');
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
      name: 'category_sort',
    );
    app.isar = database;
  });

  tearDown(() async {
    await dbWriteQueue.whenIdle();
    await database.close(deleteFromDisk: true);
    if (await directory.exists()) await directory.delete(recursive: true);
  });

  test('a category without its own sort uses its media\'s', () {
    final settings = Settings()
      ..sortLibraryManga = SortLibraryManga(index: 3, reverse: true);
    final container = ProviderContainer();
    addTearDown(container.dispose);

    final sort = container.read(
      sortLibraryMangaStateProvider(
        itemType: ItemType.manga,
        settings: settings,
        categoryId: 5,
      ),
    );

    expect(sort.index, 3);
    expect(sort.reverse, isTrue);
  });

  test('sorting one category leaves the others and the default alone', () async {
    final settings = Settings()
      ..sortLibraryManga = SortLibraryManga(index: 3, reverse: false);
    await database.writeTxn(() => database.settings.put(settings));
    final container = ProviderContainer();
    addTearDown(container.dispose);

    container
        .read(
          sortLibraryMangaStateProvider(
            itemType: ItemType.manga,
            settings: settings,
            categoryId: 5,
          ).notifier,
        )
        .set(1);
    await dbWriteQueue.whenIdle();

    final saved = (await database.settings.get(227))!;
    expect(saved.sortLibraryManga?.index, 3, reason: 'the default is kept');
    expect(saved.sortLibraryCategoryList?.single.categoryId, 5);
    expect(saved.sortLibraryCategoryList?.single.index, 1);

    final fresh = ProviderContainer();
    addTearDown(fresh.dispose);
    SortLibraryManga read(int? categoryId) => fresh.read(
      sortLibraryMangaStateProvider(
        itemType: ItemType.manga,
        settings: saved,
        categoryId: categoryId,
      ),
    );
    expect(read(5).index, 1);
    expect(read(6).index, 3);
    expect(read(null).index, 3);
  });

  test('category sorts stay on this device when settings sync in', () async {
    await database.writeTxn(
      () => database.settings.put(
        Settings()
          ..updatedAt = 100
          ..sortLibraryCategoryList = [
            SortLibraryCategory(categoryId: 5, index: 2),
          ],
      ),
    );
    final remote = Settings()
      ..sortLibraryCategoryList = [
        SortLibraryCategory(categoryId: 5, index: 6),
      ];

    await const SyncEntityApplier().apply({
      'settings': {'updatedAt': 200, 'data': remote.toJson()},
    });

    final saved = (await database.settings.get(227))!;
    expect(saved.sortLibraryCategoryList?.single.index, 2);
  });
}
