import 'package:flutter/material.dart';
import 'package:moodoo/theme_preferences.dart'
    show themeModeNotifier, saveTheme;

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        scrolledUnderElevation: 0,
        titleSpacing: 15,
        centerTitle: false,
        title: Padding(
          padding: const EdgeInsets.only(top: 20),
          child: Row(
            children: [
              GestureDetector(
                onTap: () => Navigator.of(context).pop(),
                child: Icon(
                  Icons.arrow_back_ios_new_rounded,
                  size: 35,
                  color: Theme.of(context).textTheme.titleMedium?.color,
                ),
              ),
              SizedBox(width: 5),
              Text('settings', style: Theme.of(context).textTheme.displayLarge),
            ],
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(25, 10, 25, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 10),
            Text("theme", style: Theme.of(context).textTheme.headlineMedium),
            SizedBox(height: 5),
            Row(
              children: [
                Text("light", style: Theme.of(context).textTheme.titleSmall),
                SizedBox(width: 5),
                Switch(
                  value: isDark,
                  onChanged: (value) {
                    final mode = value ? ThemeMode.dark : ThemeMode.light;
                    themeModeNotifier.value = mode;
                    saveTheme(mode);
                  },
                ),
                SizedBox(width: 5),
                Text("dark", style: Theme.of(context).textTheme.titleSmall),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
