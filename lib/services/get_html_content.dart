import 'package:flutter/foundation.dart' show compute, visibleForTesting;
import 'dart:io';

import 'package:mangayomi/src/rust/api/epub.dart';
import 'package:html/parser.dart';
import 'package:mangayomi/services/isolate_service.dart';
import 'package:mangayomi/models/chapter.dart';
import 'package:mangayomi/services/local_folders.dart';
import 'package:mangayomi/providers/browse_state_provider.dart';
import 'package:mangayomi/providers/storage_provider.dart';
import 'package:mangayomi/utils/utils.dart';
import 'package:mangayomi/modules/novel/utils/novel_content.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:mangayomi/utils/log/logger.dart';
part 'get_html_content.g.dart';

@riverpod
Future<(String, EpubNovel?)> getHtmlContent(
  Ref ref, {
  required Chapter chapter,
}) async {
  final keepAlive = ref.keepAlive();
  (String, EpubNovel?)? result;
  try {
    if (!chapter.manga.isLoaded) {
      chapter.manga.loadSync();
    }
    if (chapter.archivePath != null && chapter.archivePath!.isNotEmpty) {
      final archivePath = await resolveLocalArchivePath(chapter.archivePath!);
      try {
        final book = await parseEpubFromPath(
          epubPath: archivePath,
          fullData: true,
        );
        String htmlContent = "";
        if (chapter.url != null && chapter.url!.isNotEmpty) {
          // Load specific chapter by its spine idref
          final matches = book.chapters.where((c) => c.path == chapter.url);
          if (matches.isNotEmpty) {
            htmlContent = matches.first.content;
          } else {
            // Fallback: try via Rust direct access
            htmlContent = await getChapterContent(
              epubPath: archivePath,
              chapterPath: chapter.url!,
            );
          }
        } else {
          // Legacy: no chapter url, concatenate all (old single-chapter imports)
          for (var subChapter in book.chapters) {
            htmlContent += "\n<hr/>\n${subChapter.content}";
          }
        }
        result = (htmlContent, book);
      } catch (e, st) {
        // Swallowed, so the reader shows the not-found placeholder below with
        // no clue that parsing was what actually failed.
        AppLogger.log(
          'getHtmlContent: epub parse failed: $e\n$st',
          logLevel: LogLevel.error,
        );
      }

      result ??= ("Local epub file not found!", null);
    }
    if (result == null) {
      final storageProvider = StorageProvider();
      final mangaMainDirectory = await storageProvider.getMangaMainDirectory(
        chapter,
      );
      final chapterDirectory = (await storageProvider.getMangaChapterDirectory(
        chapter,
        mangaMainDirectory: mangaMainDirectory,
      ))!;

      // Locate the downloaded file by globbing for the single *.html in the
      // chapter directory rather than reconstructing its name. The downloader
      // sanitises forbidden characters to spaces while getMangaChapterDirectory
      // uses underscores, and the old lookup used the raw chapter.name, so any
      // title containing a colon (etc.) never matched: htmlFile.exists() was
      // always false and offline reading fell through to the network and hung.
      // A folder holds exactly one file, so a glob is correct regardless of
      // which sanitiser wrote it. See #817.
      File? localFile;
      if (chapterDirectory.existsSync()) {
        for (final entity in chapterDirectory.listSync()) {
          if (entity is File && entity.path.toLowerCase().endsWith('.html')) {
            localFile = entity;
            break;
          }
        }
      }

      if (localFile != null) {
        // Downloaded: render straight from disk, so it works fully offline with
        // no extension service or network. The file holds the raw getHtmlContent
        // output (quote-wrapped, like the network path); routing it back through
        // cleanHtmlContent renders a blank page, so strip the outer quotes and
        // hand it to buildNovelHtml directly.
        final raw = await localFile.readAsString();
        final stripped = decodeNovelHtmlResponse(raw);
        result = (stripped, null);
      } else {
        // Not downloaded: fetch from the source (needs network).
        final source = getSource(
          chapter.manga.value!.lang!,
          chapter.manga.value!.source!,
          chapter.manga.value!.sourceId,
          installedOnly: true,
        );
        if (!ref.mounted) return ('', null);
        final proxyServer = ref.read(androidProxyServerStateProvider);
        // In the worker pool: evaluating the extension and parsing the page
        // on the root isolate froze the reader while a chapter opened.
        final html = await getIsolateService.get<String>(
          source: source!,
          serviceType: 'getHtmlContent',
          query: chapter.manga.value!.name!,
          url: chapter.url!,
          proxyServer: proxyServer,
        );
        final stripped = decodeNovelHtmlResponse(html);
        result = (stripped, null);
      }
    }

    // Both passes parse the whole chapter. In the continuous reader the next
    // chapter loads while the reader scrolls, and parsing it on the UI thread
    // stalled the scroll.
    final html = await compute(_processNovelHtml, (
      result.$1,
      chapter.manga.value?.name ?? '',
      chapter.name ?? '',
    ));
    keepAlive.close();
    return (html, result.$2);
  } catch (e) {
    keepAlive.close();
    rethrow;
  }
}

/// The reader's HTML for a chapter's raw [args].$1, without the book title
/// ([args].$2) the source put before the chapter's ([args].$3).
String _processNovelHtml((String, String, String) args) => removeNovelBookTitle(
  buildNovelHtml(args.$1),
  bookTitle: args.$2,
  chapterTitle: args.$3,
);

@visibleForTesting
String buildNovelHtml(String input) {
  // Decode basic escapes
  String cleaned = input
      .replaceAll("\\n", "")
      .replaceAll("\\t", "")
      .replaceAll("\\\"", "\"")
      .replaceAll("\\'", "'")
      .replaceAll("\\&quot;", "\"")
      .replaceAll("&quot;", "\"");

  // Parse HTML to clean it
  final document = parse(cleaned);

  // Remove unwanted elements (ads, tracking, etc.)
  document.querySelectorAll('iframe').forEach((el) => el.remove());
  document.querySelectorAll('script').forEach((el) => el.remove());
  document.querySelectorAll('[data-aa]').forEach((el) => el.remove());

  // Improve styles for EPUB tables
  document.querySelectorAll('table').forEach((table) {
    table.attributes['style'] =
        '${table.attributes['style'] ?? ''} border-collapse: collapse; width: 100%; margin: 10px 0;';
  });

  document.querySelectorAll('td, th').forEach((cell) {
    cell.attributes['style'] =
        '${cell.attributes['style'] ?? ''} border: 1px solid #ddd; padding: 8px;';
  });

  // Improve citations/blockquotes
  document.querySelectorAll('blockquote').forEach((quote) {
    quote.attributes['style'] =
        '${quote.attributes['style'] ?? ''} border-left: 4px solid #ccc; padding-left: 15px; margin: 10px 0; font-style: italic;';
  });

  // Get cleaned HTML
  String htmlContent = document.body?.innerHtml ?? cleaned;

  // Decode HTML entities while keeping HTML tags
  htmlContent = _decodeHtmlEntities(htmlContent);

  return '''<div id="readerViewContent">$htmlContent</div>''';
}

String _decodeHtmlEntities(String html) {
  // Decode numeric HTML entities (&#8220;, &#8217;, etc.)
  String decoded = html.replaceAllMapped(RegExp(r'&#(\d+);'), (match) {
    final charCode = int.tryParse(match.group(1)!);
    return charCode != null ? String.fromCharCode(charCode) : match.group(0)!;
  });

  // Decode hexadecimal HTML entities (&#x2019;, etc.)
  decoded = decoded.replaceAllMapped(RegExp(r'&#x([0-9a-fA-F]+);'), (match) {
    final charCode = int.tryParse(match.group(1)!, radix: 16);
    return charCode != null ? String.fromCharCode(charCode) : match.group(0)!;
  });

  // Decode common named HTML entities. Not &amp;, &lt;, &gt; or &quot;: this
  // runs on serialized HTML, where those are the escapes that keep text from
  // being read as markup. Decoding them turned a novel's literal "<技能>" into
  // a tag the renderer swallowed, and broke quoted attribute values.
  final entities = {
    '&nbsp;': ' ',
    '&apos;': "'",
    '&ldquo;': '"',
    '&rdquo;': '"',
    '&lsquo;': ''',
    '&rsquo;': ''',
    '&mdash;': '—',
    '&ndash;': '–',
    '&hellip;': '…',
  };

  entities.forEach((entity, replacement) {
    decoded = decoded.replaceAll(entity, replacement);
  });

  return decoded;
}
