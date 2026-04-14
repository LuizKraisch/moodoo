import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:moodoo/pages/settings_page.dart';
import 'package:moodoo/widgets/tap_bounce.dart';

class HomePageHeader extends StatelessWidget {
  const HomePageHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final topPadding = MediaQuery.of(context).padding.top;

    return ClipRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 24, sigmaY: 24),
        child: Container(
          color: Theme.of(
            context,
          ).scaffoldBackgroundColor.withValues(alpha: 0.75),
          child: Padding(
            padding: EdgeInsets.fromLTRB(20, topPadding, 20, 10),
            child: Container(
              padding: const EdgeInsets.fromLTRB(6, 12, 6, 6),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'hi, kyle!',
                        style: Theme.of(
                          context,
                        ).textTheme.displayLarge?.copyWith(fontSize: 25),
                      ),
                      Text(
                        "here's your mood overview",
                        style: Theme.of(
                          context,
                        ).textTheme.titleMedium?.copyWith(fontSize: 18),
                      ),
                    ],
                  ),
                  TapBounce(
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const SettingsPage()),
                    ),
                    child: CircleAvatar(
                      radius: 28,
                      backgroundImage: NetworkImage(
                        "https://caricom.org/wp-content/uploads/Floyd-Morris-Remake-1024x879-1.jpg",
                      ),
                      onBackgroundImageError: (_, _) {},
                      backgroundColor: Colors.transparent,
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
