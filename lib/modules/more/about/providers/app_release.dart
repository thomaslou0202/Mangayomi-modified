/// The custom app is distributed independently from upstream Mangayomi.
const appReleaseRepository = 'thomaslou0202/Mangayomi-modified';
const appReleaseRepositoryUrl = 'https://github.com/$appReleaseRepository';
const appReleaseApiUrl =
    'https://api.github.com/repos/$appReleaseRepository/releases/latest';

String appVersionLabel(String version, String buildNumber) {
  final build = buildNumber.trim();
  return build.isEmpty || version.contains('+') ? version : '$version+$build';
}

/// Numeric release version, including Android/Windows's build revision.
class AppReleaseVersion implements Comparable<AppReleaseVersion> {
  const AppReleaseVersion(this.major, this.minor, this.patch, this.build);

  final int major;
  final int minor;
  final int patch;
  final int build;

  static AppReleaseVersion? parse(String value) {
    final match = RegExp(r'^[vV]?(\d+)\.(\d+)\.(\d+)(?:\+(\d+))?$')
        .firstMatch(value.trim());
    if (match == null) return null;
    return AppReleaseVersion(
      int.parse(match[1]!),
      int.parse(match[2]!),
      int.parse(match[3]!),
      int.parse(match[4] ?? '0'),
    );
  }

  static AppReleaseVersion? installed(String version, String buildNumber) {
    final parsed = parse(version);
    if (parsed == null) return null;
    return AppReleaseVersion(
      parsed.major,
      parsed.minor,
      parsed.patch,
      int.tryParse(buildNumber) ?? parsed.build,
    );
  }

  @override
  int compareTo(AppReleaseVersion other) {
    final left = [major, minor, patch, build];
    final right = [other.major, other.minor, other.patch, other.build];
    for (var i = 0; i < left.length; i++) {
      final result = left[i].compareTo(right[i]);
      if (result != 0) return result;
    }
    return 0;
  }
}

bool isNewerAppRelease(
  String installedVersion,
  String installedBuild,
  String releaseVersion,
) {
  final current = AppReleaseVersion.installed(installedVersion, installedBuild);
  final release = AppReleaseVersion.parse(releaseVersion);
  return current != null && release != null && release.compareTo(current) > 0;
}

/// A fixed GitHub asset name must not reuse a previous version's cached APK.
String appReleaseApkFileName(String version) {
  if (AppReleaseVersion.parse(version) == null) {
    throw const FormatException('Invalid app release version');
  }
  return 'Mangayomi-${version.replaceFirst(RegExp(r"^[vV]"), "")}-android.apk';
}

/// Only complete, stable releases from our distribution repository qualify.
(String, String, String, List<dynamic>)? parseAppRelease(
  Map<String, dynamic> release,
) {
  if (release['draft'] != false || release['prerelease'] != false) return null;
  final tag = release['tag_name'];
  if (tag is! String || AppReleaseVersion.parse(tag) == null) return null;
  final page = Uri.tryParse(release['html_url']?.toString() ?? '');
  if (page == null ||
      page.scheme != 'https' ||
      page.host != 'github.com' ||
      page.pathSegments.join('/') !=
          '$appReleaseRepository/releases/tag/$tag' ||
      page.hasQuery ||
      page.hasFragment) {
    return null;
  }
  final rawAssets = release['assets'];
  if (rawAssets is! List) return null;
  final assets = <String>[];
  for (final asset in rawAssets.whereType<Map>()) {
    if (asset['state'] != 'uploaded' ||
        asset['size'] is! num ||
        (asset['size'] as num) <= 0) {
      continue;
    }
    final url = asset['browser_download_url'];
    if (url is! String) continue;
    final uri = Uri.tryParse(url);
    if (uri == null ||
        uri.scheme != 'https' ||
        uri.host != 'github.com' ||
        uri.pathSegments.length != 6 ||
        uri.pathSegments.take(5).join('/') !=
            '$appReleaseRepository/releases/download/$tag') {
      continue;
    }
    final name = uri.pathSegments.last.toLowerCase();
    if (name.startsWith('mangayomi-') &&
        (name.endsWith('-android.apk') || name.endsWith('-windows.zip'))) {
      assets.add(url);
    }
  }
  if (assets.isEmpty) return null;
  return (
    tag.replaceFirst(RegExp(r'^[vV]'), ''),
    release['body'] is String ? release['body'] as String : '',
    page.toString(),
    assets,
  );
}
