import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:moodoo/services/mood_service.dart';
import 'package:moodoo/widgets/grade_card.dart';
import 'package:moodoo/widgets/moodoo_text.dart';
import 'package:moodoo/widgets/tap_bounce.dart';

class CalendarPageHeader extends StatelessWidget {
  final MonthSummary summary;

  const CalendarPageHeader({super.key, required this.summary});

  @override
  Widget build(BuildContext context) {
    final topPadding = MediaQuery.of(context).padding.top;

    return ClipRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 24, sigmaY: 24),
        child: Container(
          color: Theme.of(
            context,
          ).scaffoldBackgroundColor.withValues(alpha: 0.75),
          child: Padding(
            padding: EdgeInsets.fromLTRB(20, topPadding, 20, 10),
            child: Container(
              padding: const EdgeInsets.fromLTRB(6, 12, 6, 6),
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
                      const SizedBox(width: 10),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          MoodooText(
                            MoodService.monthName(summary.month),
                            variant: MoodooTextVariant.displayLarge,
                            fontSize: 25,
                          ),
                          MoodooText(
                            '${summary.year}',
                            variant: MoodooTextVariant.titleMedium,
                            fontSize: 18,
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
                        'average mood',
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
