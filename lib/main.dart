import 'package:flutter/material.dart';
import 'package:moodoo/app_theme.dart' show lightTheme, darkTheme;
import 'package:moodoo/pages/home_page.dart';

void main() {
  runApp(const MoodooApp());
}

class MoodooApp extends StatelessWidget {
  const MoodooApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Moodoo App',
      debugShowCheckedModeBanner: false,
      theme: lightTheme,
      darkTheme: darkTheme,
      themeMode: ThemeMode.system,
      home: const HomePage(),
    );
  }
}
