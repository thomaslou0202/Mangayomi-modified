import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mangayomi/modules/novel/widgets/continuous_novel_reader.dart';

void main() {
  Future<void> show(
    WidgetTester tester,
    ScrollController scroll, {
    required Future<NovelChapterText> Function(int id) load,
    required List<NovelChapterPosition> positions,
    GlobalKey<ContinuousNovelReaderState>? readerKey,
    int count = 20,
    double initialProgress = 0,
  }) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: ContinuousNovelReader(
            key: readerKey,
            chapterIds: List.generate(count, (i) => i + 1),
            initial: const NovelChapterText(id: 1, html: '第一章'),
            initialProgress: initialProgress,
            controller: scroll,
            loadChapter: load,
            retryLabel: '重試',
            onPosition: positions.add,
            contentBuilder: (context, entry) => SizedBox(
              height: 2400,
              child: Text('正文 ${entry.id} ${entry.html}'),
            ),
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();
  }

  testWidgets(
    'appends one chapter with a compact separator and no early history switch',
    (tester) async {
      final scroll = ScrollController(), positions = <NovelChapterPosition>[];
      final next = Completer<NovelChapterText>(), calls = <int>[];
      await show(
        tester,
        scroll,
        load: (id) {
          calls.add(id);
          return next.future;
        },
        positions: positions,
      );
      expect(calls, isEmpty);
      scroll.jumpTo(1500);
      await tester.pump();
      await tester.pump();
      expect(calls, [2]);
      expect(positions.last.content.id, 1);
      scroll.jumpTo(1600);
      await tester.pump();
      expect(calls, [2]);
      next.complete(const NovelChapterText(id: 2, html: '第二章'));
      await tester.pumpAndSettle();
      scroll.jumpTo(1900);
      await tester.pumpAndSettle();
      expect(find.byKey(const ValueKey('chapter-separator-2')), findsOneWidget);
      expect(positions.last.content.id, 1);
      scroll.jumpTo(2500);
      await tester.pumpAndSettle();
      expect(positions.last.content.id, 2);
      expect(positions.last.offset, lessThan(200));
      await tester.pumpWidget(const SizedBox());
      scroll.dispose();
    },
  );

  testWidgets('failed next chapter keeps current text and supports retry', (
    tester,
  ) async {
    final scroll = ScrollController(), positions = <NovelChapterPosition>[];
    var requests = 0;
    await show(
      tester,
      scroll,
      positions: positions,
      count: 2,
      load: (id) async {
        if (++requests == 1) throw StateError('temporary network failure');
        return NovelChapterText(id: id, html: '重試成功');
      },
    );
    scroll.jumpTo(1700);
    await tester.pumpAndSettle();
    scroll.jumpTo(scroll.position.maxScrollExtent);
    await tester.pumpAndSettle();
    expect(find.textContaining('正文 1'), findsOneWidget);
    expect(find.text('重試'), findsOneWidget);
    await tester.tap(find.text('重試'));
    await tester.pumpAndSettle();
    expect(requests, 2);
    expect(find.textContaining('重試成功'), findsOneWidget);
    expect(tester.takeException(), isNull);
    await tester.pumpWidget(const SizedBox());
    scroll.dispose();
  });

  testWidgets('reading through many chapters keeps a bounded body cache', (
    tester,
  ) async {
    final scroll = ScrollController(), positions = <NovelChapterPosition>[];
    final key = GlobalKey<ContinuousNovelReaderState>(), calls = <int>[];
    await show(
      tester,
      scroll,
      positions: positions,
      readerKey: key,
      load: (id) async {
        calls.add(id);
        return NovelChapterText(id: id, html: '第$id章');
      },
    );
    for (var i = 0; i < 12; i++) {
      scroll.jumpTo(scroll.position.maxScrollExtent - 1);
      await tester.pumpAndSettle();
    }
    expect(positions.last.content.id, greaterThan(5));
    expect(key.currentState!.cachedBodyCount, lessThanOrEqualTo(5));
    expect(calls.toSet().length, calls.length);
    expect(tester.takeException(), isNull);
    await tester.pumpWidget(const SizedBox());
    scroll.dispose();
  });

  testWidgets(
    'restoring progress is relative to initial chapter, not prefetched content',
    (tester) async {
      final scroll = ScrollController(), positions = <NovelChapterPosition>[];
      await show(
        tester,
        scroll,
        positions: positions,
        initialProgress: 0.4,
        load: (id) async => NovelChapterText(id: id, html: '下一章'),
      );
      expect(
        scroll.offset,
        closeTo((2400 - scroll.position.viewportDimension) * 0.4, 2),
      );
      expect(positions.last.content.id, 1);
      await tester.pumpWidget(const SizedBox());
      scroll.dispose();
    },
  );

  testWidgets(
    'late prefetch response after closing cannot update disposed widgets',
    (tester) async {
      final scroll = ScrollController(), positions = <NovelChapterPosition>[];
      final pending = Completer<NovelChapterText>();
      await show(
        tester,
        scroll,
        positions: positions,
        load: (_) => pending.future,
      );
      scroll.jumpTo(1700);
      await tester.pump();
      await tester.pump();
      await tester.pumpWidget(const SizedBox());
      pending.complete(const NovelChapterText(id: 2, html: '晚到的正文'));
      await tester.pumpAndSettle();
      expect(tester.takeException(), isNull);
      scroll.dispose();
    },
  );
  testWidgets(
    'short chapters advance at the bottom without switching back on layout',
    (tester) async {
      final scroll = ScrollController(), positions = <NovelChapterPosition>[];
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ContinuousNovelReader(
              chapterIds: const [1, 2, 3],
              initial: const NovelChapterText(id: 1, html: '第一章'),
              controller: scroll,
              retryLabel: '重試',
              onPosition: positions.add,
              loadChapter: (id) async =>
                  NovelChapterText(id: id, html: '第$id章'),
              contentBuilder: (context, entry) => SizedBox(
                height: entry.id == 2 ? 100 : 2400,
                child: Text(entry.html),
              ),
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();
      scroll.jumpTo(1700);
      await tester.pumpAndSettle();
      scroll.jumpTo(scroll.position.maxScrollExtent);
      await tester.pumpAndSettle();
      expect(positions.last.content.id, 2);
      expect(positions.last.offset, positions.last.extent);
      scroll.jumpTo(1000);
      await tester.pumpAndSettle();
      expect(positions.last.content.id, 1);
      await tester.pumpWidget(const SizedBox());
      scroll.dispose();
    },
  );
}
