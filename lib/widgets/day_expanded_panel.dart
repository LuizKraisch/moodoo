import 'package:flutter/material.dart';
import 'package:moodoo/widgets/add_mood_sheet.dart';
import 'package:moodoo/widgets/grade_card.dart';
import 'package:moodoo/widgets/tap_bounce.dart';

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
                    Text(
                      'sunday, march 1',
                      style: Theme.of(context).textTheme.titleSmall,
                    ),
                    Text('2026', style: Theme.of(context).textTheme.titleSmall),
                  ],
                ),
                TapBounce(
                  onTap: () => showModalBottomSheet(
                    context: context,
                    isScrollControlled: true,
                    builder: (_) => const AddMoodSheet(),
                  ),
                  child: FilledButton(
                    onPressed: () {},
                    style: FilledButton.styleFrom(
                      shape: StadiumBorder(),
                      backgroundColor:
                          Theme.of(context).brightness == Brightness.dark
                          ? const Color(0xFFFFFFFF)
                          : Theme.of(context).colorScheme.surface,
                      foregroundColor: Theme.of(context).colorScheme.primary,
                      textStyle: TextTheme.of(context).labelMedium,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 24,
                        vertical: 14,
                      ),
                    ),
                    child: const Text('edit mood'),
                  ),
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
                      Text(
                        '"Feeling good today, got some things done and had a nice walk outside."',
                        style: Theme.of(context).textTheme.titleSmall?.copyWith(
                          color: Theme.of(context).brightness == Brightness.dark
                              ? const Color(0xFFFFFFFF)
                              : Theme.of(context).colorScheme.surface,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'added on march 1, 2026 at 2:48 PM',
                        style: Theme.of(
                          context,
                        ).textTheme.bodySmall?.copyWith(fontSize: 12),
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
