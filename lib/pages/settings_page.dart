import 'package:flutter/material.dart';
import 'package:moodoo/theme_preferences.dart'
    show themeModeNotifier, saveTheme;
import 'package:moodoo/widgets/moodoo_button.dart';
import 'package:moodoo/widgets/moodoo_modal.dart';
import 'package:moodoo/widgets/moodoo_text.dart';
import 'package:moodoo/widgets/settings_page_header.dart';
import 'package:moodoo/services/auth_service.dart';

class _SignOutSheet extends StatelessWidget {
  const _SignOutSheet();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 24, 0, 40),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          MoodooButton(
            text: 'sign out',
            onTap: () => Navigator.of(context).pop(true),
            backgroundColor: Colors.red.withValues(alpha: 0.15),
            foregroundColor: Colors.red,
            padding: const EdgeInsets.symmetric(vertical: 16),
            bouncePeakScale: 1.04,
          ),
          const SizedBox(height: 12),
          MoodooButton(
            text: 'cancel',
            onTap: () => Navigator.of(context).pop(false),
            backgroundColor: Theme.of(
              context,
            ).colorScheme.secondary.withValues(alpha: 0.15),
            foregroundColor: Theme.of(context).textTheme.titleMedium!.color!,
            padding: const EdgeInsets.symmetric(vertical: 16),
            bouncePeakScale: 1.04,
          ),
        ],
      ),
    );
  }
}

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  void signout(BuildContext context) async {
    final confirmed = await showMoodooModal<bool>(
      context,
      title: 'sign out',
      subtitle: 'are you sure?',
      child: const _SignOutSheet(),
    );

    if (confirmed != true) return;

    final authService = AuthService();

    try {
      await authService.signOutFromGoogle();
      // ignore: use_build_context_synchronously
      Navigator.of(context).popUntil((route) => route.isFirst);
    } catch (e) {
      showDialog(
        // ignore: use_build_context_synchronously
        context: context,
        builder: (context) => AlertDialog(title: Text(e.toString())),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(25, 0, 25, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 140),
                MoodooText("theme", variant: MoodooTextVariant.headlineMedium),
                SizedBox(height: 5),
                Row(
                  children: [
                    MoodooText("light", variant: MoodooTextVariant.titleSmall),
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
                    MoodooText("dark", variant: MoodooTextVariant.titleSmall),
                  ],
                ),
                Spacer(),
                SizedBox(height: 20),
                MoodooButton(
                  text: 'sign out',
                  onTap: () => signout(context),
                  backgroundColor: Colors.red.withValues(alpha: 0.15),
                  foregroundColor: Colors.red,
                ),
                SizedBox(height: 10),
                Center(
                  child: MoodooText(
                    "logged as ${AuthService().getCurrentUser()?.email}",
                    variant: MoodooTextVariant.titleMedium,
                    fontSize: 13,
                  ),
                ),
                SizedBox(height: 40),
              ],
            ),
          ),
          const Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: SettingsPageHeader(),
          ),
        ],
      ),
    );
  }
}
