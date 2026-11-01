import 'dart:math' as math;

import 'package:flutter/material.dart';

class NovelChapterText {
  const NovelChapterText({required this.id, required this.html});
  final int id;
  final String html;
}

class NovelChapterPosition {
  const NovelChapterPosition({
    required this.content,
    required this.offset,
    required this.extent,
  });
  final NovelChapterText content;
  final double offset;
  final double extent;
}

/// Lazily appends the next chapter and virtualizes earlier chapters. Only a
/// small cache of chapter bodies is retained; prefetching never advances the
/// reading position or writes history.
class ContinuousNovelReader extends StatefulWidget {
  const ContinuousNovelReader({
    super.key,
    required this.chapterIds,
    required this.initial,
    required this.controller,
    required this.loadChapter,
    required this.contentBuilder,
    required this.onPosition,
    required this.retryLabel,
    this.initialProgress = 0,
    this.cacheLimit = 5,
  });
  final List<int> chapterIds;
  final NovelChapterText initial;
  final ScrollController controller;
  final Future<NovelChapterText> Function(int id) loadChapter;
  final Widget Function(BuildContext context, NovelChapterText chapter)
  contentBuilder;
  final ValueChanged<NovelChapterPosition> onPosition;
  final String retryLabel;
  final double initialProgress;
  final int cacheLimit;

  @override
  State<ContinuousNovelReader> createState() => ContinuousNovelReaderState();
}

class ContinuousNovelReaderState extends State<ContinuousNovelReader> {
  final _viewportKey = GlobalKey();
  final _sectionKeys = <int, GlobalKey>{};
  final _heights = <int, double>{};
  final _cache = <int, Future<NovelChapterText>>{};
  final _ready = <int, NovelChapterText>{};
  late int _firstIndex;
  int _count = 1;
  int _activeIndex = 0;
  bool _scheduled = false;
  bool _restored = false;
  bool _closed = false;
  double _lastPixels = 0;
  bool _advancedSinceMeasure = false;
  bool _positionChangedSinceMeasure = false;

  int get cachedBodyCount => _cache.length;

  @override
  void initState() {
    super.initState();
    _firstIndex = widget.chapterIds.indexOf(widget.initial.id);
    assert(
      _firstIndex >= 0 &&
          widget.chapterIds.toSet().length == widget.chapterIds.length,
    );
    _activeIndex = _firstIndex;
    _remember(widget.initial.id, Future.value(widget.initial));
    _ready[widget.initial.id] = widget.initial;
    widget.controller.addListener(_scheduleMeasure);
    _scheduleMeasure();
  }

  @override
  void dispose() {
    _closed = true;
    widget.controller.removeListener(_scheduleMeasure);
    _cache.clear();
    _ready.clear();
    super.dispose();
  }

  void _remember(int id, Future<NovelChapterText> future) {
    _cache.remove(id);
    _cache[id] = future;
    while (_cache.length > math.max(2, widget.cacheLimit)) {
      final oldest = _cache.keys.first;
      _cache.remove(oldest);
      _ready.remove(oldest);
    }
  }

  Future<NovelChapterText> _load(int id) {
    final cached = _cache.remove(id);
    if (cached != null) {
      _cache[id] = cached;
      return cached;
    }
    final future = widget.loadChapter(id).then((content) {
      if (content.id != id) throw StateError('Chapter identity mismatch');
      if (!_closed && _cache.containsKey(id)) {
        _ready[id] = content;
        _scheduleMeasure();
      }
      return content;
    });
    // Prefetch may finish before its FutureBuilder is mounted. Keep the
    // failure on the original Future for the retry UI, without an unhandled
    // asynchronous error in the meantime.
    future.then<void>((_) {}, onError: (Object _, StackTrace _) {});
    _remember(id, future);
    return future;
  }

  void _scheduleMeasure() {
    if (_closed) return;
    if (widget.controller.hasClients) {
      final pixels = widget.controller.position.pixels;
      if ((pixels - _lastPixels).abs() > 0.5) {
        _positionChangedSinceMeasure = true;
      }
      if (pixels > _lastPixels + 0.5) _advancedSinceMeasure = true;
      _lastPixels = pixels;
    }
    if (_scheduled) return;
    _scheduled = true;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scheduled = false;
      if (mounted) _measure();
    });
  }

  ({double top, double height})? _geometry(int id) {
    final box = _sectionKeys[id]?.currentContext?.findRenderObject();
    final viewport = _viewportKey.currentContext?.findRenderObject();
    if (box is! RenderBox || viewport is! RenderBox || !box.hasSize) {
      return null;
    }
    return (
      top: box.localToGlobal(Offset.zero, ancestor: viewport).dy,
      height: box.size.height,
    );
  }

  void seek(double progress) {
    if (!widget.controller.hasClients) return;
    final id = widget.chapterIds[_activeIndex], geometry = _geometry(id);
    if (geometry == null) return;
    final position = widget.controller.position;
    final start = position.pixels + geometry.top;
    final extent = math.max(0.0, geometry.height - position.viewportDimension);
    widget.controller.jumpTo(
      (start + progress.clamp(0.0, 1.0) * extent).clamp(
        position.minScrollExtent,
        position.maxScrollExtent,
      ),
    );
    _scheduleMeasure();
  }

  void _measure() {
    if (!widget.controller.hasClients) return;
    final position = widget.controller.position;
    final readingLine = math.min(32.0, position.viewportDimension * 0.05);
    int? visible;
    for (var index = _firstIndex; index < _firstIndex + _count; index++) {
      final id = widget.chapterIds[index], geometry = _geometry(id);
      if (geometry == null) continue;
      _heights[id] = geometry.height;
      if (_ready.containsKey(id) &&
          geometry.top <= readingLine &&
          geometry.top + geometry.height > readingLine) {
        visible = index;
      }
      // A short chapter cannot always reach the top of the viewport. Once
      // the reader scrolls to the bottom, the last visible loaded chapter
      // becomes current even when it is shorter than a screen.
      if (_advancedSinceMeasure &&
          position.pixels >= position.maxScrollExtent - 0.5 &&
          geometry.top >= 0 &&
          geometry.top < position.viewportDimension - 32 &&
          _ready.containsKey(id)) {
        visible = index;
      }
    }
    final advanced = _advancedSinceMeasure;
    if (!_positionChangedSinceMeasure &&
        _restored &&
        _geometry(widget.chapterIds[_activeIndex]) != null) {
      visible = _activeIndex;
    }
    _positionChangedSinceMeasure = false;
    _advancedSinceMeasure = false;
    if (!_restored && _ready.containsKey(widget.initial.id)) {
      _restored = true;
      if (widget.initialProgress > 0) {
        seek(widget.initialProgress);
        return;
      }
    }
    if (visible != null) {
      _activeIndex = visible;
      final id = widget.chapterIds[visible], geometry = _geometry(id)!;
      final extent = math.max(
        1.0,
        geometry.height - position.viewportDimension,
      );
      widget.onPosition(
        NovelChapterPosition(
          content: _ready[id]!,
          offset:
              geometry.height <= position.viewportDimension &&
                  (advanced || visible != _firstIndex)
              ? extent
              : (-geometry.top).clamp(0.0, extent),
          extent: extent,
        ),
      );
    }
    final lastIndex = _firstIndex + _count - 1;
    final lastId = widget.chapterIds[lastIndex], last = _geometry(lastId);
    if (last != null &&
        _ready.containsKey(lastId) &&
        last.top + last.height < position.viewportDimension + 800 &&
        lastIndex <= _activeIndex &&
        lastIndex + 1 < widget.chapterIds.length) {
      final next = widget.chapterIds[lastIndex + 1];
      _load(next);
      setState(() => _count++);
    }
  }

  @override
  Widget build(BuildContext context) {
    return NotificationListener<SizeChangedLayoutNotification>(
      onNotification: (_) {
        _scheduleMeasure();
        return false;
      },
      child: SizedBox.expand(
        key: _viewportKey,
        child: CustomScrollView(
          controller: widget.controller,
          physics: const BouncingScrollPhysics(),
          slivers: [
            SliverList.builder(
              itemCount: _count,
              addAutomaticKeepAlives: false,
              itemBuilder: (context, index) {
                final id = widget.chapterIds[_firstIndex + index];
                return SizeChangedLayoutNotifier(
                  key: _sectionKeys.putIfAbsent(id, GlobalKey.new),
                  child: FutureBuilder<NovelChapterText>(
                    future: _load(id),
                    initialData: _ready[id],
                    builder: (context, snapshot) {
                      _scheduleMeasure();
                      final content = snapshot.data;
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          if (index > 0)
                            Padding(
                              key: ValueKey('chapter-separator-$id'),
                              padding: const EdgeInsets.symmetric(vertical: 16),
                              child: Center(
                                child: SizedBox(
                                  width: 48,
                                  child: Divider(thickness: 3, height: 3),
                                ),
                              ),
                            ),
                          if (content != null)
                            widget.contentBuilder(context, content)
                          else
                            SizedBox(
                              height: _heights[id] == null
                                  ? MediaQuery.sizeOf(context).height * 0.7
                                  : math.max(
                                      1.0,
                                      _heights[id]! - (index > 0 ? 35 : 0),
                                    ),
                              child: Center(
                                child: snapshot.hasError
                                    ? Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          const Icon(Icons.error_outline),
                                          TextButton.icon(
                                            icon: const Icon(Icons.refresh),
                                            label: Text(widget.retryLabel),
                                            onPressed: () => setState(() {
                                              _cache.remove(id);
                                              _ready.remove(id);
                                            }),
                                          ),
                                        ],
                                      )
                                    : const CircularProgressIndicator(),
                              ),
                            ),
                        ],
                      );
                    },
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
