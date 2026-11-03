import 'dart:convert';
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:shiori/shiori.dart';

/// An inline illustration with bounded height in paged reading modes.
/// The caller supplies the provider so EPUB and online chapters share layout.
class NovelIllustration extends StatefulWidget {
  const NovelIllustration({
    super.key,
    required this.image,
    required this.errorLabel,
    required this.retryLabel,
    this.semanticLabel,
    this.maxHeight,
  });

  final ImageProvider image;
  final String errorLabel;
  final String retryLabel;
  final String? semanticLabel;
  final double? maxHeight;

  @override
  State<NovelIllustration> createState() => _NovelIllustrationState();
}

class _NovelIllustrationState extends State<NovelIllustration> {
  int _attempt = 0;

  Future<void> _retry() async {
    await widget.image.evict();
    if (mounted) setState(() => _attempt++);
  }

  @override
  Widget build(BuildContext context) {
    final height = widget.maxHeight ?? double.infinity;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: ShioriSpace.s8),
      child: ConstrainedBox(
        constraints: BoxConstraints(maxHeight: height),
        child: Image(
          key: ValueKey(_attempt),
          image: widget.image,
          width: double.infinity,
          fit: BoxFit.contain,
          semanticLabel: widget.semanticLabel,
          frameBuilder: (context, child, frame, wasSynchronouslyLoaded) {
            if (frame != null || wasSynchronouslyLoaded) return child;
            return SizedBox(
              height: math.min(160, height),
              child: const Center(child: ShioriLoading.inline()),
            );
          },
          errorBuilder: (context, error, stackTrace) => SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Symbols.broken_image_rounded,
                  color: context.shiori.color.error.foreground,
                ),
                Text(widget.errorLabel, textAlign: TextAlign.center),
                ShioriButton.quiet(
                  onPressed: _retry,
                  icon: Symbols.refresh_rounded,
                  label: widget.retryLabel,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/// Resolve relative and protocol-relative source URLs without accepting local
/// file paths or script/data URLs from an online chapter.
Uri? resolveNovelImageUri({
  required String src,
  required String? chapterUrl,
  required String? sourceBaseUrl,
}) {
  if (src.trim().isEmpty) return null;
  try {
    final source = Uri.tryParse(sourceBaseUrl ?? '');
    final chapter =
        source?.resolve(chapterUrl ?? '') ?? Uri.tryParse(chapterUrl ?? '');
    final image = chapter?.resolve(src.trim()) ?? Uri.tryParse(src.trim());
    if (image == null ||
        !const ['http', 'https'].contains(image.scheme) ||
        image.host.isEmpty ||
        image.userInfo.isNotEmpty) {
      return null;
    }
    return image;
  } on FormatException {
    return null;
  }
}

/// CDN images often have no cookies, so the HTTP client's conditional cookie
/// fallback does not add a browser identity. Supply it explicitly while
/// preserving source-specific headers, regardless of their capitalization.
Map<String, String> novelImageHeaders({
  required Map<String, String> sourceHeaders,
  required String userAgent,
  Uri? chapterUri,
}) {
  final headers = Map<String, String>.of(sourceHeaders);
  bool has(String name) => headers.keys.any((key) => key.toLowerCase() == name);
  var agent = userAgent.trim();
  if (agent.length >= 2 && agent.startsWith('"') && agent.endsWith('"')) {
    try {
      final decoded = jsonDecode(agent);
      if (decoded is String) agent = decoded.trim();
    } on FormatException {
      // Retain the configured value if it is not a JSON-encoded string.
    }
  }
  if (!has('user-agent') && agent.isNotEmpty) {
    headers['User-Agent'] = agent;
  }
  if (!has('referer') && chapterUri != null) {
    headers['Referer'] = chapterUri.toString();
  }
  return headers;
}
