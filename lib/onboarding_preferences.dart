import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

final onboardingFinishedNotifier = ValueNotifier<bool>(false);

const _key = 'onboarding_finished';

Future<void> loadOnboardingPrefs() async {
  final prefs = await SharedPreferences.getInstance();
  onboardingFinishedNotifier.value = false; //prefs.getBool(_key) ?? false;
}

Future<void> saveOnboardingFinished() async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.setBool(_key, true);
  onboardingFinishedNotifier.value = true;
}
