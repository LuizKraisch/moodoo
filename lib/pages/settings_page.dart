import 'package:flutter/material.dart';
import 'package:moodoo/theme_preferences.dart'
    show themeModeNotifier, saveTheme;
import 'package:moodoo/widgets/moodoo_button.dart';
import 'package:moodoo/widgets/moodoo_modal.dart';
import 'package:moodoo/widgets/moodoo_text.dart';
import 'package:moodoo/services/auth/auth_service.dart';

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
            backgroundColor: Colors.red,
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(vertical: 16),
            bouncePeakScale: 1.04,
          ),
          const SizedBox(height: 12),
          MoodooButton(
            text: 'cancel',
            onTap: () => Navigator.of(context).pop(false),
            backgroundColor: Theme.of(context).colorScheme.secondary.withValues(alpha: 0.15),
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
      subtitle: 'are you sure you want to sign out?',
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
              MoodooText('settings', variant: MoodooTextVariant.displayLarge),
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
              backgroundColor: Colors.red,
              foregroundColor: Colors.white,
            ),
            SizedBox(height: 10),
            Center(
              child: MoodooText(
                "logged in as ${AuthService().getCurrentUser()?.email}",
                variant: MoodooTextVariant.titleMedium,
                fontSize: 13,
              ),
            ),
            SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}
