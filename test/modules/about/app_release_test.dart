import 'package:flutter_test/flutter_test.dart';
import 'package:mangayomi/modules/more/about/providers/app_release.dart';

Map<String, dynamic> release({String tag = 'v0.9.10+132'}) => {
  'tag_name': tag,
  'draft': false,
  'prerelease': false,
  'html_url': '$appReleaseRepositoryUrl/releases/tag/$tag',
  'body': '繁體中文正式版',
  'assets': <dynamic>[
    for (final suffix in ['android.apk', 'windows.zip'])
      {
        'state': 'uploaded',
        'size': 1234,
        'browser_download_url':
            '$appReleaseRepositoryUrl/releases/download/$tag/Mangayomi-0.9.10-$suffix',
      },
  ],
};

void main() {
  test('About displays the installed build number once', () {
    expect(appVersionLabel('0.9.95', '138'), '0.9.95+138');
    expect(appVersionLabel('0.9.95+138', '138'), '0.9.95+138');
    expect(appVersionLabel('0.9.95', ''), '0.9.95');
  });

  test('APK cache file changes with every release revision', () {
    expect(
      appReleaseApkFileName('0.9.10+132'),
      'Mangayomi-0.9.10+132-android.apk',
    );
    expect(
      appReleaseApkFileName('0.9.10+133'),
      isNot(appReleaseApkFileName('0.9.10+132')),
    );
    expect(() => appReleaseApkFileName('../invalid'), throwsFormatException);
  });
  test('custom distribution uses the owner repository', () {
    expect(
      appReleaseApiUrl,
      'https://api.github.com/repos/thomaslou0202/Mangayomi-modified/releases/latest',
    );
  });
  test('upgrade from prior custom versions', () {
    expect(isNewerAppRelease('0.9.9', '131', '0.9.10+132'), isTrue);
  });
  test('same semantic version compares numeric build revisions', () {
    expect(isNewerAppRelease('0.9.10', '132', '0.9.10+133'), isTrue);
    expect(isNewerAppRelease('0.9.10', '132', '0.9.10+132'), isFalse);
    expect(isNewerAppRelease('0.9.10', '133', '0.9.10+132'), isFalse);
  });
  test('semantic version takes priority over build number', () {
    expect(isNewerAppRelease('0.9.9', '999', '0.9.10+132'), isTrue);
    expect(isNewerAppRelease('0.10.0', '1', '0.9.10+132'), isFalse);
  });
  test('rejects malformed and prerelease versions', () {
    for (final value in [
      'source-list-fix-v0.9.9-131',
      'v0.9.10-beta',
      '',
      '1.2',
    ]) {
      expect(AppReleaseVersion.parse(value), isNull);
    }
  });
  test('parses a complete stable release with both platforms', () {
    final parsed = parseAppRelease(release())!;
    expect(parsed.$1, '0.9.10+132');
    expect(parsed.$2, '繁體中文正式版');
    expect(parsed.$4, hasLength(2));
  });
  test('ignores drafts, previews and invalid tags', () {
    expect(parseAppRelease(release()..['draft'] = true), isNull);
    expect(parseAppRelease(release()..['prerelease'] = true), isNull);
    expect(parseAppRelease(release(tag: 'v0.9.10-beta')), isNull);
  });
  test('ignores incomplete and unrelated assets', () {
    final data = release();
    final assets = data['assets'] as List;
    (assets[0] as Map)['state'] = 'new';
    (assets[1] as Map)['size'] = 0;
    expect(parseAppRelease(data), isNull);
  });
  test('does not offer instrumentation APKs or other repositories', () {
    final data = release();
    (data['assets'] as List).clear();
    (data['assets'] as List).addAll([
      {
        'state': 'uploaded',
        'size': 42,
        'browser_download_url':
            '$appReleaseRepositoryUrl/releases/download/v0.9.10+132/background-service-test.apk',
      },
      {
        'state': 'uploaded',
        'size': 42,
        'browser_download_url': 'https://github.com/other/repo/releases/download/v0.9.10+132/Mangayomi-0.9.10-android.apk',
      },
    ]);
    expect(parseAppRelease(data), isNull);
    expect(
      parseAppRelease(release()..['html_url'] = 'https://example.com'),
      isNull,
    );
  });
  test('encoded plus sign in download links remains a build revision', () {
    final data = release();
    data['html_url'] = (data['html_url'] as String).replaceAll('+', '%2B');
    final assets = data['assets'] as List;
    for (final asset in assets.cast<Map>()) {
      asset['browser_download_url'] = (asset['browser_download_url'] as String)
          .replaceAll('+', '%2B');
    }
    expect(parseAppRelease(data)!.$4, hasLength(2));
  });
}
