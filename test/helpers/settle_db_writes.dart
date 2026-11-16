import 'package:flutter_test/flutter_test.dart';
import 'package:mangayomi/repositories/db_write_queue.dart';

/// Lets queued database writes finish inside a widget test.
///
/// Repository writes run as Isar background transactions. A widget test's
/// fake clock never moves those along, so this alternates a little real time
/// with a pump until the write queue is empty.
Future<void> settleDbWrites(WidgetTester tester) async {
  for (var i = 0; i < 200 && !dbWriteQueue.isIdle; i++) {
    await tester.runAsync(
      () => Future<void>.delayed(const Duration(milliseconds: 10)),
    );
    await tester.pump();
  }
  expect(dbWriteQueue.isIdle, isTrue, reason: 'database writes did not finish');
}
