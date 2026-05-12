import 'package:flutter/material.dart';
import 'package:moodoo/app_theme.dart';
import 'package:moodoo/l10n/app_localizations.dart';
import 'package:moodoo/models/mood.dart';
import 'package:moodoo/services/mood_service.dart';
import 'package:moodoo/widgets/sheets/mood_sheet.dart';
import 'package:moodoo/widgets/shared/grade_card.dart';
import 'package:moodoo/widgets/shared/moodoo_button.dart';
import 'package:moodoo/widgets/shared/moodoo_modal.dart';
import 'package:moodoo/widgets/shared/moodoo_text.dart';

class DayExpandedPanel extends StatelessWidget {
  final DateTime date;
  final Mood? mood;

  const DayExpandedPanel({super.key, required this.date, this.mood});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Container(
      margin: const EdgeInsets.fromLTRB(6, 6, 6, 6),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.cardBackground,
        borderRadius: BorderRadius.circular(25),
      ),
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      MoodooText(
                        MoodService.formatDayHeader(l10n, date),
                        variant: MoodooTextVariant.titleSmall,
                      ),
                      MoodooText(
                        '${date.year}',
                        variant: MoodooTextVariant.titleSmall,
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 10),
                MoodooButton(
                  text: mood == null ? l10n.addMood : l10n.editMood,
                  onTap: () {
                    final now = DateTime.now();
                    final isToday =
                        date.year == now.year &&
                        date.month == now.month &&
                        date.day == now.day;
                    showMoodooModal(
                      context,
                      title: isToday
                          ? l10n.howAreYouFeelingToday
                          : l10n.howDidYouFeelThatDay,
                      child: MoodSheet(date: date, mood: mood),
                    );
                  },
                  backgroundColor: Theme.of(
                    context,
                  ).textTheme.displayLarge!.color!,
                  foregroundColor: Theme.of(context).colorScheme.surface,
                  textStyle: TextTheme.of(context).titleSmall,
                  fullWidth: false,
                ),
              ],
            ),
            if (mood != null)
              Column(
                children: [
                  const SizedBox(height: 15),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            if (mood!.notes.isNotEmpty)
                              MoodooText(
                                '"${mood!.notes}"',
                                variant: MoodooTextVariant.titleSmall,
                                color: Theme.of(
                                  context,
                                ).textTheme.displayLarge!.color!,
                              ),
                            const SizedBox(height: 4),
                            MoodooText(
                              l10n.addedOn,
                              variant: MoodooTextVariant.bodySmall,
                              fontSize: 12,
                            ),
                            MoodooText(
                              MoodService.formatDateTime(
                                l10n,
                                mood!.createdAt.toDate(),
                              ),
                              variant: MoodooTextVariant.bodySmall,
                              fontSize: 12,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 10),
                      GradeCard(
                        grade: mood!.score,
                        size: 60,
                        borderRadius: 15,
                        fontSize: 30,
                      ),
                    ],
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}
