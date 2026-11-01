/// Backward chapter navigation explicitly opens at the last image, even if
/// that chapter is already read or has a saved position near its beginning.
int readerStartPage({
  required int pageCount,
  required int savedIndex,
  required bool fromEnd,
}) {
  final last = pageCount > 0 ? pageCount - 1 : 0;
  return fromEnd ? last : savedIndex.clamp(0, last);
}
