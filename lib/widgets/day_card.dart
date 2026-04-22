import 'package:flutter/material.dart';
import 'package:moodoo/l10n/app_localizations.dart';
import 'package:moodoo/models/mood.dart';
import 'package:moodoo/services/mood_service.dart';
import 'package:moodoo/widgets/grade_card.dart';
import 'package:moodoo/widgets/moodoo_text.dart';
import 'package:moodoo/widgets/tap_bounce.dart';

class DayCard extends StatelessWidget {
  final DateTime date;
  final Mood? mood;
  final VoidCallback? onTap;

  const DayCard({super.key, required this.date, this.mood, this.onTap});

  static const _futureColorDark = Color(0xFF131313);
  static const _futureColorLight = Color(0xFFC3C3C3);

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    if (date.isAfter(today)) {
      final isDark = Theme.of(context).brightness == Brightness.dark;
      return Container(
        margin: const EdgeInsets.all(6),
        decoration: BoxDecoration(
          color: isDark ? _futureColorDark : _futureColorLight,
          borderRadius: BorderRadius.circular(25),
        ),
      );
    }

    return TapBounce(
      peakScale: 1.06,
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.all(6),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.primary,
          borderRadius: BorderRadius.circular(25),
        ),
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              MoodooText(
                MoodService.weekdayName(l10n, date.weekday),
                variant: MoodooTextVariant.titleSmall,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  MoodooText(
                    '${date.day}',
                    variant: MoodooTextVariant.displaySmall,
                    fontSize: 30,
                  ),
                  GradeCard(grade: mood?.score),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
