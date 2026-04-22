import 'package:flutter/material.dart';
import 'package:moodoo/l10n/app_localizations.dart';
import 'package:moodoo/services/mood_service.dart';
import 'package:moodoo/widgets/grade_card.dart';
import 'package:moodoo/widgets/moodoo_text.dart';

class MonthCard extends StatelessWidget {
  final MonthSummary summary;
  final bool isFuture;

  const MonthCard({super.key, required this.summary, this.isFuture = false});

  static const _gradeColors = {
    'S': Color(0xFF8258FF),
    'A': Color(0xFF00B050),
    'B': Color(0xFF92D050),
    'C': Color(0xFFE0E032),
    'D': Color(0xFFFFC000),
    'F': Color(0xFFC00000),
  };
  static const _emptyDotColor = Color(0xFFB8B8B8);

  static const _futureColorDark = Color(0xFF131313);
  static const _futureColorLight = Color(0xFFC3C3C3);

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    if (isFuture) {
      final isDark = Theme.of(context).brightness == Brightness.dark;
      return Container(
        decoration: BoxDecoration(
          color: isDark ? _futureColorDark : _futureColorLight,
          borderRadius: BorderRadius.circular(30),
        ),
      );
    }

    // Show the last 4 recorded moods as colored dots (oldest → newest).
    final recent = summary.moods.reversed.take(4).toList().reversed.toList();
    final dotColors = List.generate(4, (i) {
      if (i < recent.length) {
        return _gradeColors[recent[i].score] ?? _emptyDotColor;
      }
      return _emptyDotColor;
    });

    return Container(
      margin: EdgeInsets.zero,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primary,
        borderRadius: BorderRadius.circular(30),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Wrap(
              spacing: 5,
              runSpacing: 5,
              children: dotColors
                  .map(
                    (color) => Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: color,
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  )
                  .toList(),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    MoodooText(
                      '${summary.year}',
                      variant: MoodooTextVariant.titleSmall,
                    ),
                    MoodooText(
                      MoodService.monthName(l10n, summary.month),
                      variant: MoodooTextVariant.displaySmall,
                    ),
                  ],
                ),
                GradeCard(grade: summary.averageScore),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
