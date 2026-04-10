import 'dart:math';
import 'package:flutter/material.dart';
import 'package:moodoo/widgets/calendar_page_header.dart';
import 'package:moodoo/widgets/day_card.dart';
import 'package:moodoo/widgets/day_expanded_panel.dart';

class CalendarPage extends StatefulWidget {
  const CalendarPage({super.key});

  @override
  State<CalendarPage> createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage>
    with SingleTickerProviderStateMixin {
  int? _selectedIndex;
  late final AnimationController _expandController;
  late final CurvedAnimation _sizeCurve;
  late final CurvedAnimation _fadeCurve;

  static const int _crossAxisCount = 3;
  static const int _itemCount = 30;

  @override
  void initState() {
    super.initState();
    _expandController = AnimationController(
      duration: const Duration(milliseconds: 380),
      vsync: this,
    );
    _sizeCurve = CurvedAnimation(
      parent: _expandController,
      curve: Curves.easeOutCubic,
      reverseCurve: Curves.easeInCubic,
    );
    _fadeCurve = CurvedAnimation(
      parent: _expandController,
      curve: const Interval(0.0, 0.7, curve: Curves.easeOut),
      reverseCurve: const Interval(0.0, 0.5, curve: Curves.easeOut),
    );
  }

  @override
  void dispose() {
    _expandController.dispose();
    _sizeCurve.dispose();
    _fadeCurve.dispose();
    super.dispose();
  }

  Future<void> _onCardTap(int index) async {
    if (_selectedIndex == index) {
      await _expandController.reverse();
      if (mounted) setState(() => _selectedIndex = null);
    } else if (_selectedIndex != null) {
      await _expandController.reverse();
      if (mounted) setState(() => _selectedIndex = index);
      _expandController.forward(from: 0);
    } else {
      setState(() => _selectedIndex = index);
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) _expandController.forward(from: 0);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 130),
                Expanded(
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 60, bottom: 20),
                      child: Column(
                        children: List.generate(
                          ((_itemCount + _crossAxisCount - 1) / _crossAxisCount)
                              .ceil(),
                          (rowIndex) {
                            final startIdx = rowIndex * _crossAxisCount;
                            final endIdx = min(
                              startIdx + _crossAxisCount,
                              _itemCount,
                            );
                            final itemsInRow = endIdx - startIdx;
                            final selectedInThisRow =
                                _selectedIndex != null &&
                                _selectedIndex! >= startIdx &&
                                _selectedIndex! < endIdx;

                            return Column(
                              children: [
                                Row(
                                  children: [
                                    ...List.generate(itemsInRow, (i) {
                                      final idx = startIdx + i;
                                      return Expanded(
                                        child: AspectRatio(
                                          aspectRatio: 1.0,
                                          child: DayCard(
                                            onTap: () => _onCardTap(idx),
                                          ),
                                        ),
                                      );
                                    }),
                                    ...List.generate(
                                      _crossAxisCount - itemsInRow,
                                      (_) => const Expanded(child: SizedBox()),
                                    ),
                                  ],
                                ),
                                if (selectedInThisRow)
                                  SizeTransition(
                                    sizeFactor: _sizeCurve,
                                    axisAlignment: -1,
                                    child: FadeTransition(
                                      opacity: _fadeCurve,
                                      child: const DayExpandedPanel(),
                                    ),
                                  ),
                              ],
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            height: 210,
            child: IgnorePointer(
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Theme.of(context).scaffoldBackgroundColor,
                      Theme.of(
                        context,
                      ).scaffoldBackgroundColor.withValues(alpha: 0.95),
                      Theme.of(
                        context,
                      ).scaffoldBackgroundColor.withValues(alpha: 0.85),
                      Theme.of(
                        context,
                      ).scaffoldBackgroundColor.withValues(alpha: 0.6),
                      Theme.of(
                        context,
                      ).scaffoldBackgroundColor.withValues(alpha: 0.3),
                      Theme.of(
                        context,
                      ).scaffoldBackgroundColor.withValues(alpha: 0.1),
                      Theme.of(
                        context,
                      ).scaffoldBackgroundColor.withValues(alpha: 0),
                    ],
                    stops: const [0.6, 0.68, 0.76, 0.85, 0.92, 0.97, 1.0],
                  ),
                ),
              ),
            ),
          ),
          Positioned(top: 0, left: 0, right: 0, child: CalendarPageHeader()),
        ],
      ),
    );
  }
}
