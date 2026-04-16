import 'package:flutter/material.dart';
import 'package:moodoo/models/mood.dart';
import 'package:moodoo/pages/calendar_page.dart';
import 'package:moodoo/routes/card_expand_route.dart';
import 'package:moodoo/services/firebase_service.dart';
import 'package:moodoo/services/mood_service.dart';
import 'package:moodoo/widgets/home_page_footer.dart';
import 'package:moodoo/widgets/home_page_header.dart';
import 'package:moodoo/widgets/month_card.dart';
import 'package:moodoo/widgets/month_card_skeleton.dart';
import 'package:moodoo/widgets/tap_bounce.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _cardKeys = List.generate(12, (_) => GlobalKey());
  final _scrollController = ScrollController();
  final _firebaseService = FirebaseService();
  bool _headerVisible = true;
  double _lastScrollOffset = 0;

  static const int _currentYear = 2026;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

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
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  void _onMonthTap(BuildContext context, int index, MonthSummary summary) {
    final renderBox =
        _cardKeys[index].currentContext?.findRenderObject() as RenderBox?;
    if (renderBox == null) return;
    final rect = renderBox.localToGlobal(Offset.zero) & renderBox.size;
    Navigator.push(
      context,
      CardExpandRoute(
        page: CalendarPage(summary: summary),
        sourceRect: rect,
        cardColor: Theme.of(context).colorScheme.primary,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<List<Mood>>(
        stream: _firebaseService.getMoods(),
        builder: (context, snapshot) {
          final moods = snapshot.data ?? [];
          final summaries = snapshot.hasData
              ? MoodService.buildMonthSummaries(moods, _currentYear)
              : null;

          final now = DateTime.now();
          final todayMood = moods.where((m) {
            final d = m.day.toDate();
            return d.year == now.year &&
                d.month == now.month &&
                d.day == now.day;
          }).firstOrNull;

          return Stack(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(25, 0, 25, 0),
                child: Column(
                  children: [
                    Expanded(
                      child: GridView.count(
                        controller: _scrollController,
                        padding: const EdgeInsets.fromLTRB(0, 160, 0, 140),
                        crossAxisCount: 2,
                        crossAxisSpacing: 16,
                        mainAxisSpacing: 16,
                        children: List.generate(12, (index) {
                          if (summaries == null) {
                            return Container(
                              key: _cardKeys[index],
                              child: const MonthCardSkeleton(),
                            );
                          }
                          final summary = summaries[index];
                          final isFuture = summary.year > now.year ||
                              (summary.year == now.year &&
                                  summary.month > now.month);
                          return Container(
                            key: _cardKeys[index],
                            child: isFuture
                                ? MonthCard(summary: summary, isFuture: true)
                                : TapBounce(
                                    peakScale: 1.06,
                                    onTap: () =>
                                        _onMonthTap(context, index, summary),
                                    child: MonthCard(summary: summary),
                                  ),
                          );
                        }),
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
                    child: HomePageHeader(),
                  ),
                ),
              ),
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: HomePageFooter(
                  todayMood: todayMood,
                  isLoading: !snapshot.hasData,
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
