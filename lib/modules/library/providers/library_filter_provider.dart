import 'package:mangayomi/modules/library/providers/library_summary_provider.dart';
import 'package:mangayomi/services/library_chapter_summary.dart';
import 'package:mangayomi/models/settings.dart';
import 'package:mangayomi/models/manga.dart';
import 'package:mangayomi/repositories/download_repository.dart';
import 'package:mangayomi/repositories/track_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'library_filter_provider.g.dart';

/// Sorts unread counts while keeping fully-read entries at the end.
///
/// Reversing the active unread values must not promote the inactive zero
/// value above titles that still have something to read.
List<T> sortByUnreadCount<T>(
  Iterable<T> values, {
  required int Function(T value) unreadCountOf,
  bool descending = false,
}) {
  final sorted = values.toList();
  final counts = <T, int>{
    for (final value in sorted) value: unreadCountOf(value),
  };
  sorted.sort((a, b) {
    final aCount = counts[a]!;
    final bCount = counts[b]!;
    if (aCount == 0 && bCount != 0) return 1;
    if (bCount == 0 && aCount != 0) return -1;
    return descending ? bCount.compareTo(aCount) : aCount.compareTo(bCount);
  });
  return sorted;
}

/// Pre-fetches all downloaded chapter IDs in a single Isar query.
/// Returns a [Set<int>] for O(1) lookup instead of per-chapter queries.
@riverpod
Stream<Set<int>> downloadedChapterIds(Ref ref) {
  return downloadRepository.watchDownloaded().map(
    (list) => list.map((d) => d.id).whereType<int>().toSet(),
  );
}

/// Pre-fetches all manga IDs that have at least one tracking entry reactively.
@riverpod
Stream<Set<int>> trackedMangaIds(Ref ref) {
  return trackRepository.watchAll().map(
    (tracks) => tracks.map((t) => t.mangaId).whereType<int>().toSet(),
  );
}

/// Filters and sorts a list of [Manga] based on library filter/sort settings.
@riverpod
List<Manga> filteredLibraryManga(
  Ref ref, {
  required List<Manga> data,
  required int downloadFilterType,
  required int unreadFilterType,
  required int startedFilterType,
  required int bookmarkedFilterType,
  required int completedFilterType,
  required int trackingFilterType,
  required int sortType,
  required bool downloadedOnly,
  required String searchQuery,
  required bool ignoreFiltersOnSearch,
  required List<String> sourceIds,
  required Settings settings,
}) {
  final summaries = ref.watch(librarySummaryProvider).asData?.value;
  final trackedIds =
      ref.watch(trackedMangaIdsProvider).asData?.value ?? const <int>{};

  List<Manga> mangas;
  final keywords = searchKeywords(searchQuery);

  // Skip all filters, just do search
  if (searchQuery.isNotEmpty && ignoreFiltersOnSearch) {
    mangas = data
        .where((element) => matchesSearchKeywords(element, keywords))
        .toList();
  } else {
    mangas = data.where((element) {
      final summary = summaryFor(summaries, element.id);
      // Filter by download — uses Set lookup instead of per-chapter Isar query
      if (downloadFilterType == 1 || downloadedOnly) {
        final hasDownloaded = summary.downloaded > 0;
        if (!hasDownloaded) return false;
      } else if (downloadFilterType == 2) {
        final allNotDownloaded = summary.downloaded == 0;
        if (!allNotDownloaded) return false;
      }

      if (!passesReadFilters(
        summary,
        unreadFilterType: unreadFilterType,
        startedFilterType: startedFilterType,
      )) {
        return false;
      }

      // Filter by bookmarked
      if (bookmarkedFilterType == 1) {
        final hasBookmarked = summary.bookmarked > 0;
        if (!hasBookmarked) return false;
      } else if (bookmarkedFilterType == 2) {
        final allNotBookmarked = summary.bookmarked == 0;
        if (!allNotBookmarked) return false;
      }

      // Filter by completed status
      if (completedFilterType == 1) {
        if (element.status != Status.completed) return false;
      } else if (completedFilterType == 2) {
        if (element.status == Status.completed) return false;
      }

      // Filter by tracking
      if (trackingFilterType == 1) {
        if (element.id == null || !trackedIds.contains(element.id)) {
          return false;
        }
      } else if (trackingFilterType == 2) {
        if (element.id != null && trackedIds.contains(element.id)) {
          return false;
        }
      }

      // Filter by source
      if (sourceIds.isNotEmpty) {
        if (element.source == null || !sourceIds.contains(element.source)) {
          return false;
        }
      }

      // Search filter
      if (searchQuery.isNotEmpty) {
        if (!matchesSearchKeywords(element, keywords)) return false;
      }

      return true;
    }).toList();
  }

  // Sort
  if (mangas.isNotEmpty) {
    if (sortType == 3) {
      final unreadCounts = <int, int>{};
      for (final manga in mangas) {
        if (manga.id != null) {
          // Scanlator-aware unread count (respects the per-manga filter).
          unreadCounts[manga.id!] = summaryFor(summaries, manga.id)
              .visibleUnread(
                settings.filterScanlatorList
                    ?.where((e) => e.mangaId == manga.id)
                    .firstOrNull
                    ?.scanlators,
              );
        }
      }
      mangas = sortByUnreadCount(
        mangas,
        unreadCountOf: (manga) =>
            manga.id != null ? (unreadCounts[manga.id] ?? 0) : 0,
      );
    } else if (sortType == 4) {
      final totalCounts = <int, int>{};
      for (final manga in mangas) {
        if (manga.id != null) {
          totalCounts[manga.id!] = summaryFor(summaries, manga.id).total;
        }
      }
      mangas.sort((a, b) {
        final aVal = a.id != null ? (totalCounts[a.id] ?? 0) : 0;
        final bVal = b.id != null ? (totalCounts[b.id] ?? 0) : 0;
        return aVal.compareTo(bVal);
      });
    } else if (sortType == 5) {
      final lastUpload = {
        for (final manga in mangas)
          manga.id: summaryFor(summaries, manga.id).latestUpload,
      };
      mangas.sort(
        (a, b) => (lastUpload[a.id] ?? "").compareTo(lastUpload[b.id] ?? ""),
      );
    } else {
      mangas.sort((a, b) {
        switch (sortType) {
          case 0:
            return a.name!.compareTo(b.name!);
          case 1:
            return a.lastRead!.compareTo(b.lastRead!);
          case 2:
            return a.lastUpdate?.compareTo(b.lastUpdate ?? 0) ?? 0;
          case 6:
            return a.dateAdded?.compareTo(b.dateAdded ?? 0) ?? 0;
          default:
            return 0;
        }
      });
    }
  }

  return mangas;
}

/// The unread and started filters (0 off, 1 include, 2 exclude).
///
/// "Started" means at least one chapter read. It used to share the unread
/// test, so it showed titles with unread chapters, started or not.
bool passesReadFilters(
  LibraryChapterSummary summary, {
  required int unreadFilterType,
  required int startedFilterType,
}) {
  final unread = summary.unread > 0;
  final started = summary.total - summary.unread > 0;
  if (unreadFilterType == 1 && !unread) return false;
  if (unreadFilterType == 2 && unread) return false;
  if (startedFilterType == 1 && !started) return false;
  if (startedFilterType == 2 && started) return false;
  return true;
}

/// The comma-separated terms of a library search, lower-cased once per search
/// rather than once per title.
List<String> searchKeywords(String query) => query
    .toLowerCase()
    .split(',')
    .map((k) => k.trim())
    .where((k) => k.isNotEmpty)
    .toList();

/// Whether [manga] matches any of [keywords] by title, source or genre.
bool matchesSearchKeywords(Manga manga, List<String> keywords) {
  if (keywords.isEmpty) return true;
  final fields = _searchFieldsOf(manga);
  return keywords.any(
    (keyword) =>
        fields.name.contains(keyword) ||
        fields.source.contains(keyword) ||
        fields.genres.any((g) => g.contains(keyword)),
  );
}

/// A title's searchable text, lower-cased once and kept with the object.
///
/// Typing searches the whole library on every keystroke; lower-casing every
/// title, source and genre each time was most of that work. The library
/// stream hands out new objects when the library changes, so this never goes
/// stale.
final _searchFields = Expando<_SearchFields>('librarySearchFields');

_SearchFields _searchFieldsOf(Manga manga) =>
    _searchFields[manga] ??= _SearchFields(
      name: manga.name?.toLowerCase() ?? '',
      source: manga.source?.toLowerCase() ?? '',
      genres: [
        for (final g in manga.genre ?? const <String>[]) g.toLowerCase(),
      ],
    );

class _SearchFields {
  const _SearchFields({
    required this.name,
    required this.source,
    required this.genres,
  });

  final String name;
  final String source;
  final List<String> genres;
}
