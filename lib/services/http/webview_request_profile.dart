/// Match the source's requested browser profile for both HTTP and page scripts.
/// A mobile reading site can otherwise serve incomplete desktop-layout text
/// even though its first request carried a mobile User-Agent header.
class WebviewRequestProfile {
  WebviewRequestProfile(Map<String, String> headers)
    : userAgent = _userAgent(headers);

  final String? userAgent;

  static String? _userAgent(Map<String, String> headers) {
    for (final entry in headers.entries) {
      if (entry.key.toLowerCase() == 'user-agent') {
        final value = entry.value.trim();
        return value.isEmpty ? null : value;
      }
    }
    return null;
  }

  bool get isMobile => RegExp(
    r'Android|iPhone|iPad|iPod|Mobile',
    caseSensitive: false,
  ).hasMatch(userAgent ?? '');

  double get width => isMobile ? 390 : -1;
  double get height => isMobile ? 844 : -1;
}
