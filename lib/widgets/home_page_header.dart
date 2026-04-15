import 'dart:ui';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:moodoo/pages/settings_page.dart';
import 'package:moodoo/widgets/moodoo_text.dart';
import 'package:moodoo/widgets/tap_bounce.dart';

class HomePageHeader extends StatelessWidget {
  const HomePageHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final topPadding = MediaQuery.of(context).padding.top;
    final user = FirebaseAuth.instance.currentUser;
    final firstName = (user?.displayName ?? '').split(' ').first.toLowerCase();
    final photoUrl = user?.photoURL;

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
                      MoodooText(
                        'hi, $firstName!',
                        variant: MoodooTextVariant.displayLarge,
                        fontSize: 25,
                      ),
                      MoodooText(
                        "here's your mood overview",
                        variant: MoodooTextVariant.titleMedium,
                        fontSize: 18,
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
                      backgroundImage: photoUrl != null
                          ? NetworkImage(photoUrl)
                          : null,
                      onBackgroundImageError: photoUrl != null
                          ? (_, _) {}
                          : null,
                      backgroundColor: Theme.of(context).colorScheme.primary,
                      child: photoUrl == null
                          ? Text(
                              firstName.isNotEmpty
                                  ? firstName[0].toUpperCase()
                                  : '?',
                              style: const TextStyle(color: Colors.white),
                            )
                          : null,
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
