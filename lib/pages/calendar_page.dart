import 'dart:math';
import 'package:flutter/material.dart';
import 'package:moodoo/widgets/day_card.dart';
import 'package:moodoo/widgets/grade_card.dart';
import 'package:moodoo/widgets/tap_bounce.dart';

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
      curve: Curves.easeInOutCubic,
      reverseCurve: Curves.easeInCubic,
    );
    _fadeCurve = CurvedAnimation(
      parent: _expandController,
      curve: const Interval(0.0, 0.7, curve: Curves.easeIn),
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
      _expandController.forward(from: 0);
    }
  }

  Widget _buildExpandedPanel(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(6, 6, 6, 6),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primary,
        borderRadius: BorderRadius.circular(25),
      ),
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'sunday, march 1',
                      style: Theme.of(context).textTheme.titleSmall,
                    ),
                    Text('2026', style: Theme.of(context).textTheme.titleSmall),
                  ],
                ),
                TapBounce(
                  child: FilledButton(
                    onPressed: () {},
                    style: FilledButton.styleFrom(
                      shape: StadiumBorder(),
                      backgroundColor: Theme.of(context).colorScheme.surface,
                      foregroundColor: Theme.of(context).colorScheme.primary,
                      textStyle: TextTheme.of(context).labelMedium,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 24,
                        vertical: 14,
                      ),
                    ),
                    child: const Text('edit mood'),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '"Lorem ipsum dolor sit amet, consectetur adipiscing elit. Etiam egestas velit massa, eu auctor neque placerat vel. Vestibulum eleifend ipsum turpis, quis ornare metus placerat vel."',
                        style: Theme.of(context).textTheme.titleSmall?.copyWith(
                          color: Theme.of(context).colorScheme.surface,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'added on march 1, 2026 at 2:48 PM',
                        style: Theme.of(
                          context,
                        ).textTheme.bodySmall?.copyWith(fontSize: 12),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 10),
                GradeCard(grade: "A", size: 60, borderRadius: 15, fontSize: 30),
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(120),
        child: AppBar(
          automaticallyImplyLeading: false,
          scrolledUnderElevation: 0,
          titleSpacing: 20,
          centerTitle: false,
          toolbarHeight: 120,
          title: Row(
            children: [
              GestureDetector(
                onTap: () => Navigator.of(context).pop(),
                child: Icon(
                  Icons.arrow_back_ios_new_rounded,
                  size: 35,
                  color: Theme.of(context).textTheme.titleMedium?.color,
                ),
              ),
              const SizedBox(width: 5),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "january",
                    style: Theme.of(context).textTheme.displayLarge,
                  ),
                  const SizedBox(height: 4),
                  Text("2026", style: Theme.of(context).textTheme.titleSmall),
                ],
              ),
              const Spacer(),
              Column(
                children: [
                  const SizedBox(height: 20),
                  GradeCard(
                    grade: "A",
                    size: 70,
                    borderRadius: 20,
                    fontSize: 35,
                  ),
                  const SizedBox(height: 5),
                  Text(
                    "average mood",
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                ],
              ),
              const SizedBox(width: 10),
            ],
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 10),
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 20),
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
                                  child: _buildExpandedPanel(context),
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
    );
  }
}
