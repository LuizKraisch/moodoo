import 'package:flutter/material.dart';
import 'package:moodoo/l10n/app_localizations.dart';
import 'package:moodoo/preferences/notification_preferences.dart';
import 'package:moodoo/services/api_service.dart';
import 'package:moodoo/services/notification_service.dart';
import 'package:moodoo/widgets/sheets/time_picker_sheet.dart';
import 'package:moodoo/widgets/shared/moodoo_text.dart';

class ReminderSettingsSection extends StatelessWidget {
  const ReminderSettingsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return ValueListenableBuilder<bool>(
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
                      await saveNotificationPrefs(enabled: value, time: time);
                      ApiService()
                          .updateAccount(
                            notificationEnabled: value,
                            notificationTime:
                                '${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}',
                          )
                          .catchError((_) {});
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
                            final picked = await showTimePickerSheet(
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
                            ApiService()
                                .updateAccount(
                                  notificationTime:
                                      '${picked.hour.toString().padLeft(2, '0')}:${picked.minute.toString().padLeft(2, '0')}',
                                )
                                .catchError((_) {});
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
                              borderRadius: BorderRadius.circular(20),
                              color: Theme.of(context)
                                  .colorScheme
                                  .secondary
                                  .withValues(
                                    alpha: Theme.of(context).brightness ==
                                            Brightness.dark
                                        ? 0.35
                                        : 0.15,
                                  ),
                            ),
                            child: Row(
                              children: [
                                MoodooText(
                                  l10n.reminderTime,
                                  variant: MoodooTextVariant.titleSmall,
                                ),
                                const Spacer(),
                                MoodooText(
                                  time.format(context),
                                  variant: MoodooTextVariant.titleSmall,
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
    );
  }
}
