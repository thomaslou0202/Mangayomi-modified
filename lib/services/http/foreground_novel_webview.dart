import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class ForegroundNovelWebView {
  static const requestHeader = 'x-mangayomi-foreground-novel';
  static final _path = RegExp(r'^/novel/(\d+/\d+)(?:_\d+)?\.html$');
  static final _readers = <Object, (String, bool Function())>{};
  static bool _busy = false;

  static String? chapterKey(String? url) {
    final uri = url == null ? null : Uri.tryParse(url);
    if (uri == null ||
        uri.scheme != 'https' ||
        uri.host != 'tw.linovelib.com' ||
        uri.userInfo.isNotEmpty ||
        uri.port != 443) {
      return null;
    }
    return _path.firstMatch(uri.path)?.group(1);
  }

  static void register(Object owner, String? url, bool Function() isCurrent) {
    final key = chapterKey(url);
    if (key != null) _readers[owner] = (key, isCurrent);
  }

  static void unregister(Object owner) => _readers.remove(owner);

  static bool canCapture(String url) {
    final key = chapterKey(url);
    return Platform.isWindows &&
        !_busy &&
        key != null &&
        _readers.values.any((reader) => reader.$1 == key && reader.$2());
  }

  static Future<String> capture({
    required String url,
    required List<String> scripts,
    required WebViewEnvironment? environment,
    required String? userAgent,
  }) async {
    String reply(String kind) => jsonEncode({'kind': kind, 'url': url});
    if (!canCapture(url)) {
      return reply('reader-foreground-unavailable');
    }
    _busy = true;
    final browser = _NovelCaptureBrowser(url, scripts, environment);
    try {
      await browser.openUrlRequest(
        urlRequest: URLRequest(url: WebUri(url)),
        settings: InAppBrowserClassSettings(
          browserSettings: InAppBrowserSettings(
            presentationStyle: ModalPresentationStyle.POPOVER,
          ),
          webViewSettings: InAppWebViewSettings(
            userAgent: userAgent,
            useShouldOverrideUrlLoading: true,
          ),
        ),
      );
      return await browser.result.future.timeout(
        const Duration(seconds: 35),
        onTimeout: () => reply('reader-incomplete'),
      );
    } finally {
      try {
        if (!browser.exited && browser.isOpened()) await browser.close();
        if (!browser.exited) browser.dispose();
      } finally {
        _busy = false;
      }
    }
  }
}

class _NovelCaptureBrowser extends InAppBrowser {
  _NovelCaptureBrowser(this.url, this.scripts, WebViewEnvironment? environment)
    : super(webViewEnvironment: environment);

  final String url;
  final List<String> scripts;
  final result = Completer<String>();
  bool exited = false;

  void _finish(String value) {
    if (!result.isCompleted) result.complete(value);
  }

  @override
  Future<void> onBrowserCreated() async {
    webViewController?.addJavaScriptHandler(
      handlerName: 'setResponse',
      callback: (args) async {
        if (result.isCompleted) return;
        final actual = await webViewController?.getUrl();
        if (actual?.toString() == url && args.firstOrNull is String) {
          _finish(args.first as String);
        }
      },
    );
  }

  @override
  Future<void> onLoadStop(WebUri? loaded) async {
    if (loaded?.toString() != url) return;
    for (final script in scripts) {
      await webViewController?.evaluateJavascript(source: script);
    }
  }

  @override
  Future<NavigationActionPolicy> shouldOverrideUrlLoading(
    NavigationAction action,
  ) async => action.isForMainFrame && action.request.url?.toString() != url
      ? NavigationActionPolicy.CANCEL
      : NavigationActionPolicy.ALLOW;

  @override
  void onExit() {
    exited = true;
    _finish(jsonEncode({'kind': 'reader-foreground-cancelled', 'url': url}));
  }
}
