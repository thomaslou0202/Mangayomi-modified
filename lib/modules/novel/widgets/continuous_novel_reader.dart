import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:shiori/shiori.dart';

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
  /// How many screens before the end of the last loaded chapter the next
  /// one starts loading in the background.
  static const _prefetchScreens = 6;

  /// How many finished chapters stay above the current one. Earlier ones
  /// leave the list: kept, the list only grew, the scrollbar thumb shrank to
  /// a sliver after a few chapters, and every chapter read stayed in memory.
  static const _keepBehind = 2;

  final _viewportKey = GlobalKey();
  final _sectionKeys = <int, GlobalKey>{};
  final _heights = <int, double>{};
  final _cache = <int, Future<NovelChapterText>>{};
  final _ready = <int, NovelChapterText>{};
  late int _firstIndex;

  /// The chapter the reader opened on; the only one drawn without a
  /// separator above it.
  late int _initialIndex;
  int _count = 1;
  int _activeIndex = 0;
  bool _scheduled = false;
  bool _restored = false;
  bool _closed = false;
  double _lastPixels = 0;
  bool _advancedSinceMeasure = false;
  bool _positionChangedSinceMeasure = false;

  /// The saved progress being restored, kept until the reader scrolls.
  ///
  /// The opening chapter's height keeps changing after its first layout
  /// (pictures arriving, the HTML finishing its layout). Seeking once, against
  /// the first height, put the reader at the wrong place: too far down when
  /// the chapter then shrank, too far up when it grew. So the seek is redone
  /// whenever the height changes, until the reader moves on their own.
  double? _restoreProgress;
  double? _restorePixels;
  double? _restoreHeight;

  int get cachedBodyCount => _cache.length;

  /// Chapters currently in the scroll list.
  int get chaptersInList => _count;

  @override
  void initState() {
    super.initState();
    _firstIndex = widget.chapterIds.indexOf(widget.initial.id);
    _initialIndex = _firstIndex;
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
    // A seek from outside (the progress slider, TTS) replaces any restore.
    _restoreProgress = null;
    _seek(progress);
  }

  /// Jumps to [progress] through the active chapter; returns its height then.
  double? _seek(double progress) {
    if (!widget.controller.hasClients) return null;
    final id = widget.chapterIds[_activeIndex], geometry = _geometry(id);
    if (geometry == null) return null;
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
    return geometry.height;
  }

  void _restore(double progress) {
    _restoreProgress = progress;
    _restoreHeight = _seek(progress);
    _restorePixels = widget.controller.hasClients
        ? widget.controller.position.pixels
        : null;
  }

  /// Redoes the restore when the opening chapter changed height, as long as
  /// the reader has not scrolled since. Returns whether it seeked.
  bool _keepRestored() {
    final progress = _restoreProgress;
    if (progress == null || !widget.controller.hasClients) return false;
    final geometry = _geometry(widget.chapterIds[_activeIndex]);
    if (geometry == null) return false;
    // The chapter changed height (its layout settled, pictures came in): the
    // scroll position may have been clamped along with it, so seek again.
    if ((geometry.height - (_restoreHeight ?? 0)).abs() >= 1) {
      _restore(progress);
      return true;
    }
    // Same height but a different position: the reader (or auto-scroll)
    // moved, and from here their position wins.
    final pixels = widget.controller.position.pixels;
    if (_restorePixels == null || (pixels - _restorePixels!).abs() > 1) {
      _restoreProgress = null;
    }
    return false;
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
        _restore(widget.initialProgress);
        return;
      }
    }
    if (_keepRestored()) return;
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
                  (advanced || visible != _initialIndex)
              ? extent
              : (-geometry.top).clamp(0.0, extent),
          extent: extent,
        ),
      );
    }
    final lastIndex = _firstIndex + _count - 1;
    final lastId = widget.chapterIds[lastIndex], last = _geometry(lastId);
    // Start fetching the next chapter well before it is needed: once the
    // reader is halfway through the last loaded chapter, or within a few
    // screens of its end. Fetching used to start only 800 px from the end, so
    // a slow source showed a loading row right where reading continues. The
    // chapter is still appended at the same point below; this only warms the
    // cache, and never moves the reading position.
    if (last != null &&
        _ready.containsKey(lastId) &&
        lastIndex <= _activeIndex &&
        lastIndex + 1 < widget.chapterIds.length) {
      final viewport = position.viewportDimension;
      final remaining = last.top + last.height - viewport;
      final halfway = -last.top >= (last.height - viewport) / 2;
      if (halfway || remaining < viewport * _prefetchScreens) {
        _load(widget.chapterIds[lastIndex + 1]);
      }
    }
    if (last != null &&
        _ready.containsKey(lastId) &&
        last.top + last.height < position.viewportDimension + 800 &&
        lastIndex <= _activeIndex &&
        lastIndex + 1 < widget.chapterIds.length) {
      final next = widget.chapterIds[lastIndex + 1];
      _load(next);
      setState(() => _count++);
    }
    _dropFinishedChapters(position);
  }

  /// Takes the oldest chapter out of the list once it is well behind the
  /// reader and off screen, keeping the reading position where it is.
  void _dropFinishedChapters(ScrollPosition position) {
    if (_activeIndex - _firstIndex <= _keepBehind || _count <= 1) return;
    final firstId = widget.chapterIds[_firstIndex];
    // Far above the screen the list no longer builds it, so its height is the
    // one measured while it was on screen.
    final first = _geometry(firstId);
    if (first != null && first.top + first.height > 0) return;
    final height = first?.height ?? _heights[firstId];
    if (height == null) return;
    // Everything below moves up by the removed height; move the scroll
    // position with it so the text on screen does not jump.
    final pixels = position.pixels - height;
    position.correctPixels(pixels);
    _lastPixels = pixels;
    setState(() {
      _firstIndex++;
      _count--;
    });
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
                          if (_firstIndex + index > _initialIndex)
                            Padding(
                              key: ValueKey('chapter-separator-$id'),
                              padding: const EdgeInsets.symmetric(
                                vertical: ShioriSpace.s16,
                              ),
                              child: Center(
                                child: SizedBox(
                                  width: 48,
                                  height: 3,
                                  child: DecoratedBox(
                                    decoration: BoxDecoration(
                                      color: context.shiori.color.ink3,
                                      borderRadius: BorderRadius.circular(
                                        ShioriShape.pill,
                                      ),
                                    ),
                                  ),
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
                                      _heights[id]! -
                                          (_firstIndex + index > _initialIndex
                                              ? 35
                                              : 0),
                                    ),
                              child: Center(
                                child: snapshot.hasError
                                    ? Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Icon(
                                            Symbols.error_outline_rounded,
                                            color: context
                                                .shiori
                                                .color
                                                .error
                                                .foreground,
                                          ),
                                          ShioriButton.quiet(
                                            icon: Symbols.refresh_rounded,
                                            label: widget.retryLabel,
                                            onPressed: () => setState(() {
                                              _cache.remove(id);
                                              _ready.remove(id);
                                            }),
                                          ),
                                        ],
                                      )
                                    : const ShioriLoading(),
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
