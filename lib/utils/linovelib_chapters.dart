final _bookPath = RegExp(r'^/?novel/([0-9]+)\.html$');
final _chapterPath = RegExp(r'^/?novel/([0-9]+)/[0-9]+(?:_[0-9]+)?\.html$');

/// A migrated library can retain chapters belonging to its previous source.
/// Match both the source host and book ID before showing a Linovelib chapter.
bool linovelibChapterBelongsToBook(String? bookUrl, String? chapterUrl) {
  final book = Uri.tryParse(bookUrl ?? '');
  final chapter = Uri.tryParse(chapterUrl ?? '');
  if (book == null || chapter == null || chapter.userInfo.isNotEmpty) {
    return false;
  }
  if (chapter.hasScheme &&
      chapter.scheme != 'http' &&
      chapter.scheme != 'https') {
    return false;
  }
  if (chapter.hasAuthority && chapter.host != 'tw.linovelib.com') return false;
  final bookId = _bookPath.firstMatch(book.path)?.group(1);
  final chapterBookId = _chapterPath.firstMatch(chapter.path)?.group(1);
  return bookId != null && bookId == chapterBookId;
}
