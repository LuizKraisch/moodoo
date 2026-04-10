import 'package:flutter/material.dart';
import 'package:moodoo/pages/calendar_page.dart';
import 'package:moodoo/routes/card_expand_route.dart';
import 'package:moodoo/widgets/home_page_footer.dart';
import 'package:moodoo/widgets/home_page_header.dart';
import 'package:moodoo/widgets/month_card.dart';
import 'package:moodoo/widgets/tap_bounce.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _cardKeys = List.generate(12, (_) => GlobalKey());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(25, 0, 25, 0),
            child: Column(
              children: [
                // YearDropdown(), --- When more years are added, this will be used to select the year to display ---
                Expanded(
                  child: GridView.count(
                    padding: const EdgeInsets.fromLTRB(0, 160, 0, 140),
                    crossAxisCount: 2,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                    children: List.generate(12, (index) {
                      return Container(
                        key: _cardKeys[index],
                        child: TapBounce(
                          peakScale: 1.06,
                          onTap: () {
                            final renderBox =
                                _cardKeys[index].currentContext
                                        ?.findRenderObject()
                                    as RenderBox?;
                            if (renderBox == null) return;
                            final rect =
                                renderBox.localToGlobal(Offset.zero) &
                                renderBox.size;
                            Navigator.push(
                              context,
                              CardExpandRoute(
                                page: const CalendarPage(),
                                sourceRect: rect,
                                cardColor: Theme.of(
                                  context,
                                ).colorScheme.primary,
                              ),
                            );
                          },
                          child: MonthCard(),
                        ),
                      );
                    }),
                  ),
                ),
              ],
            ),
          ),
          Positioned(top: 0, left: 0, right: 0, child: HomePageHeader()),
          Positioned(bottom: 0, left: 0, right: 0, child: HomePageFooter()),
        ],
      ),
    );
  }
}
