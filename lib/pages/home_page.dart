import 'package:flutter/material.dart';
import 'package:moodoo/widgets/home_page_footer.dart';
import 'package:moodoo/widgets/home_page_header.dart';
import 'package:moodoo/widgets/month_card.dart';
import 'package:moodoo/widgets/year_dropdown.dart';

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
                  YearDropdown(),
                  SizedBox(height: 20),
                  Expanded(
                    child: GridView.count(
                      padding: const EdgeInsets.fromLTRB(0, 0, 0, 20),
                      crossAxisCount: 2,
                      children: List.generate(12, (index) {
                        return MonthCard();
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
