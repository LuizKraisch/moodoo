import 'package:flutter/material.dart';
import 'package:moodoo/app_theme.dart' show lightTheme, darkTheme;
import 'package:moodoo/pages/home_page.dart';
import 'package:moodoo/theme_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await loadTheme();
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
