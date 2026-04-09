import 'package:flutter/material.dart';
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
              Text('monday', style: Theme.of(context).textTheme.titleSmall),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '1',
                    style: Theme.of(
                      context,
                    ).textTheme.displaySmall?.copyWith(fontSize: 30),
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
