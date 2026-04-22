import 'package:flutter/material.dart';
import 'package:moodoo/l10n/app_localizations.dart';
import 'package:moodoo/app_theme.dart' show lightTheme, darkTheme;
import 'package:moodoo/locale_preferences.dart';
import 'package:moodoo/pages/auth_gate.dart';
import 'package:moodoo/theme_preferences.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await loadTheme();
  await loadLocale();
  try {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  } catch (_) {}

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
