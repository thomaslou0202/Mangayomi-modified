import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:mangayomi/repositories/settings_repository.dart';
import 'package:mangayomi/modules/more/about/providers/app_release.dart';
import 'package:mangayomi/services/http/m_client.dart';
import 'package:mangayomi/utils/platform_utils.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'check_for_update.g.dart';

@riverpod
class CheckForAppUpdates extends _$CheckForAppUpdates {
  @override
  bool build() {
    return settingsRepository.current.checkForAppUpdates ?? true;
  }

  void set(bool value) {
    state = value;
    settingsRepository.update((s) => s.checkForAppUpdates = value);
  }
}

/// A file of a release, and its size in bytes.
class UpdateAsset {
  final String url;
  final int size;

  /// Lower-case hex SHA-256 GitHub publishes for the file, when it does.
  final String? sha256;

  const UpdateAsset(this.url, {this.size = 0, this.sha256});
}

/// The hex digest of GitHub's `"sha256:<hex>"` asset digest, or null.
String? sha256OfDigest(Object? digest) {
  if (digest is! String) return null;
  final match = RegExp(r'^sha256:([0-9a-fA-F]{64})$').firstMatch(digest.trim());
  return match?.group(1)!.toLowerCase();
}

/// The assets of a GitHub release worth offering: only when [parseAppRelease]
/// accepts it (a finished, stable release of our repository) and only the
/// files it names, with their size and digest. Null when it is not one.
List<UpdateAsset>? releaseUpdateAssets(Map<String, dynamic> release) {
  final parsed = parseAppRelease(release);
  if (parsed == null) return null;
  final accepted = parsed.$4.toSet();
  return [
    for (final asset in (release['assets'] as List).whereType<Map>())
      if (accepted.contains(asset['browser_download_url']))
        UpdateAsset(
          asset['browser_download_url'] as String,
          size: (asset['size'] as num).toInt(),
          sha256: sha256OfDigest(asset['digest']),
        ),
  ];
}

/// A release newer than the running version.
class UpdateInfo {
  final String version;
  final String notes;
  final String pageUrl;
  final List<UpdateAsset> assets;
  final DateTime? publishedAt;

  const UpdateInfo({
    required this.version,
    required this.notes,
    required this.pageUrl,
    this.assets = const [],
    this.publishedAt,
  });

  bool get isPreRelease => version.contains('-');
}

/// The APK for this device: of its kind (TV or not), for the first of [abis]
/// it comes in, or any APK when none names one of them.
UpdateAsset? pickApk(
  List<UpdateAsset> assets,
  List<String> abis, {
  required bool tv,
}) {
  final apks = assets
      .where((asset) => asset.url.toLowerCase().endsWith('.apk'))
      .toList();
  final ofKind = apks
      .where((apk) => apk.url.toLowerCase().contains('android-tv') == tv)
      .toList();
  final candidates = ofKind.isNotEmpty ? ofKind : apks;
  for (final abi in abis) {
    for (final apk in candidates) {
      if (apk.url.toLowerCase().contains(abi.toLowerCase())) return apk;
    }
  }
  return candidates.firstOrNull;
}

/// Automatic update-check provider.
///
/// Respects the user's [checkForAppUpdatesProvider] preference.  Returns
/// [UpdateInfo] when a newer version exists and downloadable assets are ready,
/// `null` otherwise.
@riverpod
Future<UpdateInfo?> checkForUpdate(Ref ref) async {
  if (!ref.read(checkForAppUpdatesProvider)) return null;
  return _getUpdateIfAvailable();
}

/// Compares the running version against the latest release.
/// Returns [UpdateInfo] when an update is available and assets for the current
/// platform are ready, or `null` when already up-to-date or assets are still building.
Future<UpdateInfo?> _getUpdateIfAvailable() async {
  final info = await PackageInfo.fromPlatform();
  if (kDebugMode) {
    log(info.data.toString());
  }
  final latest = await _fetchLatestRelease();
  if (latest == null) {
    return null;
  }
  if (!isNewerAppRelease(info.version, info.buildNumber, latest.version)) {
    return null;
  }
  if (!_hasPlatformAssets(latest.assets)) {
    return null;
  }
  return latest;
}

/// Validates that release assets for the current platform are present.
/// Avoids notifying users while CI build workflows are still running.
bool _hasPlatformAssets(List<UpdateAsset> assets) {
  if (assets.isEmpty) return false;

  final assetUrls = assets.map((asset) => asset.url.toLowerCase()).toList();

  if (Platform.isAndroid) {
    if (isTv) {
      return assetUrls.any((url) => url.endsWith('.apk'));
    }
    return assetUrls.any(
      (url) => url.endsWith('.apk') && !url.contains('android-tv'),
    );
  } else if (Platform.isIOS) {
    return assetUrls.any((url) => url.endsWith('.ipa'));
  } else if (Platform.isMacOS) {
    return assetUrls.any((url) => url.endsWith('.dmg') || url.endsWith('.pkg'));
  } else if (Platform.isWindows) {
    return assetUrls.any(
      (url) =>
          url.endsWith('.exe') ||
          url.endsWith('.msix') ||
          (url.endsWith('.zip') && url.contains('windows')),
    );
  } else if (Platform.isLinux) {
    return assetUrls.any(
      (url) =>
          url.endsWith('.appimage') ||
          url.endsWith('.deb') ||
          url.endsWith('.rpm') ||
          (url.endsWith('.zip') && url.contains('linux')),
    );
  }
  return true;
}

/// Performs an update check unconditionally, ignoring the auto-update setting.
Future<UpdateInfo?> performManualUpdateCheck() => _getUpdateIfAvailable();

Future<UpdateInfo?> _fetchLatestRelease() async {
  try {
    final http = MClient.init(reqcopyWith: {'useDartHttpClient': true});
    final res = await http
        .get(
          Uri.parse(appReleaseApiUrl),
          headers: {'Accept': 'application/vnd.github+json'},
        )
        .timeout(const Duration(seconds: 20));
    if (res.statusCode != 200) {
      if (kDebugMode) {
        log('GitHub releases check failed with status: ${res.statusCode}');
      }
      return null;
    }
    final release = jsonDecode(res.body) as Map<String, dynamic>;
    final tagName =
        (release['tag_name'] as String?) ?? (release['name'] as String?) ?? '';
    final cleanVersion = tagName.trim().replaceFirst(RegExp(r'^[vV]'), '');
    if (cleanVersion.isEmpty) return null;

    final body = (release['body'] as String?) ?? '';
    final htmlUrl = (release['html_url'] as String?) ?? '';
    // Drafts, previews, other repositories and half-uploaded files are not
    // offered: this used to take any asset of whatever the API returned.
    final assets = releaseUpdateAssets(release);
    if (assets == null) return null;

    return UpdateInfo(
      version: cleanVersion,
      notes: body,
      pageUrl: htmlUrl,
      assets: assets,
      publishedAt: DateTime.tryParse((release['published_at'] as String?) ?? '')
          ?.toLocal(),
    );
  } catch (e, st) {
    if (kDebugMode) {
      log('Error fetching latest release: $e\n$st');
    }
    return null;
  }
}
