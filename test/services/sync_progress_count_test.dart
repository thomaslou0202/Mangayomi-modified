import 'package:flutter_test/flutter_test.dart';
import 'package:mangayomi/services/sync_server.dart';

void main() {
  test('deletions count toward progress, as they do in totalCounts', () {
    final response = <String, dynamic>{
      'manga': [{}, {}],
      'chapters': [{}, {}, {}],
      'histories': [],
      'tombstones': {
        'chapters': [1, 2, 3, 4],
        'manga': [9],
        'categories': [],
      },
    };
    expect(syncResponseRowCount(response), 10);
  });

  test('a response without deletions or pages counts nothing', () {
    expect(syncResponseRowCount(<String, dynamic>{'syncedAt': 1}), 0);
  });
}
