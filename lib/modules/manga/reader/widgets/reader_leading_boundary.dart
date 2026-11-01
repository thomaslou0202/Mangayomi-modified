import 'package:flutter/material.dart';

/// A deliberate backward drag at the beginning opens the preceding chapter.
/// Scroll metrics already account for reverse/RTL, so a negative overscroll
/// consistently means "before the first page" in every reading direction.
class ReaderLeadingBoundary extends StatefulWidget {
  const ReaderLeadingBoundary({
    super.key,
    required this.child,
    this.onPrevious,
  });

  final Widget child;
  final VoidCallback? onPrevious;

  @override
  State<ReaderLeadingBoundary> createState() => _ReaderLeadingBoundaryState();
}

class _ReaderLeadingBoundaryState extends State<ReaderLeadingBoundary> {
  double _distance = 0;
  bool _requested = false;

  bool _onScroll(ScrollNotification notification) {
    if (notification.depth != 0) return false;
    if (notification is ScrollStartNotification) {
      _distance = 0;
      _requested = false;
    } else if (notification is OverscrollNotification &&
        notification.dragDetails != null &&
        notification.overscroll < 0 &&
        notification.metrics.pixels <=
            notification.metrics.minScrollExtent + 0.5 &&
        widget.onPrevious != null &&
        !_requested) {
      _distance -= notification.overscroll;
      if (_distance >= 48) {
        _requested = true;
        // Navigation must happen outside the scroll/layout callback.
        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (mounted) widget.onPrevious?.call();
        });
      }
    } else if (notification is ScrollUpdateNotification &&
        notification.metrics.pixels >
            notification.metrics.minScrollExtent + 0.5) {
      _distance = 0;
    }
    return false;
  }

  @override
  Widget build(BuildContext context) =>
      NotificationListener<ScrollNotification>(
        onNotification: _onScroll,
        child: widget.child,
      );
}
