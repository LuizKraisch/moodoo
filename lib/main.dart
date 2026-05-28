import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:moodoo/l10n/app_localizations.dart';
import 'package:moodoo/theme/app_theme.dart' show lightTheme, darkTheme;
import 'package:moodoo/preferences/locale_preferences.dart';
import 'package:moodoo/preferences/notification_preferences.dart';
import 'package:moodoo/preferences/onboarding_preferences.dart';
import 'package:moodoo/pages/auth_gate.dart';
import 'package:moodoo/services/notification_service.dart';
import 'package:moodoo/preferences/theme_preferences.dart';

void main() async {
  final widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  await loadTheme();
  await loadLocale();
  await loadNotificationPrefs();
  await loadOnboardingPrefs();

  await NotificationService.initialize();
  await NotificationService.rescheduleFromPrefs();

  FlutterNativeSplash.remove();
  runApp(const MoodooApp());
}

class MoodooApp extends StatelessWidget {
  const MoodooApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<Locale>(
      valueListenable: localeNotifier,
      builder: (context, locale, _) {
        return ValueListenableBuilder<ThemeMode>(
          valueListenable: themeModeNotifier,
          builder: (context, themeMode, _) {
            return MaterialApp(
              title: 'moodoo',
              debugShowCheckedModeBanner: false,
              locale: locale,
              localizationsDelegates: AppLocalizations.localizationsDelegates,
              supportedLocales: AppLocalizations.supportedLocales,
              theme: lightTheme,
              darkTheme: darkTheme,
              themeMode: themeMode,
              home: const AuthGate(),
            );
          },
        );
      },
    );
  }
}
