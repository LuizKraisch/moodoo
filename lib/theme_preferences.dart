import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

final themeModeNotifier = ValueNotifier<ThemeMode>(ThemeMode.system);

const _themePrefKey = 'theme_mode';

Future<void> loadTheme() async {
  final prefs = await SharedPreferences.getInstance();
  final saved = prefs.getString(_themePrefKey);
  if (saved == 'light') {
    themeModeNotifier.value = ThemeMode.light;
  } else if (saved == 'dark') {
    themeModeNotifier.value = ThemeMode.dark;
  }
}

Future<void> saveTheme(ThemeMode mode) async {
  final prefs = await SharedPreferences.getInstance();
  switch (mode) {
    case ThemeMode.light:
      await prefs.setString(_themePrefKey, 'light');
    case ThemeMode.dark:
      await prefs.setString(_themePrefKey, 'dark');
    case ThemeMode.system:
      await prefs.remove(_themePrefKey);
  }
}
