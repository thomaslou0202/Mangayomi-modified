import 'dart:convert';

import 'package:html/parser.dart';

String decodeNovelHtmlResponse(String input) {
  if (input.length >= 2 && input.startsWith('"') && input.endsWith('"')) {
    try {
      final value = jsonDecode(input);
      if (value is String) return value;
    } on FormatException {
      return input.substring(1, input.length - 1);
    }
  }
  return input;
}

RegExp? _bookPrefix(String bookTitle) {
  if (bookTitle.trim().isEmpty) return null;
  final pattern = bookTitle.trim().runes.map((rune) {
    final c = String.fromCharCode(rune);
    final digit = rune >= 0xff10 && rune <= 0xff19 ? rune - 0xfee0 : rune;
    if (digit >= 48 && digit <= 57) {
      return '[${String.fromCharCode(digit)}${String.fromCharCode(digit + 0xfee0)}]';
    }
    return RegExp(r'\s').hasMatch(c) ? r'\s*' : RegExp.escape(c);
  }).join();
  return RegExp(
    r'^(\s*(?:[0-9]+[｜|]\s*)?)' + pattern + r'(?=\s|[·:：—－-]|第|卷|$)',
  );
}

/// Strip the book-name prefix in a heading/label, never occurrences in prose.
String novelChapterLabel(String chapterTitle, String bookTitle) {
  final prefix = _bookPrefix(bookTitle);
  if (prefix == null) return chapterTitle.trim();
  return chapterTitle
      .replaceFirstMapped(prefix, (m) => m[1] ?? '')
      .replaceFirstMapped(
        RegExp(r'^(\s*[0-9]+[｜|])\s*[·:：—－-]+\s*'),
        (m) => m[1]!,
      )
      .replaceFirstMapped(RegExp(r'^(\s*[0-9]+[｜|])\s+'), (m) => m[1]!)
      .replaceFirst(RegExp(r'^\s*[·:：—－-]+\s*'), '')
      .trim();
}

String removeNovelBookTitle(
  String html, {
  required String bookTitle,
  required String chapterTitle,
}) {
  final document = parse(html);
  final prefix = _bookPrefix(bookTitle);
  if (prefix == null) return document.body?.innerHtml ?? html;
  final chapterLabel = novelChapterLabel(chapterTitle, bookTitle);
  final headings = document.querySelectorAll('h1,h2,h3,h4,h5,h6');
  String normalize(String value) => value.replaceAll(RegExp(r'\s+'), '');
  final hasChapter =
      chapterLabel.isNotEmpty &&
      headings.any(
        (node) =>
            normalize(novelChapterLabel(node.text, bookTitle)) ==
                normalize(chapterLabel) &&
            novelChapterLabel(node.text, bookTitle).isNotEmpty,
      );
  var inserted = false;
  for (final heading in headings) {
    if (heading.querySelector('img') != null) continue;
    final title = heading.text.trim();
    if (!prefix.hasMatch(title)) continue;
    final cleaned = novelChapterLabel(title, bookTitle);
    if (cleaned.isEmpty) {
      if (!hasChapter && !inserted && chapterLabel.isNotEmpty) {
        heading.text = chapterLabel;
        inserted = true;
      } else {
        heading.remove();
      }
    } else {
      heading.text = cleaned;
    }
  }
  return document.body?.innerHtml ?? html;
}
