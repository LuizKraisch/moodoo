import 'package:flutter/material.dart';
import 'package:moodoo/pages/settings_page.dart';

class HomePageHeader extends StatelessWidget {
  const HomePageHeader({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'hi, kyle!',
              style: Theme.of(context).textTheme.displayLarge,
            ),
            Text(
              "here's your mood overview",
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ],
        ),
        GestureDetector(
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const SettingsPage()),
          ),
          child: CircleAvatar(
            radius: 28,
            backgroundImage: NetworkImage("https://caricom.org/wp-content/uploads/Floyd-Morris-Remake-1024x879-1.jpg"),
            onBackgroundImageError: (_, _) {},
            backgroundColor: Colors.transparent,
          ),
        ),
      ],
    );
  }
}
