import 'package:flutter/material.dart';
import 'package:moodoo/widgets/home_page_footer.dart';
import 'package:moodoo/widgets/home_page_header.dart';
import 'package:moodoo/widgets/month_card.dart';
import 'package:moodoo/widgets/tap_bounce.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(25, 80, 25, 0),
              child: Column(
                children: [
                  HomePageHeader(),
                  SizedBox(height: 20),
                  // YearDropdown(), --- When more years are added, this will be used to select the year to display ---
                  SizedBox(height: 8),
                  Expanded(
                    child: GridView.count(
                      padding: const EdgeInsets.fromLTRB(0, 0, 0, 20),
                      crossAxisCount: 2,
                      children: List.generate(12, (index) {
                        return TapBounce(peakScale: 1.06, child: MonthCard());
                      }),
                    ),
                  ),
                ],
              ),
            ),
          ),
          HomePageFooter(),
        ],
      ),
    );
  }
}
