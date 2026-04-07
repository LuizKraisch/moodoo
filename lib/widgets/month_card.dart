import 'package:flutter/material.dart';

class MonthCard extends StatelessWidget {
  const MonthCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.secondary,
        borderRadius: BorderRadius.circular(22),
      ),
      child: Padding(
        padding: EdgeInsets.all(12),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Wrap(
              spacing: 5,
              runSpacing: 5,
              children: List.generate(4, (index) => Container(
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
              )),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '2026',
                      style: Theme.of(context).textTheme.titleSmall,
                    ),
                    Text(
                      'january',
                      style: Theme.of(context).textTheme.displaySmall,
                    ),
                  ],
                ),
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: Color(0xFF00B050),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Center(child: Text("A", style: Theme.of(context).textTheme.displaySmall)),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}