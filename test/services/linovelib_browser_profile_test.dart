import 'package:flutter_test/flutter_test.dart';
import 'package:mangayomi/services/http/linovelib_browser_profile.dart';

void main() {
  const agent =
      'Mozilla/5.0 (Linux; Android 13) AppleWebKit/537.36 '
      '(KHTML, like Gecko) Chrome/130.0.0.0 Mobile Safari/537.36';

  test('phone emulation is limited to public Linovelib chapter URLs', () {
    expect(
      LinovelibBrowserProfile.supports(
        'https://tw.linovelib.com/novel/2013/72242_2.html',
        agent,
      ),
      isTrue,
    );
    for (final url in [
      'https://other.test/novel/2013/72242_2.html',
      'https://tw.linovelib.com/novel/2013.html',
      'https://tw.linovelib.com/novel/2013/catalog',
      'http://tw.linovelib.com/novel/2013/72242_2.html',
      'https://user@tw.linovelib.com/novel/2013/72242_2.html',
      'https://tw.linovelib.com:8080/novel/2013/72242_2.html',
    ]) {
      expect(LinovelibBrowserProfile.supports(url, agent), isFalse);
    }
    expect(
      LinovelibBrowserProfile.supports(
        'https://tw.linovelib.com/novel/2013/72242_2.html',
        'Mozilla/5.0 (Windows NT 10.0) Chrome/130',
      ),
      isFalse,
    );
  });

  test('HTTP identity and JavaScript Client Hints describe the same phone', () {
    final settings = LinovelibBrowserProfile.userAgentOverride(agent);
    expect(settings['userAgent'], agent);
    expect(settings['platform'], startsWith('Linux'));
    final hints = settings['userAgentMetadata'] as Map;
    expect(hints['platform'], 'Android');
    expect(hints['platformVersion'], '13');
    expect(hints['mobile'], isTrue);
    expect(hints['fullVersion'], '130.0.0.0');
    expect(
      (hints['brands'] as List).every((b) => b['version'] == '130'),
      isTrue,
    );
  });
}
