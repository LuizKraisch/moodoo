import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:moodoo/widgets/add_mood_sheet.dart';
import 'package:moodoo/widgets/tap_bounce.dart';

class HomePageFooter extends StatelessWidget {
  const HomePageFooter({super.key});

  @override
  Widget build(BuildContext context) {
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
              padding: const EdgeInsets.fromLTRB(24, 14, 14, 14),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: 160,
                    child: Text(
                      "you didn't add your mood for today",
                      style: TextTheme.of(
                        context,
                      ).headlineSmall?.copyWith(color: Colors.white),
                    ),
                  ),
                  TapBounce(
                    onTap: () => showModalBottomSheet(
                      context: context,
                      isScrollControlled: true,
                      useSafeArea: true,
                      backgroundColor: Colors.transparent,
                      builder: (_) => TweenAnimationBuilder<double>(
                        tween: Tween(begin: 0.85, end: 1.0),
                        duration: const Duration(milliseconds: 600),
                        curve: Curves.elasticOut,
                        builder: (context, scale, child) => Transform.scale(
                          scale: scale,
                          alignment: Alignment.bottomCenter,
                          child: child,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: Material(
                            color: Theme.of(context).scaffoldBackgroundColor,
                            borderRadius: BorderRadius.circular(24),
                            child: const AddMoodSheet(),
                          ),
                        ),
                      ),
                    ),
                    child: FilledButton(
                      onPressed: () {},
                      style: FilledButton.styleFrom(
                        shape: StadiumBorder(),
                        backgroundColor: Colors.white,
                        foregroundColor: Colors.black,
                        textStyle: TextTheme.of(context).headlineSmall,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 24,
                          vertical: 14,
                        ),
                      ),
                      child: const Text('add mood'),
                    ),
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
