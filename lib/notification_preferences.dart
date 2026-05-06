import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

final notificationEnabledNotifier = ValueNotifier<bool>(false);
final notificationTimeNotifier = ValueNotifier<TimeOfDay>(
  const TimeOfDay(hour: 20, minute: 0),
);

const _enabledKey = 'notification_enabled';
const _hourKey = 'notification_hour';
const _minuteKey = 'notification_minute';

Future<void> loadNotificationPrefs() async {
  final prefs = await SharedPreferences.getInstance();
  notificationEnabledNotifier.value = prefs.getBool(_enabledKey) ?? false;
  final hour = prefs.getInt(_hourKey) ?? 20;
  final minute = prefs.getInt(_minuteKey) ?? 0;
  notificationTimeNotifier.value = TimeOfDay(hour: hour, minute: minute);
}

Future<void> saveNotificationPrefs({
  required bool enabled,
  required TimeOfDay time,
}) async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.setBool(_enabledKey, enabled);
  await prefs.setInt(_hourKey, time.hour);
  await prefs.setInt(_minuteKey, time.minute);
}
