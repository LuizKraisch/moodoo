import 'package:flutter/material.dart';
import 'package:moodoo/widgets/moodoo_text.dart';
import 'package:moodoo/widgets/grade_card.dart';
import 'package:moodoo/widgets/tap_bounce.dart';

class DayCard extends StatelessWidget {
  final VoidCallback? onTap;

  const DayCard({super.key, this.onTap});

  @override
  Widget build(BuildContext context) {
    return TapBounce(
      peakScale: 1.06,
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.all(6),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.primary,
          borderRadius: BorderRadius.circular(25),
        ),
        child: Padding(
          padding: EdgeInsets.all(15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              MoodooText('monday', variant: MoodooTextVariant.titleSmall),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  MoodooText(
                    '1',
                    variant: MoodooTextVariant.displaySmall,
                    fontSize: 30,
                  ),
                  GradeCard(grade: "A"),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
