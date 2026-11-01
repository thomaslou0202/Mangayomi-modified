import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mangayomi/modules/manga/reader/widgets/reader_leading_boundary.dart';
import 'package:mangayomi/modules/manga/reader/utils/reader_start_position.dart';

void main() {
  test(
    'backward entry overrides saved/read position and clamps stale indexes',
    () {
      expect(readerStartPage(pageCount: 55, savedIndex: 0, fromEnd: true), 54);
      expect(readerStartPage(pageCount: 55, savedIndex: 20, fromEnd: true), 54);
      expect(
        readerStartPage(pageCount: 55, savedIndex: 20, fromEnd: false),
        20,
      );
      expect(readerStartPage(pageCount: 5, savedIndex: 100, fromEnd: false), 4);
      expect(readerStartPage(pageCount: 5, savedIndex: -1, fromEnd: false), 0);
      expect(readerStartPage(pageCount: 1, savedIndex: 0, fromEnd: true), 0);
      expect(readerStartPage(pageCount: 0, savedIndex: 4, fromEnd: true), 0);
    },
  );
  for (final axis in Axis.values) {
    for (final reverse in [false, true]) {
      testWidgets(
        'backward boundary opens previous tail: $axis reverse=$reverse',
        (tester) async {
          var opened = 0;
          final controller = PageController();
          await tester.pumpWidget(
            MaterialApp(
              home: SizedBox.expand(
                child: ReaderLeadingBoundary(
                  onPrevious: () => opened++,
                  child: PageView(
                    controller: controller,
                    scrollDirection: axis,
                    reverse: reverse,
                    physics: const ClampingScrollPhysics(),
                    children: const [
                      ColoredBox(color: Colors.red),
                      ColoredBox(color: Colors.blue),
                    ],
                  ),
                ),
              ),
            ),
          );
          final distance = reverse ? -220.0 : 220.0;
          await tester.drag(
            find.byType(PageView),
            axis == Axis.horizontal ? Offset(distance, 0) : Offset(0, distance),
          );
          await tester.pumpAndSettle();
          expect(opened, 1);
          // Moving forward within the chapter never opens the previous one.
          controller.jumpToPage(1);
          await tester.pumpAndSettle();
          await tester.drag(
            find.byType(PageView),
            axis == Axis.horizontal ? Offset(distance, 0) : Offset(0, distance),
          );
          await tester.pumpAndSettle();
          expect(opened, 1);
          await tester.pumpWidget(const SizedBox());
          controller.dispose();
        },
      );
    }
  }
  testWidgets(
    'first book chapter and zoomed reader can disable backward navigation',
    (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: ReaderLeadingBoundary(
            child: PageView(
              physics: const ClampingScrollPhysics(),
              children: const [SizedBox.expand()],
            ),
          ),
        ),
      );
      await tester.drag(find.byType(PageView), const Offset(240, 0));
      await tester.pumpAndSettle();
      expect(tester.takeException(), isNull);
    },
  );
  testWidgets(
    'vertical continuous reader can pull back into previous chapter',
    (tester) async {
      var opened = 0;
      await tester.pumpWidget(
        MaterialApp(
          home: ReaderLeadingBoundary(
            onPrevious: () => opened++,
            child: ListView(
              physics: const ClampingScrollPhysics(),
              children: const [SizedBox(height: 2000)],
            ),
          ),
        ),
      );
      await tester.drag(find.byType(ListView), const Offset(0, 240));
      await tester.pumpAndSettle();
      expect(opened, 1);
    },
  );
}
