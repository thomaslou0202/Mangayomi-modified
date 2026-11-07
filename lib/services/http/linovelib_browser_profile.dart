import 'dart:convert';

/// Keep a Windows phone-sized reader consistent at both HTTP and DOM level.
/// A User-Agent override alone leaves WebView2's Client Hints on Windows.
class LinovelibBrowserProfile {
  static bool supports(String url, String? userAgent) {
    final uri = Uri.tryParse(url);
    return uri != null &&
        uri.scheme == 'https' &&
        uri.host == 'tw.linovelib.com' &&
        uri.userInfo.isEmpty &&
        uri.port == 443 &&
        RegExp(r'^/novel/\d+/\d+(?:_\d+)?\.html$').hasMatch(uri.path) &&
        RegExp(r'Android.*Chrome/[\d.]+.*Mobile').hasMatch(userAgent ?? '');
  }

  static Map<String, dynamic> userAgentOverride(String userAgent) {
    final chrome = RegExp(r'Chrome/([\d.]+)').firstMatch(userAgent)!.group(1)!;
    final android =
        RegExp(r'Android ([\d.]+)').firstMatch(userAgent)?.group(1) ?? '13';
    final version = chrome.split('.').first;
    return {
      'userAgent': userAgent,
      'platform': 'Linux armv8l',
      'userAgentMetadata': {
        'brands': [
          {'brand': 'Chromium', 'version': version},
          {'brand': 'Google Chrome', 'version': version},
        ],
        'fullVersion': chrome,
        'platform': 'Android',
        'platformVersion': android,
        'architecture': 'arm',
        'model': '',
        'mobile': true,
      },
    };
  }

  static const metrics = <String, dynamic>{
    'width': 390,
    'height': 844,
    'deviceScaleFactor': 1,
    'mobile': true,
  };

  /// Start at DOM readiness rather than waiting for every advertisement to load.
  /// The source still validates reader parameters, visible text and pagination.
  static String captureAtDomReady(List<String> scripts) =>
      '''
(() => {
  let tries = 0;
  function run() {
    if (document.readyState === 'loading' ||
        typeof window.flutter_inappwebview?.callHandler !== 'function') {
      if (++tries < 200) setTimeout(run, 100);
      return;
    }
    ${scripts.map((script) => 'try {\n$script\n} catch (_) {}').join('\n')}
  }
  run();
})();
''';

  static String unsupported(String url) =>
      jsonEncode({'kind': 'reader-profile-unavailable', 'url': url});
}
