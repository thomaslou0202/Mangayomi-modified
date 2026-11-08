import 'dart:convert';
import 'dart:io';

import 'package:html/parser.dart';

/// Publish a chapter only after the extension returned usable content and the
/// complete file was flushed. Interrupted writes never become readable HTML.
Future<void> saveNovelDownload({
  required File file,
  required Future<String> Function() load,
  required bool Function() isCancelled,
}) async {
  if (isCancelled()) return;
  final raw = await load();
  if (isCancelled()) return;
  var html = raw.trim();
  if (html.startsWith('"')) {
    final decoded = jsonDecode(html);
    if (decoded is! String) {
      throw const FormatException('Invalid novel content');
    }
    html = decoded;
  }
  if (html.trim().isEmpty || html == 'null' || html == 'undefined') {
    throw const FormatException('The source returned empty novel content');
  }
  final body = parse(html).body!;
  body.querySelectorAll('script,style').forEach((e) => e.remove());
  if (body.text.trim().isEmpty && body.querySelector('img[src]') == null) {
    throw const FormatException('The source returned empty novel content');
  }
  final temporary = File('${file.path}.part');
  try {
    await temporary.writeAsString(raw, flush: true);
    if (isCancelled()) return;
    await temporary.rename(file.path);
  } finally {
    if (await temporary.exists()) await temporary.delete();
  }
}
