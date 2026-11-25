import 'package:flutter/painting.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mangayomi/modules/manga/reader/subsampling_scale_image_view/src/subsampling_types.dart';

ImageChunkEvent chunk(int loaded, [int? total = 1000]) => ImageChunkEvent(
  cumulativeBytesLoaded: loaded,
  expectedTotalBytes: total,
);

void main() {
  test('a page rebuilds for download progress once per percent', () {
    expect(loadingProgressStepped(null, chunk(1)), isTrue);
    expect(loadingProgressStepped(chunk(10), chunk(19)), isFalse);
    expect(loadingProgressStepped(chunk(19), chunk(20)), isTrue);
  });

  test('without a known size only the first chunk rebuilds', () {
    expect(loadingProgressStepped(null, chunk(1, null)), isTrue);
    expect(loadingProgressStepped(chunk(1, null), chunk(500, null)), isFalse);
  });
}
