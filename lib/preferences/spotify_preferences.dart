import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

final spotifyConnectedNotifier = ValueNotifier<bool>(false);
final spotifyDisplayNameNotifier = ValueNotifier<String?>(null);
final spotifyBannerDismissedNotifier = ValueNotifier<bool>(false);

const _connectedKey = 'spotify_connected';
const _displayNameKey = 'spotify_display_name';
const _bannerDismissedKey = 'spotify_banner_dismissed';

Future<void> loadSpotifyPrefs() async {
  final prefs = await SharedPreferences.getInstance();
  spotifyConnectedNotifier.value = prefs.getBool(_connectedKey) ?? false;
  spotifyDisplayNameNotifier.value = prefs.getString(_displayNameKey);
  spotifyBannerDismissedNotifier.value =
      prefs.getBool(_bannerDismissedKey) ?? false;
}

Future<void> saveSpotifyConnection({
  required bool connected,
  String? displayName,
}) async {
  spotifyConnectedNotifier.value = connected;
  spotifyDisplayNameNotifier.value = connected ? displayName : null;
  final prefs = await SharedPreferences.getInstance();
  await prefs.setBool(_connectedKey, connected);
  if (connected && displayName != null) {
    await prefs.setString(_displayNameKey, displayName);
  } else {
    await prefs.remove(_displayNameKey);
  }
}

Future<void> saveSpotifyBannerDismissed(bool dismissed) async {
  spotifyBannerDismissedNotifier.value = dismissed;
  final prefs = await SharedPreferences.getInstance();
  await prefs.setBool(_bannerDismissedKey, dismissed);
}

Future<void> applySpotifyUserJson(Map<String, dynamic> user) async {
  await saveSpotifyConnection(
    connected: user['spotify_connected'] as bool? ?? false,
    displayName: user['spotify_display_name'] as String?,
  );
  await saveSpotifyBannerDismissed(
    user['spotify_banner_dismissed'] as bool? ?? false,
  );
}

Future<void> clearSpotifyPrefs() async {
  await saveSpotifyConnection(connected: false);
  await saveSpotifyBannerDismissed(false);
}
