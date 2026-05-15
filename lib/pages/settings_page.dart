import 'package:flutter/material.dart';
import 'package:moodoo/l10n/app_localizations.dart';
import 'package:moodoo/locale_preferences.dart';
import 'package:moodoo/notification_preferences.dart';
import 'package:moodoo/pages/privacy_policy_page.dart';
import 'package:moodoo/services/notification_service.dart';
import 'package:moodoo/theme_preferences.dart'
    show themeModeNotifier, saveTheme;
import 'package:moodoo/widgets/headers/moodoo_header.dart';
import 'package:moodoo/widgets/shared/moodoo_button.dart';
import 'package:moodoo/widgets/sheets/moodoo_error_sheet.dart';
import 'package:moodoo/widgets/sheets/time_picker_sheet.dart';
import 'package:moodoo/widgets/shared/moodoo_modal.dart';
import 'package:moodoo/widgets/shared/moodoo_text.dart';
import 'package:moodoo/widgets/danger_zone.dart';
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
      await authService.signOut();
      themeModeNotifier.value = ThemeMode.dark;
      await saveTheme(ThemeMode.dark);
      // ignore: use_build_context_synchronously
      Navigator.of(context).popUntil((route) => route.isFirst);
    } catch (e) {
      // ignore: use_build_context_synchronously
      showMoodooErrorSheet(context, e);
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(25, 20, 25, 0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              MoodooButton(
                text: l10n.signOut,
                onTap: () => signout(context),
                backgroundColor: Colors.red.withValues(alpha: 0.15),
                foregroundColor: Colors.red,
                bouncePeakScale: 1.1,
              ),
              const SizedBox(height: 10),
              MoodooText(
                l10n.loggedAs(AuthService().userEmail ?? ''),
                variant: MoodooTextVariant.titleMedium,
                fontSize: 13,
              ),
            ],
          ),
        ),
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
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
                      backgroundColor: Theme.of(
                        context,
                      ).textTheme.displayLarge!.color!,
                      foregroundColor: Theme.of(context).colorScheme.surface,
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
                const SizedBox(height: 20),
                MoodooText(
                  l10n.notifications,
                  variant: MoodooTextVariant.headlineMedium,
                ),
                const SizedBox(height: 5),
                ValueListenableBuilder<bool>(
                  valueListenable: notificationEnabledNotifier,
                  builder: (context, enabled, _) {
                    return AnimatedSize(
                      duration: const Duration(milliseconds: 250),
                      curve: Curves.easeInOut,
                      alignment: Alignment.topCenter,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              MoodooText(
                                l10n.dailyReminder,
                                variant: MoodooTextVariant.titleSmall,
                              ),
                              Switch(
                                value: enabled,
                                onChanged: (value) async {
                                  if (value) {
                                    final granted =
                                        await NotificationService.requestPermissions();
                                    if (!granted) return;
                                  }
                                  notificationEnabledNotifier.value = value;
                                  final time = notificationTimeNotifier.value;
                                  await saveNotificationPrefs(
                                    enabled: value,
                                    time: time,
                                  );
                                  if (value) {
                                    await NotificationService.scheduleDailyReminder(
                                      hour: time.hour,
                                      minute: time.minute,
                                      title: l10n.notificationTitle,
                                      body: l10n.notificationBody,
                                    );
                                  } else {
                                    await NotificationService.cancelReminder();
                                  }
                                },
                              ),
                            ],
                          ),
                          if (enabled)
                            Column(
                              children: [
                                MoodooText(
                                  l10n.notificationDescription,
                                  variant: MoodooTextVariant.titleMedium,
                                  fontSize: 13,
                                ),
                                const SizedBox(height: 10),
                                ValueListenableBuilder<TimeOfDay>(
                                  valueListenable: notificationTimeNotifier,
                                  builder: (context, time, _) {
                                    return GestureDetector(
                                      onTap: () async {
                                        final picked =
                                            await showTimePickerSheet(
                                              context,
                                              initialTime: time,
                                              title: l10n.reminderTime,
                                              doneLabel: l10n.done,
                                            );

                                        if (picked == null) return;

                                        notificationTimeNotifier.value = picked;
                                        await saveNotificationPrefs(
                                          enabled: true,
                                          time: picked,
                                        );

                                        // ignore: use_build_context_synchronously
                                        await NotificationService.scheduleDailyReminder(
                                          hour: picked.hour,
                                          minute: picked.minute,
                                          title: l10n.notificationTitle,
                                          body: l10n.notificationBody,
                                        );
                                      },
                                      child: Container(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 15,
                                          vertical: 10,
                                        ),
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(
                                            20,
                                          ),
                                          color: Theme.of(context)
                                              .colorScheme
                                              .secondary
                                              .withValues(
                                                alpha:
                                                    Theme.of(
                                                          context,
                                                        ).brightness ==
                                                        Brightness.dark
                                                    ? 0.35
                                                    : 0.15,
                                              ),
                                        ),
                                        child: Row(
                                          children: [
                                            MoodooText(
                                              l10n.reminderTime,
                                              variant:
                                                  MoodooTextVariant.titleSmall,
                                            ),
                                            const Spacer(),
                                            MoodooText(
                                              time.format(context),
                                              variant:
                                                  MoodooTextVariant.titleSmall,
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ],
                            ),
                        ],
                      ),
                    );
                  },
                ),
                const SizedBox(height: 20),
                MoodooText(
                  l10n.legal,
                  variant: MoodooTextVariant.headlineMedium,
                ),
                const SizedBox(height: 10),
                MoodooButton(
                  text: l10n.privacyPolicy,
                  fullWidth: false,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 10,
                  ),
                  bouncePeakScale: 1.04,
                  backgroundColor: Theme.of(
                    context,
                  ).textTheme.displayLarge!.color!,
                  foregroundColor: Theme.of(context).colorScheme.surface,
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) => const PrivacyPolicyPage(),
                      ),
                    );
                  },
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Divider(
                    radius: BorderRadius.all(Radius.circular(100)),
                    height: 50,
                    thickness: 3,
                    color: Theme.of(
                      context,
                    ).dividerColor.withValues(alpha: 0.3),
                  ),
                ),
                const DangerZone(),
                const SizedBox(height: 10),
              ],
            ),
          ),
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: MoodooHeader(title: l10n.settings),
          ),
        ],
      ),
    );
  }
}
