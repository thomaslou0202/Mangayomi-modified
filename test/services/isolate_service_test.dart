import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mangayomi/models/source.dart';
import 'package:mangayomi/services/http/m_client.dart';
import 'package:mangayomi/services/isolate_service.dart';

void main() {
  group('runsInWorkerIsolate', () {
    Source sourceIn(SourceCodeLanguage language) =>
        Source()..sourceCodeLanguage = language;

    test('moves every extension type except Aidoku off the root isolate', () {
      for (final language in SourceCodeLanguage.values) {
        expect(
          runsInWorkerIsolate(sourceIn(language)),
          language != SourceCodeLanguage.aidoku,
          reason: '$language',
        );
      }
    });
  });

  group('Cloudflare alert from a worker isolate', () {
    tearDown(() => cloudflareAlertForwarder = null);

    test('is handed to the forwarder instead of a toast', () async {
      final forwarded = <(String?, int)>[];
      cloudflareAlertForwarder = (url, status) => forwarded.add((url, status));

      final request = http.Request(
        'GET',
        Uri.parse('https://example.com/book/1'),
      );
      final response = http.Response(
        '<html>challenge</html>',
        403,
        headers: {'cf-mitigated': 'challenge'},
        request: request,
      );

      final returned = await LoggerInterceptor(
        true,
      ).interceptResponse(response: response);

      expect(returned, same(response));
      expect(forwarded, [('https://example.com/book/1', 403)]);
    });

    test('is not raised for an ordinary response', () async {
      final forwarded = <(String?, int)>[];
      cloudflareAlertForwarder = (url, status) => forwarded.add((url, status));

      await LoggerInterceptor(true).interceptResponse(
        response: http.Response(
          'ok',
          200,
          request: http.Request('GET', Uri.parse('https://example.com/')),
        ),
      );

      expect(forwarded, isEmpty);
    });
  });
}
