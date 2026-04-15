import 'package:flutter/material.dart';
import 'package:moodoo/widgets/add_mood_sheet.dart';
import 'package:moodoo/widgets/moodoo_button.dart';
import 'package:moodoo/widgets/moodoo_modal.dart';
import 'package:moodoo/widgets/moodoo_text.dart';
import 'package:moodoo/widgets/grade_card.dart';

class DayExpandedPanel extends StatelessWidget {
  const DayExpandedPanel({super.key});

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
                      'sunday, march 1',
                      variant: MoodooTextVariant.titleSmall,
                    ),
                    MoodooText('2026', variant: MoodooTextVariant.titleSmall),
                  ],
                ),
                MoodooButton(
                  text: 'edit mood',
                  onTap: () => showMoodooModal(context, title: 'how are you feeling today?', child: const AddMoodSheet()),
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
            const SizedBox(height: 15),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      MoodooText(
                        '"Feeling good today, got some things done and had a nice walk outside."',
                        variant: MoodooTextVariant.titleSmall,
                        color: Theme.of(context).brightness == Brightness.dark
                            ? const Color(0xFFFFFFFF)
                            : Theme.of(context).colorScheme.surface,
                      ),
                      const SizedBox(height: 4),
                      MoodooText(
                        'added on march 1, 2026 at 2:48 PM',
                        variant: MoodooTextVariant.bodySmall,
                        fontSize: 12,
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 10),
                GradeCard(grade: "A", size: 60, borderRadius: 15, fontSize: 30),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
