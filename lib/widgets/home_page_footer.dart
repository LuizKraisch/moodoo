import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:moodoo/models/mood.dart';
import 'package:moodoo/widgets/grade_card.dart';
import 'package:moodoo/widgets/mood_sheet.dart';
import 'package:moodoo/widgets/moodoo_button.dart';
import 'package:moodoo/widgets/moodoo_modal.dart';
import 'package:moodoo/widgets/moodoo_text.dart';

class HomePageFooter extends StatefulWidget {
  final Mood? todayMood;
  final bool isLoading;

  const HomePageFooter({super.key, this.todayMood, this.isLoading = false});

  @override
  State<HomePageFooter> createState() => _HomePageFooterState();
}

class _HomePageFooterState extends State<HomePageFooter>
    with SingleTickerProviderStateMixin {
  late final AnimationController _shimmerController;
  late final Animation<double> _shimmerAnimation;

  @override
  void initState() {
    super.initState();
    _shimmerController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    )..repeat(reverse: true);
    _shimmerAnimation = Tween<double>(begin: 0.4, end: 1.0).animate(
      CurvedAnimation(parent: _shimmerController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _shimmerController.dispose();
    super.dispose();
  }

  void _showMoodSheet(BuildContext context) {
    showMoodooModal(
      context,
      title: 'how are you feeling today?',
      child: MoodSheet(date: DateTime.now(), mood: widget.todayMood),
    );
  }

  Widget _buildSkeleton() {
    final shimmer = Colors.white.withValues(alpha: 0.2);
    return AnimatedBuilder(
      animation: _shimmerAnimation,
      builder: (_, _) => Opacity(
        opacity: _shimmerAnimation.value,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                const SizedBox(width: 10),
                Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    color: shimmer,
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                const SizedBox(width: 12),
                Container(
                  width: 80,
                  height: 16,
                  decoration: BoxDecoration(
                    color: shimmer,
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ],
            ),
            Container(
              width: 100,
              height: 44,
              decoration: BoxDecoration(
                color: shimmer,
                borderRadius: BorderRadius.circular(100),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final hasMood = widget.todayMood != null;

    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Theme.of(context).scaffoldBackgroundColor.withValues(alpha: 0),
            Theme.of(context).scaffoldBackgroundColor,
          ],
          stops: const [0.0, 0.65],
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 40, 20, 30),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(100),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 24, sigmaY: 24),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.black.withValues(alpha: 0.55),
                borderRadius: BorderRadius.circular(100),
              ),
              padding: const EdgeInsets.fromLTRB(14, 14, 14, 14),
              child: widget.isLoading
                  ? _buildSkeleton()
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        if (hasMood)
                          Row(
                            children: [
                              const SizedBox(width: 10),
                              GradeCard(
                                grade: widget.todayMood!.score,
                                size: 48,
                                borderRadius: 12,
                                fontSize: 22,
                              ),
                              const SizedBox(width: 12),
                              MoodooText(
                                'today',
                                variant: MoodooTextVariant.headlineSmall,
                                color: Colors.white,
                              ),
                            ],
                          )
                        else
                          SizedBox(
                            width: 180,
                            child: Padding(
                              padding: const EdgeInsets.only(left: 10),
                              child: MoodooText(
                                "you didn't add your mood for today",
                                variant: MoodooTextVariant.headlineSmall,
                              ),
                            ),
                          ),
                        MoodooButton(
                          text: hasMood ? 'edit mood' : 'add mood',
                          onTap: () => _showMoodSheet(context),
                          backgroundColor: Colors.white,
                          foregroundColor: Colors.black,
                          fullWidth: false,
                        ),
                      ],
                    ),
            ),
          ),
        ),
      ),
    );
  }
}
