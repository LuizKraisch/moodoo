import 'package:flutter/material.dart';
import 'package:moodoo/l10n/app_localizations.dart';
import 'package:moodoo/locale_preferences.dart';
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
    final l10n = AppLocalizations.of(context)!;
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 24, 0, 40),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          MoodooButton(
            text: l10n.signOut,
            onTap: () => Navigator.of(context).pop(true),
            backgroundColor: Colors.red.withValues(alpha: 0.15),
            foregroundColor: Colors.red,
            padding: const EdgeInsets.symmetric(vertical: 16),
            bouncePeakScale: 1.04,
          ),
          const SizedBox(height: 12),
          MoodooButton(
            text: l10n.cancel,
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

class _LanguageSheet extends StatelessWidget {
  const _LanguageSheet({required this.languages, required this.currentCode});

  final Map<String, String> languages;
  final String currentCode;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 24, 0, 40),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: languages.entries.map((e) {
          final isSelected = e.key == currentCode;
          return Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: MoodooButton(
              text: e.value,
              bouncePeakScale: 1.04,
              padding: const EdgeInsets.symmetric(vertical: 16),
              backgroundColor: isSelected
                  ? Theme.of(context).textTheme.displayLarge!.color!
                  : Theme.of(
                      context,
                    ).colorScheme.secondary.withValues(alpha: 0.15),
              foregroundColor: isSelected
                  ? Theme.of(context).colorScheme.surface
                  : Theme.of(context).textTheme.titleMedium!.color!,
              onTap: () {
                localeNotifier.value = Locale(e.key);
                saveLocale(e.key);
                Navigator.of(context).pop();
              },
            ),
          );
        }).toList(),
      ),
    );
  }
}

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  void signout(BuildContext context) async {
    final l10n = AppLocalizations.of(context)!;
    final confirmed = await showMoodooModal<bool>(
      context,
      title: l10n.signOut,
      subtitle: l10n.areYouSure,
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
    final l10n = AppLocalizations.of(context)!;
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
                MoodooText(
                  l10n.theme,
                  variant: MoodooTextVariant.headlineMedium,
                ),
                const SizedBox(height: 5),
                Row(
                  children: [
                    MoodooText(
                      l10n.light,
                      variant: MoodooTextVariant.titleSmall,
                    ),
                    const SizedBox(width: 5),
                    Switch(
                      value: isDark,
                      onChanged: (value) {
                        final mode = value ? ThemeMode.dark : ThemeMode.light;
                        themeModeNotifier.value = mode;
                        saveTheme(mode);
                      },
                    ),
                    const SizedBox(width: 5),
                    MoodooText(
                      l10n.dark,
                      variant: MoodooTextVariant.titleSmall,
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                MoodooText(
                  l10n.language,
                  variant: MoodooTextVariant.headlineMedium,
                ),
                const SizedBox(height: 10),
                ValueListenableBuilder<Locale>(
                  valueListenable: localeNotifier,
                  builder: (context, locale, _) {
                    final languages = {
                      'en': l10n.english,
                      'pt': l10n.portuguese,
                      'fr': l10n.french,
                      'de': l10n.german,
                      'es': l10n.spanish,
                    };
                    return MoodooButton(
                      text: l10n.changeLanguage,
                      fullWidth: false,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 24,
                        vertical: 10,
                      ),
                      bouncePeakScale: 1.04,
                      onTap: () {
                        showMoodooModal<void>(
                          context,
                          title: l10n.language,
                          child: _LanguageSheet(
                            languages: languages,
                            currentCode: locale.languageCode,
                          ),
                        );
                      },
                    );
                  },
                ),
                const Spacer(),
                const SizedBox(height: 20),
                MoodooButton(
                  text: l10n.signOut,
                  onTap: () => signout(context),
                  backgroundColor: Colors.red.withValues(alpha: 0.15),
                  foregroundColor: Colors.red,
                ),
                const SizedBox(height: 10),
                Center(
                  child: MoodooText(
                    l10n.loggedAs(AuthService().getCurrentUser()?.email ?? ''),
                    variant: MoodooTextVariant.titleMedium,
                    fontSize: 13,
                  ),
                ),
                const SizedBox(height: 40),
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
