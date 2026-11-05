import 'dart:async';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:isar_community/isar.dart';
import 'package:mangayomi/main.dart' as app;
import 'package:mangayomi/models/changed.dart';
import 'package:mangayomi/models/chapter.dart';
import 'package:mangayomi/models/manga.dart';
import 'package:mangayomi/models/history.dart';
import 'package:mangayomi/models/settings.dart';
import 'package:mangayomi/providers/storage_provider.dart';
import 'package:mangayomi/repositories/changed_part_repository.dart';
import 'package:mangayomi/repositories/chapter_repository.dart';
import 'package:mangayomi/services/database_worker.dart';
import 'package:mangayomi/services/library_chapter_summary.dart';
import 'package:mangayomi/services/sync/sync_change_collector.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  late Directory directory;
  setUpAll(() async {
    final overrides = HttpOverrides.current;
    HttpOverrides.global = null;
    try {
      await Isar.initializeIsarCore(download: true);
    } finally {
      HttpOverrides.global = overrides;
    }
  });
  setUp(() async {
    directory = await Directory.systemTemp.createTemp('background_library');
    app.isar = await Isar.open(
      StorageProvider.databaseSchemas,
      directory: directory.path,
      name: 'test_${directory.path.hashCode}',
    );
    await app.isar.writeTxn(() => app.isar.settings.put(Settings()..id = 227));
  });
  tearDown(() async {
    await DatabaseWorker.instance.close();
    await app.isar.close(deleteFromDisk: true);
    await directory.delete(recursive: true);
  });

  Manga book(int id) =>
      Manga(
          source: 'test',
          author: '',
          artist: '',
          genre: [],
          imageUrl: '',
          lang: 'zh',
          link: '/$id',
          name: 'Test $id',
          status: Status.ongoing,
          description: '',
          sourceId: 1,
        )
        ..id = id
        ..clientId = id + 100000
        ..favorite = true;

  test('real database isolate reads 65000 chapters while UI timers advance', () async {
    final books = List.generate(1473, (i) => book(i + 1));
    final chapters = List.generate(
      65000,
      (i) => Chapter(
        id: i + 1,
        clientId: i + 200000,
        mangaId: (i % books.length) + 1,
        name: 'Chapter $i',
        url: '/chapter/$i',
        isRead: i % 3 == 0,
        scanlator: i % 2 == 0 ? 'A' : 'B',
      )..manga.value = books[i % books.length],
    );
    await app.isar.writeTxn(() async {
      await app.isar.mangas.putAll(books);
      await app.isar.chapters.putAll(chapters);
      for (final chapter in chapters) {
        await chapter.manga.save();
      }
    });
    // Start the worker before measuring, so startup alone cannot pass the test.
    await DatabaseWorker.instance.run<void>('barrier');
    var beats = 0;
    final delays = <int>[];
    final watch = Stopwatch()..start();
    var last = 0;
    final timer = Timer.periodic(const Duration(milliseconds: 5), (_) {
      final now = watch.elapsedMilliseconds;
      delays.add(now - last);
      last = now;
      beats++;
    });
    final rows = await DatabaseWorker.instance
        .run<Map<int, LibraryChapterSummary>>('summary');
    final changed = await DatabaseWorker.instance.run<ChangedRows>(
      'collect',
      0,
    );
    timer.cancel();
    watch.stop();
    expect(rows.length, 1473);
    expect(rows.values.fold<int>(0, (s, row) => s + row.total), 65000);
    expect(changed.chapters.length, 65000);
    expect(changed.chunked(5000).length, 13);
    expect(beats, greaterThan(2));
    // A generous CI bound still rejects multi-second main-isolate stalls.
    expect(delays.reduce((a, b) => a > b ? a : b), lessThan(1000));
    // ignore: avoid_print
    print(
      'BACKGROUND_LIBRARY_BENCHMARK rows=65000 titles=1473 elapsed_ms=${watch.elapsedMilliseconds} ui_ticks=$beats max_gap_ms=${delays.reduce((a, b) => a > b ? a : b)}',
    );
  }, timeout: const Timeout(Duration(minutes: 3)));

  test(
    'worker commits are visible and newer reader edits survive replay',
    () async {
      await app.isar.writeTxn(() => app.isar.mangas.put(book(1)));
      final payload = <String, dynamic>{
        'chapters': [
          {
            'clientId': 88,
            'mangaClientId': 100001,
            'name': 'one',
            'url': '/one',
            'updatedAt': 10,
            'isRead': false,
          },
        ],
      };
      await DatabaseWorker.instance.run<bool>('apply', payload);
      var chapter = await app.isar.chapters
          .filter()
          .clientIdEqualTo(88)
          .findFirst();
      expect(chapter, isNotNull);
      await app.isar.writeTxn(
        () => app.isar.chapters.put(
          chapter!
            ..isRead = true
            ..updatedAt = 20,
        ),
      );
      await DatabaseWorker.instance.run<bool>('apply', payload);
      chapter = await app.isar.chapters
          .filter()
          .clientIdEqualTo(88)
          .findFirst();
      expect(chapter!.isRead, true);
      expect(await app.isar.chapters.count(), 1);
    },
  );

  test(
    'client lookup uses its index and history exports the local chapter link',
    () async {
      await app.isar.writeTxn(() async {
        await app.isar.mangas.put(book(1));
        await app.isar.chapters.putAll([
          Chapter(
            id: 5,
            clientId: 90,
            mangaId: 1,
            name: 'correct',
            url: '/5',
            isRead: true,
          ),
          Chapter(id: 9, clientId: 5, mangaId: 1, name: 'other', url: '/9'),
        ]);
        await app.isar.historys.put(
          History(
            clientId: 77,
            itemType: ItemType.manga,
            chapterId: 5,
            mangaId: 1,
            date: '10',
          ),
        );
      });
      expect(chapterRepository.getByClientId(5)!.id, 9);
      final sourceOrder = await chapterRepository.watchByMangaId(1).first;
      expect(sourceOrder.map((chapter) => chapter.id), [5, 9]);
      final snapshot = await DatabaseWorker.instance.run<ChangedRows>(
        'collect',
        0,
      );
      expect(snapshot.histories.single['chapterClientId'], 90);
    },
  );

  test(
    'acknowledgement preserves a deletion edited during the upload',
    () async {
      final sent = ChangedPart(
        actionType: ActionType.removeChapter,
        clientId: 123,
        isarId: 7,
        data: 'old',
        clientDate: 10,
      );
      await app.isar.writeTxn(() => app.isar.changedParts.put(sent));
      final snapshot = (await app.isar.changedParts.get(sent.id!))!;
      await app.isar.writeTxn(
        () => app.isar.changedParts.put(
          sent
            ..data = 'new'
            ..clientDate = 11,
        ),
      );
      await changedPartRepository.clearAcknowledged([snapshot]);
      expect(await app.isar.changedParts.count(), 1);
      await changedPartRepository.clearAcknowledged([
        (await app.isar.changedParts.get(sent.id!))!,
      ]);
      expect(await app.isar.changedParts.count(), 0);
    },
  );

  test('Linovelib sync sends the catalogue label and preserves local storage names', () async {
    const url = 'https://tw.linovelib.com/novel/2013/72237.html';
    const oldName = '0263 | 第十五卷 第二話';
    const currentName = '0243 | 第十五卷 第二話';
    await app.isar.writeTxn(() async {
      await app.isar.mangas.put(
        book(1)
          ..itemType = ItemType.novel
          ..link = 'https://tw.linovelib.com/novel/2013.html',
      );
      await app.isar.chapters.put(
        Chapter(
          id: 1,
          clientId: 88,
          mangaId: 1,
          name: oldName,
          url: url,
          catalogName: currentName,
          updatedAt: 10,
        ),
      );
    });
    final snapshot = await DatabaseWorker.instance.run<ChangedRows>(
      'collect',
      0,
    );
    expect(snapshot.chapters.single['name'], currentName);
    await DatabaseWorker.instance.run<bool>('apply', {
      'chapters': [
        {
          'clientId': 88,
          'mangaClientId': 100001,
          'name': oldName,
          'url': url,
          'updatedAt': 20,
          'lastPageRead': '17',
          'isRead': true,
        },
      ],
    });
    var chapter = (await app.isar.chapters.get(1))!;
    expect(chapter.name, oldName);
    expect(chapter.displayName, currentName);
    expect(chapter.lastPageRead, '17');
    expect(chapter.isRead, true);

    await app.isar.writeTxn(
      () => app.isar.chapters.put(chapter..catalogName = null),
    );
    await DatabaseWorker.instance.run<bool>('apply', {
      'chapters': [
        {
          'clientId': 88,
          'mangaClientId': 100001,
          'name': currentName,
          'url': url,
          'updatedAt': 30,
          'lastPageRead': '17',
          'isRead': true,
        },
      ],
    });
    chapter = (await app.isar.chapters.get(1))!;
    expect(chapter.name, oldName);
    expect(chapter.displayName, currentName);
  });

  test(
    'new client IDs remain uploadable and do not reset reader progress',
    () async {
      await app.isar.writeTxn(() async {
        await app.isar.mangas.put(
          book(1)
            ..clientId = null
            ..updatedAt = 1,
        );
        await app.isar.chapters.put(
          Chapter(
            id: 1,
            mangaId: 1,
            name: 'one',
            url: '/one',
            isRead: true,
            isBookmarked: true,
            lastPageRead: '12',
            updatedAt: 1,
          ),
        );
      });
      final since = DateTime.now().millisecondsSinceEpoch;
      await DatabaseWorker.instance.run<void>('backfill');
      final first = (await app.isar.chapters.get(1))!;
      expect(first.clientId, isNotNull);
      expect(first.updatedAt, greaterThanOrEqualTo(since));
      expect(
        [first.isRead, first.isBookmarked, first.lastPageRead],
        [true, true, '12'],
      );
      final snapshot = await DatabaseWorker.instance.run<ChangedRows>(
        'collect',
        since,
      );
      expect(snapshot.chapters.single['clientId'], first.clientId);
      await DatabaseWorker.instance.run<void>('backfill');
      final again = (await app.isar.chapters.get(1))!;
      expect(
        [again.clientId, again.updatedAt],
        [first.clientId, first.updatedAt],
      );
    },
  );
}
