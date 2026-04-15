import 'package:flutter/material.dart';
import 'package:moodoo/widgets/moodoo_text.dart';
import 'package:moodoo/widgets/grade_card.dart';

class MonthCard extends StatelessWidget {
  const MonthCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.zero,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primary,
        borderRadius: BorderRadius.circular(30),
      ),
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Wrap(
              spacing: 5,
              runSpacing: 5,
              children: List.generate(
                4,
                (index) => Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: const [
                      Color(0xFF8258FF),
                      Color(0xFFFFC000),
                      Color(0xFF00B050),
                      Color(0xFF92D050),
                    ][index],
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    MoodooText('2026', variant: MoodooTextVariant.titleSmall),
                    MoodooText(
                      'january',
                      variant: MoodooTextVariant.displaySmall,
                    ),
                  ],
                ),
                GradeCard(grade: "A"),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
