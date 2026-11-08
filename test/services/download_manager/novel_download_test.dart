import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:mangayomi/services/download_manager/novel_download.dart';

void main() {
  late Directory directory;
  late File file;
  setUp(() async {
    directory = await Directory.systemTemp.createTemp('novel-download-');
    file = File('${directory.path}/chapter.html');
  });
  tearDown(() => directory.delete(recursive: true));

  test(
    'uses extension content and replaces a leftover incomplete HTML file',
    () async {
      await file.writeAsString('');
      final response = jsonEncode('<p>第一段</p><p>第二段</p>');
      await saveNovelDownload(
        file: file,
        load: () async => response,
        isCancelled: () => false,
      );
      expect(await file.readAsString(), response);
      expect(await File('${file.path}.part').exists(), false);
    },
  );

  test(
    'does not report or expose a completed chapter while the source is pending',
    () async {
      final content = Completer<String>();
      final download = saveNovelDownload(
        file: file,
        load: () => content.future,
        isCancelled: () => false,
      );
      expect(await file.exists(), false);
      content.complete('<p>完整正文</p>');
      await download;
      expect(await file.readAsString(), '<p>完整正文</p>');
    },
  );

  test(
    'empty and non-content results fail without publishing a file',
    () async {
      for (final response in [
        '',
        ' ',
        '""',
        'null',
        'undefined',
        '<div> </div>',
        '<script>text</script>',
      ]) {
        await expectLater(
          saveNovelDownload(
            file: file,
            load: () async => response,
            isCancelled: () => false,
          ),
          throwsFormatException,
        );
        expect(await file.exists(), false);
      }
    },
  );

  test('illustration-only chapters remain valid', () async {
    const content = '<p><img src="https://example.com/illustration.jpg"></p>';
    await saveNovelDownload(
      file: file,
      load: () async => content,
      isCancelled: () => false,
    );
    expect(await file.readAsString(), content);
  });

  test(
    'failed retrieval preserves a previous copy and can be retried',
    () async {
      await file.writeAsString('<p>既有正文</p>');
      await expectLater(
        saveNovelDownload(
          file: file,
          load: () async => throw const SocketException('offline'),
          isCancelled: () => false,
        ),
        throwsA(isA<SocketException>()),
      );
      expect(await file.readAsString(), '<p>既有正文</p>');
      await saveNovelDownload(
        file: file,
        load: () async => '<p>重新下載</p>',
        isCancelled: () => false,
      );
      expect(await file.readAsString(), '<p>重新下載</p>');
    },
  );

  test(
    'cancel before or during source retrieval does not publish content',
    () async {
      var called = false;
      await saveNovelDownload(
        file: file,
        load: () async {
          called = true;
          return '<p>正文</p>';
        },
        isCancelled: () => true,
      );
      expect(called, false);
      final content = Completer<String>();
      var cancelled = false;
      final download = saveNovelDownload(
        file: file,
        load: () => content.future,
        isCancelled: () => cancelled,
      );
      cancelled = true;
      content.complete('<p>正文</p>');
      await download;
      expect(await file.exists(), false);
    },
  );
}
