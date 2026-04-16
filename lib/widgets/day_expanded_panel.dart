import 'package:flutter/material.dart';
import 'package:moodoo/models/mood.dart';
import 'package:moodoo/services/mood_service.dart';
import 'package:moodoo/widgets/mood_sheet.dart';
import 'package:moodoo/widgets/grade_card.dart';
import 'package:moodoo/widgets/moodoo_button.dart';
import 'package:moodoo/widgets/moodoo_modal.dart';
import 'package:moodoo/widgets/moodoo_text.dart';

class DayExpandedPanel extends StatelessWidget {
  final DateTime date;
  final Mood? mood;

  const DayExpandedPanel({super.key, required this.date, this.mood});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(6, 6, 6, 6),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primary,
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
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    MoodooText(
                      MoodService.formatDayHeader(date),
                      variant: MoodooTextVariant.titleSmall,
                    ),
                    MoodooText(
                      '${date.year}',
                      variant: MoodooTextVariant.titleSmall,
                    ),
                  ],
                ),
                MoodooButton(
                  text: mood == null ? 'add mood' : 'edit mood',
                  onTap: () {
                    final now = DateTime.now();
                    final isToday = date.year == now.year &&
                        date.month == now.month &&
                        date.day == now.day;
                    showMoodooModal(
                      context,
                      title: isToday
                          ? 'how are you feeling today?'
                          : 'how did you feel that day?',
                      child: MoodSheet(date: date, mood: mood),
                    );
                  },
                  backgroundColor:
                      Theme.of(context).brightness == Brightness.dark
                      ? const Color(0xFFFFFFFF)
                      : Theme.of(context).colorScheme.surface,
                  foregroundColor: Theme.of(context).colorScheme.primary,
                  textStyle: TextTheme.of(context).labelMedium,
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
                                color:
                                    Theme.of(context).brightness ==
                                        Brightness.dark
                                    ? const Color(0xFFFFFFFF)
                                    : Theme.of(context).colorScheme.surface,
                              ),
                            const SizedBox(height: 4),
                            MoodooText(
                              MoodService.formatCreatedAt(
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
