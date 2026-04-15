import 'package:flutter/material.dart';
import 'package:moodoo/app_theme.dart' show lightTheme, darkTheme;
import 'package:moodoo/pages/home_page.dart';
import 'package:moodoo/theme_preferences.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await loadTheme();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(const MoodooApp());
}

class MoodooApp extends StatelessWidget {
  const MoodooApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<ThemeMode>(
      valueListenable: themeModeNotifier,
      builder: (context, themeMode, _) {
        return MaterialApp(
          title: 'Moodoo App',
          debugShowCheckedModeBanner: false,
          theme: lightTheme,
          darkTheme: darkTheme,
          themeMode: themeMode,
          home: const HomePage(),
        );
      },
    );
  }
}
