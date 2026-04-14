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
  final _selectedRowKey = GlobalKey();
  late final AnimationController _expandController;
  late final CurvedAnimation _sizeCurve;
  late final CurvedAnimation _fadeCurve;
  final _scrollController = ScrollController();
  bool _headerVisible = true;
  double _lastScrollOffset = 0;

  static const int _crossAxisCount = 3;
  static const int _itemCount = 30;

  void _onScroll() {
    final offset = _scrollController.offset;
    final isScrollingDown = offset > _lastScrollOffset;
    _lastScrollOffset = offset;

    if (isScrollingDown && _headerVisible && offset > 10) {
      setState(() => _headerVisible = false);
    } else if (!isScrollingDown && !_headerVisible) {
      setState(() => _headerVisible = true);
    }
  }

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
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
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    _expandController.dispose();
    _sizeCurve.dispose();
    _fadeCurve.dispose();
    super.dispose();
  }

  void _scrollToRow() {
    final ctx = _selectedRowKey.currentContext;
    if (ctx != null) {
      Scrollable.ensureVisible(
        ctx,
        duration: const Duration(milliseconds: 380),
        curve: Curves.easeOutCubic,
        alignment: 0.0,
      );
    }
  }

  Future<void> _onCardTap(int index) async {
    if (_selectedIndex == index) {
      await _expandController.reverse();
      if (mounted) setState(() => _selectedIndex = null);
    } else if (_selectedIndex != null) {
      await _expandController.reverse();
      if (mounted) setState(() => _selectedIndex = index);
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) {
          _expandController.forward(from: 0);
          _scrollToRow();
        }
      });
    } else {
      setState(() => _selectedIndex = index);
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) {
          _expandController.forward(from: 0);
          _scrollToRow();
        }
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
                AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                  height: _headerVisible ? 130 : 0,
                ),
                Expanded(
                  child: SingleChildScrollView(
                    controller: _scrollController,
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
                                  key: selectedInThisRow ? _selectedRowKey : null,
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
            child: AnimatedSlide(
              offset: _headerVisible ? Offset.zero : const Offset(0, -1),
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut,
              child: AnimatedOpacity(
                opacity: _headerVisible ? 1.0 : 0.0,
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOut,
                child: CalendarPageHeader(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
