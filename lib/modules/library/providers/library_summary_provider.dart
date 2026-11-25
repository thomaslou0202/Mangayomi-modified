import 'dart:async';

import 'package:flutter/foundation.dart' show listEquals;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:isar_community/isar.dart';
import 'package:mangayomi/main.dart';
import 'package:mangayomi/models/chapter.dart';
import 'package:mangayomi/models/download.dart';
import 'package:mangayomi/services/database_worker.dart';
import 'package:mangayomi/services/library_chapter_summary.dart';

final librarySummaryProvider = StreamProvider<Map<int, LibraryChapterSummary>>((
  ref,
) {
  final controller = StreamController<Map<int, LibraryChapterSummary>>();
  Timer? debounce;
  bool running = false, dirty = false, disposed = false;
  Future<void> refresh() async {
    if (running) {
      dirty = true;
      return;
    }
    running = true;
    try {
      do {
        dirty = false;
        final result = await DatabaseWorker.instance
            .run<Map<int, LibraryChapterSummary>>('summary');
        if (!disposed) controller.add(result);
      } while (dirty && !disposed);
    } catch (error, stack) {
      if (!disposed) controller.addError(error, stack);
    } finally {
      running = false;
    }
  }

  void changed() {
    debounce?.cancel();
    debounce = Timer(const Duration(milliseconds: 250), refresh);
  }

  // The summary only counts finished downloads, but a running download
  // writes its progress to the same table many times a chapter, and each
  // write used to recompute the whole library. Recompute only when the set
  // of finished downloads changes.
  List<int>? finishedDownloads;
  Timer? downloadsDebounce;
  Future<void> checkDownloads() async {
    final ids = await isar.downloads
        .filter()
        .isDownloadEqualTo(true)
        .idProperty()
        .findAll();
    if (disposed) return;
    ids.sort();
    if (finishedDownloads != null && listEquals(ids, finishedDownloads)) {
      return;
    }
    finishedDownloads = ids;
    changed();
  }

  final chapters = isar.chapters.watchLazy().listen((_) => changed());
  final downloads = isar.downloads.watchLazy().listen((_) {
    downloadsDebounce?.cancel();
    downloadsDebounce = Timer(const Duration(milliseconds: 250), () {
      unawaited(checkDownloads().catchError((Object _) => changed()));
    });
  });
  ref.onDispose(() {
    disposed = true;
    debounce?.cancel();
    downloadsDebounce?.cancel();
    chapters.cancel();
    downloads.cancel();
    controller.close();
  });
  unawaited(refresh());
  return controller.stream;
});

LibraryChapterSummary summaryFor(
  Map<int, LibraryChapterSummary>? rows,
  int? id,
) => rows?[id] ?? const LibraryChapterSummary();
