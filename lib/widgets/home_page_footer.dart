import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:moodoo/widgets/add_mood_sheet.dart';
import 'package:moodoo/widgets/moodoo_button.dart';
import 'package:moodoo/widgets/moodoo_modal.dart';
import 'package:moodoo/widgets/moodoo_text.dart';

class HomePageFooter extends StatelessWidget {
  const HomePageFooter({super.key});

  void _showAddMoodSheet(BuildContext context) {
    showMoodooModal(context, title: 'how are you feeling today?', child: const AddMoodSheet());
  }

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
                    child: MoodooText(
                      "you didn't add your mood for today",
                      variant: MoodooTextVariant.headlineSmall,
                      color: Colors.white,
                    ),
                  ),
                  MoodooButton(
                    text: 'add mood',
                    onTap: () => _showAddMoodSheet(context),
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
