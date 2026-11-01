import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:html/parser.dart';
import 'package:mangayomi/modules/novel/utils/novel_content.dart';

void main() {
  test(
    'old downloaded book headings become chapter labels with their numbers',
    () {
      final html = removeNovelBookTitle(
        '<article><h3>測試小說</h3><p>正文提到測試小說，這句保留。</p><img src="https://example.test/a.jpg"></article>',
        bookTitle: '測試小說',
        chapterTitle: '0009｜第一卷 · 插圖',
      );
      final doc = parse(html);
      expect(doc.querySelector('h3')!.text, '0009｜第一卷 · 插圖');
      expect(doc.querySelector('p')!.text, '正文提到測試小說，這句保留。');
      expect(doc.querySelectorAll('img'), hasLength(1));
    },
  );
  test('existing chapter headings are not duplicated', () {
    final doc = parse(
      removeNovelBookTitle(
        '<h1>小說名稱</h1><h2>第一章</h2><p>正文</p>',
        bookTitle: '小說名稱',
        chapterTitle: '第一章',
      ),
    );
    expect(doc.querySelectorAll('h1,h2,h3'), hasLength(1));
    expect(doc.querySelector('h2')!.text, '第一章');
  });
  test(
    'volume headings lose only book prefix, retaining global/fullwidth numbers',
    () {
      expect(novelChapterLabel('0010｜小說86 ２ · 第１章', '小說86'), '0010｜２ · 第１章');
      expect(novelChapterLabel('0010｜小說８６ ２ · 第１章', '小說86'), '0010｜２ · 第１章');
      expect(novelChapterLabel('0010｜小說86 · 插圖', '小說86'), '0010｜插圖');
      expect(novelChapterLabel('第一章 與魔女同行', '魔女'), '第一章 與魔女同行');
    },
  );
  test(
    'book and chapter cleanup is idempotent and preserves unrelated headings',
    () {
      String clean(String html) => removeNovelBookTitle(
        html,
        bookTitle: '小說',
        chapterTitle: '0010｜小說 １ · 插圖',
      );
      final first = clean('<h3>小說</h3><h4>其他標題</h4><p>正文</p>');
      expect(clean(first), first);
      expect(first, contains('其他標題'));
    },
  );
  test('JSON wrapped downloaded HTML is decoded without losing quotes or line breaks', () {
    const html = '<p>第一行\n第二行 "引號"</p><img src="https://example.test/a.jpg">';
    expect(decodeNovelHtmlResponse(jsonEncode(html)), html);
    expect(decodeNovelHtmlResponse(html), html);
  });
}
