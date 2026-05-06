import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class NotificationService {
  static final _plugin = FlutterLocalNotificationsPlugin();

  static const _channelId = 'mood_reminder';
  static const _channelName = 'Mood Reminder';
  static const _notificationId = 0;
  static const _titleKey = 'notification_title';
  static const _bodyKey = 'notification_body';

  static const _notificationDetails = NotificationDetails(
    android: AndroidNotificationDetails(
      _channelId,
      _channelName,
      importance: Importance.defaultImportance,
      priority: Priority.defaultPriority,
      largeIcon: DrawableResourceAndroidBitmap('moodoo_cow_notification'),
    ),
    iOS: DarwinNotificationDetails(),
  );

  static Future<void> initialize() async {
    tz.initializeTimeZones();
    final localTimezone = await FlutterTimezone.getLocalTimezone();
    tz.setLocalLocation(tz.getLocation(localTimezone));

    await _plugin.initialize(
      const InitializationSettings(
        android: AndroidInitializationSettings('@mipmap/launcher_icon'),
        iOS: DarwinInitializationSettings(
          requestAlertPermission: false,
          requestBadgePermission: false,
          requestSoundPermission: false,
        ),
      ),
    );
  }

  static Future<bool> requestPermissions() async {
    final android = _plugin
        .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin
        >();
    final ios = _plugin
        .resolvePlatformSpecificImplementation<
          IOSFlutterLocalNotificationsPlugin
        >();

    final androidGranted = await android?.requestNotificationsPermission();
    final iosGranted = await ios?.requestPermissions(
      alert: true,
      badge: true,
      sound: true,
    );

    return androidGranted ?? iosGranted ?? true;
  }

  static Future<void> scheduleDailyReminder({
    required int hour,
    required int minute,
    required String title,
    required String body,
  }) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_titleKey, title);
    await prefs.setString(_bodyKey, body);

    final now = tz.TZDateTime.now(tz.local);
    var scheduled = tz.TZDateTime(
      tz.local,
      now.year,
      now.month,
      now.day,
      hour,
      minute,
    );

    if (scheduled.isBefore(now)) {
      scheduled = scheduled.add(const Duration(days: 1));
    }

    await _plugin.zonedSchedule(
      _notificationId,
      title,
      body,
      scheduled,
      _notificationDetails,
      matchDateTimeComponents: DateTimeComponents.time,
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
    );
  }

  static Future<void> cancelReminder() async {
    await _plugin.cancel(_notificationId);
  }

  static Future<void> rescheduleFromPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    final enabled = prefs.getBool('notification_enabled') ?? false;

    if (!enabled) return;

    final hour = prefs.getInt('notification_hour') ?? 20;
    final minute = prefs.getInt('notification_minute') ?? 0;
    final title = prefs.getString(_titleKey) ?? 'mood reminder';
    final body =
        prefs.getString(_bodyKey) ?? 'remember to add your mood for the day';

    await scheduleDailyReminder(
      hour: hour,
      minute: minute,
      title: title,
      body: body,
    );
  }
}
