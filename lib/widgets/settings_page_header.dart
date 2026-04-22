import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:moodoo/widgets/moodoo_text.dart';
import 'package:moodoo/widgets/tap_bounce.dart';

class SettingsPageHeader extends StatelessWidget {
  const SettingsPageHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final topPadding = MediaQuery.of(context).padding.top;

    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Theme.of(context).scaffoldBackgroundColor,
            Theme.of(context).scaffoldBackgroundColor.withValues(alpha: 0),
          ],
          stops: const [0.65, 1.0],
        ),
      ),
      child: Padding(
        padding: EdgeInsets.fromLTRB(20, topPadding + 8, 20, 0),
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
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TapBounce(
                    onTap: () => Navigator.of(context).pop(),
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                      child: Icon(
                        Icons.arrow_back_ios_new_rounded,
                        size: 28,
                        color: Theme.of(context).textTheme.titleMedium?.color,
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  MoodooText(
                    'settings',
                    variant: MoodooTextVariant.displayLarge,
                    fontSize: 22,
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
