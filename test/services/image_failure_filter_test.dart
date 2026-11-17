import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mangayomi/services/crash_report.dart';

void main() {
  test('a failed image download is not an app fault', () {
    final details = FlutterErrorDetails(
      exception: StateError('Failed to load https://example.test/cover.jpg'),
      library: 'image resource service',
    );
    expect(isImageLoadFailure(details), isTrue);
  });

  test('a widget build error still counts', () {
    final details = FlutterErrorDetails(
      exception: StateError('Null check operator used on a null value'),
      library: 'widgets library',
    );
    expect(isImageLoadFailure(details), isFalse);
  });
}
