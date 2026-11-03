import 'dart:async';
import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:isar_community/isar.dart';
import 'package:mangayomi/eval/model/m_chapter.dart';
import 'package:mangayomi/eval/model/m_manga.dart';
import 'package:mangayomi/main.dart' as app;
import 'package:mangayomi/models/chapter.dart';
import 'package:mangayomi/models/manga.dart';
import 'package:mangayomi/models/source.dart';
import 'package:mangayomi/modules/manga/detail/providers/update_manga_detail_providers.dart';
import 'package:mangayomi/services/get_detail.dart';
import 'package:mangayomi/providers/storage_provider.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  late Directory directory;
  const bookId = 1546;
  final provider = updateMangaDetailProvider(
    mangaId: bookId,
    isInit: true,
    showToast: false,
  );

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
    directory = await Directory.systemTemp.createTemp('detail_lifecycle_');
    app.isar = await Isar.open(
      StorageProvider.databaseSchemas,
      directory: directory.path,
      name: 'detail_${directory.path.hashCode}',
    );
    await app.isar.writeTxn(() async {
      await app.isar.sources.put(
        Source(
          id: 1827634459,
          name: '起點中文網（測試版）',
          lang: 'zh',
          baseUrl: 'https://m.qidian.com',
          isAdded: true,
          itemType: ItemType.novel,
          sourceCode: 'test source',
        ),
      );
      await app.isar.mangas.put(
        Manga(
          id: bookId,
          sourceId: 1827634459,
          source: '起點中文網（測試版）',
          lang: 'zh',
          link: 'https://m.qidian.com/book/123/',
          name: '載入中',
          itemType: ItemType.novel,
          author: '',
          artist: '',
          genre: const [],
          imageUrl: '',
          status: Status.unknown,
          description: '',
        ),
      );
    });
  });
  tearDown(() async {
    await app.isar.close(deleteFromDisk: true);
    await directory.delete(recursive: true);
  });

  MManga detail(String title) => MManga(
    name: title,
    author: '作者',
    description: '測試作品',
    chapters: List.generate(
      6,
      (i) => MChapter(
        name: '${(6 - i).toString().padLeft(4, '0')}｜章節',
        url: 'https://m.qidian.com/chapter/123/${6 - i}/',
      ),
    ),
  );

  // read(...future) is exactly how the detail page starts this operation.
  // Advancing the event loop exposes auto-disposal during async DB/network IO.
  test(
    'read-only caller completes after frames and releases its providers',
    () async {
      final response = Completer<MManga>();
      var requests = 0;
      var childDisposed = false;
      final container = ProviderContainer(
        overrides: [
          getDetailProvider.overrideWith((ref, argument) {
            requests++;
            ref.onDispose(() => childDisposed = true);
            return response.future;
          }),
        ],
      );
      addTearDown(container.dispose);
      final future = container.read(provider.future);
      final outcome = future.then<Object?>(
        (_) => null,
        onError: (Object e) => e,
      );
      await Future<void>.delayed(const Duration(milliseconds: 80));
      response.complete(detail('完整作品'));
      expect(await outcome.timeout(const Duration(seconds: 10)), isNull);
      expect(requests, 1);
      expect(app.isar.mangas.getSync(bookId)?.name, '完整作品');
      expect(await app.isar.chapters.count(), 6);
      await container.pump();
      await container.pump();
      expect(container.exists(provider), isFalse);
      expect(childDisposed, isTrue);
    },
  );

  test('leaving the page does not discard its pending catalogue', () async {
    final started = Completer<void>();
    final response = Completer<MManga>();
    final container = ProviderContainer(
      overrides: [
        getDetailProvider.overrideWith((ref, argument) {
          started.complete();
          return response.future;
        }),
      ],
    );
    addTearDown(container.dispose);
    final subscription = container.listen(provider, (_, _) {});
    final future = container.read(provider.future);
    await started.future.timeout(const Duration(seconds: 5));
    subscription.close();
    await container.pump();
    response.complete(detail('離頁後完成'));
    await future;
    expect(app.isar.mangas.getSync(bookId)?.name, '離頁後完成');
    expect(await app.isar.chapters.count(), 6);
  });

  test(
    'invalidation discards an old response without overwriting new detail',
    () async {
      final responses = [Completer<MManga>(), Completer<MManga>()];
      var requests = 0;
      final container = ProviderContainer(
        overrides: [
          getDetailProvider.overrideWith(
            (ref, argument) => responses[requests++].future,
          ),
        ],
      );
      addTearDown(container.dispose);
      final old = container.read(provider.future);
      final oldOutcome = old.then<Object?>(
        (_) => null,
        onError: (Object e) => e,
      );
      await Future<void>.delayed(const Duration(milliseconds: 80));
      container.invalidate(provider);
      final current = container.read(provider.future);
      await Future<void>.delayed(const Duration(milliseconds: 80));
      responses[1].complete(detail('新回應'));
      await current;
      responses[0].complete(detail('過期回應'));
      await oldOutcome;
      await Future<void>.delayed(const Duration(milliseconds: 80));
      expect(requests, 2);
      expect(app.isar.mangas.getSync(bookId)?.name, '新回應');
    },
  );

  test(
    'container teardown prevents a delayed response from writing data',
    () async {
      final started = Completer<void>();
      final response = Completer<MManga>();
      final container = ProviderContainer(
        overrides: [
          getDetailProvider.overrideWith((ref, argument) {
            started.complete();
            return response.future;
          }),
        ],
      );
      final outcome = container
          .read(provider.future)
          .then<Object?>((_) => null, onError: (Object e) => e);
      await started.future.timeout(const Duration(seconds: 5));
      container.dispose();
      response.complete(detail('應忽略'));
      await outcome;
      await Future<void>.delayed(const Duration(milliseconds: 80));
      expect(app.isar.mangas.getSync(bookId)?.name, '載入中');
      expect(await app.isar.chapters.count(), 0);
    },
  );

  test(
    'a real source failure is propagated and a later call can retry',
    () async {
      var requests = 0;
      final container = ProviderContainer(
        overrides: [
          getDetailProvider.overrideWith((ref, argument) async {
            requests++;
            await Future<void>.delayed(const Duration(milliseconds: 80));
            if (requests == 1) throw StateError('source unavailable');
            return detail('重試成功');
          }),
        ],
      );
      addTearDown(container.dispose);
      await expectLater(container.read(provider.future), throwsStateError);
      await container.pump();
      await container.pump();
      await container.read(provider.future);
      expect(requests, 2);
      expect(app.isar.mangas.getSync(bookId)?.name, '重試成功');
    },
  );
}
