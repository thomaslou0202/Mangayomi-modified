import 'package:flutter_test/flutter_test.dart';
import 'package:mangayomi/services/http/webview_request_profile.dart';

void main() {
  test(
    'mobile source headers also select a phone-sized background WebView',
    () {
      for (final agent in [
        'Mozilla/5.0 (Linux; Android 13) Chrome/130 Mobile Safari/537.36',
        'Mozilla/5.0 (iPhone; CPU iPhone OS 18_0 like Mac OS X)',
        'Mozilla/5.0 (iPad; CPU OS 18_0 like Mac OS X)',
      ]) {
        final profile = WebviewRequestProfile({'User-Agent': agent});
        expect(profile.userAgent, agent);
        expect(profile.isMobile, isTrue);
        expect(profile.width, 390);
        expect(profile.height, 844);
      }
    },
  );
  test('desktop sources retain the default WebView dimensions', () {
    const agent = 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) Chrome/130';
    final profile = WebviewRequestProfile({'User-Agent': agent});
    expect(profile.userAgent, agent);
    expect(profile.isMobile, isFalse);
    expect(profile.width, -1);
    expect(profile.height, -1);
  });
  test(
    'header spelling is case insensitive and unrelated headers stay intact',
    () {
      final headers = {
        'uSeR-aGeNt': '  Android Mobile  ',
        'Referer': 'https://example.test/',
      };
      final profile = WebviewRequestProfile(headers);
      expect(profile.userAgent, 'Android Mobile');
      expect(profile.width, 390);
      expect(headers['uSeR-aGeNt'], '  Android Mobile  ');
      expect(headers['Referer'], 'https://example.test/');
    },
  );
  test('missing and blank agents keep platform defaults', () {
    for (final headers in [
      <String, String>{},
      {'User-Agent': '  '},
    ]) {
      final profile = WebviewRequestProfile(headers);
      expect(profile.userAgent, isNull);
      expect(profile.width, -1);
      expect(profile.height, -1);
    }
  });
}
