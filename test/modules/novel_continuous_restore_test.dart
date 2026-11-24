import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mangayomi/modules/novel/widgets/continuous_novel_reader.dart';

void main() {
  Future<({ScrollController scroll, List<NovelChapterPosition> positions})>
  open(
    WidgetTester tester, {
    required ValueNotifier<double> firstHeight,
    double initialProgress = 0,
    Map<int, double> heights = const {},
    int count = 4,
    GlobalKey<ContinuousNovelReaderState>? key,
  }) async {
    final scroll = ScrollController(), positions = <NovelChapterPosition>[];
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: ContinuousNovelReader(
            key: key,
            chapterIds: List.generate(count, (i) => i + 1),
            initial: const NovelChapterText(id: 1, html: '1'),
            initialProgress: initialProgress,
            controller: scroll,
            loadChapter: (id) async => NovelChapterText(id: id, html: '$id'),
            retryLabel: '重試',
            onPosition: positions.add,
            contentBuilder: (context, entry) => entry.id == 1
                ? ValueListenableBuilder<double>(
                    valueListenable: firstHeight,
                    builder: (_, h, _) =>
                        SizedBox(height: h, child: const Text('第一章')),
                  )
                : SizedBox(
                    height: heights[entry.id] ?? 3000,
                    child: Text('第${entry.id}章'),
                  ),
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();
    return (scroll: scroll, positions: positions);
  }

  for (final (label, before, after) in [
    ('grows', 2000.0, 6000.0),
    ('shrinks', 9000.0, 3000.0),
  ]) {
    testWidgets('saved progress survives the opening chapter that $label', (
      tester,
    ) async {
      final height = ValueNotifier(before);
      final r = await open(tester, firstHeight: height, initialProgress: 0.5);
      height.value = after;
      await tester.pumpAndSettle();
      // The viewport is 600 px tall in tests.
      expect(r.scroll.offset, closeTo(0.5 * (after - 600), 1));
      final last = r.positions.last;
      expect(last.content.id, 1);
      expect(last.offset / last.extent, closeTo(0.5, 0.01));
      await tester.pumpWidget(const SizedBox());
      r.scroll.dispose();
    });
  }

  testWidgets(
    'once the reader scrolls, a later height change does not move them',
    (tester) async {
      final height = ValueNotifier(4000.0);
      final r = await open(tester, firstHeight: height, initialProgress: 0.5);
      r.scroll.jumpTo(300);
      await tester.pumpAndSettle();
      height.value = 8000;
      await tester.pumpAndSettle();
      expect(r.scroll.offset, 300);
      await tester.pumpWidget(const SizedBox());
      r.scroll.dispose();
    },
  );

  testWidgets(
    'reading on keeps only a few chapters in the list and never jumps',
    (tester) async {
      final key = GlobalKey<ContinuousNovelReaderState>();
      final r = await open(
        tester,
        firstHeight: ValueNotifier(2500),
        count: 10,
        key: key,
      );
      var maxInList = 0;
      for (var step = 0; step < 300; step++) {
        r.scroll.jumpTo(
          (r.scroll.offset + 70).clamp(0, r.scroll.position.maxScrollExtent),
        );
        await tester.pump();
        await tester.pump();
        final inList = key.currentState!.chaptersInList;
        if (inList > maxInList) maxInList = inList;
      }
      expect(maxInList, lessThanOrEqualTo(4));
      // Reading on only ever moves forward: chapter by chapter, and within a
      // chapter down the page. A chapter leaving the list must not show up as
      // a jump back or ahead.
      for (var i = 1; i < r.positions.length; i++) {
        final a = r.positions[i - 1], b = r.positions[i];
        expect(b.content.id, greaterThanOrEqualTo(a.content.id));
        if (a.content.id == b.content.id) {
          expect(b.offset, greaterThanOrEqualTo(a.offset - 0.5));
        }
      }
      expect(r.positions.last.content.id, greaterThanOrEqualTo(7));
      expect(
        r.scroll.offset,
        lessThan(4 * 3100),
        reason: 'the list stays short',
      );
      await tester.pumpWidget(const SizedBox());
      r.scroll.dispose();
    },
  );
}
