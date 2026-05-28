import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

final localeNotifier = ValueNotifier<Locale>(const Locale('en'));

const _localePrefKey = 'locale';

Future<void> loadLocale() async {
  final prefs = await SharedPreferences.getInstance();
  final saved = prefs.getString(_localePrefKey);
  if (saved != null) {
    localeNotifier.value = Locale(saved);
  }
}

Future<void> saveLocale(String languageCode) async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.setString(_localePrefKey, languageCode);
}
