import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:moodoo/l10n/app_localizations.dart';
import 'package:moodoo/services/mood_service.dart';
import 'package:moodoo/widgets/grade_card.dart';
import 'package:moodoo/widgets/moodoo_text.dart';
import 'package:moodoo/widgets/tap_bounce.dart';

class CalendarPageHeader extends StatelessWidget {
  final MonthSummary summary;

  const CalendarPageHeader({super.key, required this.summary});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final topPadding = MediaQuery.of(context).padding.top;

    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Theme.of(context).scaffoldBackgroundColor,
            Theme.of(context).scaffoldBackgroundColor.withValues(alpha: 0),
          ],
          stops: const [0.65, 1.0],
        ),
      ),
      child: Padding(
        padding: EdgeInsets.fromLTRB(20, topPadding + 8, 20, 0),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(28),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 24, sigmaY: 24),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.black.withValues(alpha: 0.55),
                borderRadius: BorderRadius.circular(28),
              ),
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      TapBounce(
                        onTap: () => Navigator.of(context).pop(),
                        child: Icon(
                          Icons.arrow_back_ios_new_rounded,
                          size: 28,
                          color: Theme.of(context).textTheme.titleMedium?.color,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          MoodooText(
                            MoodService.monthName(l10n, summary.month),
                            variant: MoodooTextVariant.displayLarge,
                            fontSize: 25,
                          ),
                          const SizedBox(height: 2),
                          MoodooText(
                            '${summary.year}',
                            variant: MoodooTextVariant.titleMedium,
                            fontSize: 17,
                          ),
                        ],
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      GradeCard(
                        grade: summary.averageScore,
                        size: 60,
                        borderRadius: 18,
                        fontSize: 20,
                      ),
                      const SizedBox(height: 4),
                      MoodooText(
                        l10n.averageMood,
                        variant: MoodooTextVariant.titleSmall,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
