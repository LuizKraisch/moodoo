import 'package:flutter/material.dart';

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
        CircleAvatar(
          radius: 30,
          backgroundImage: NetworkImage("https://caricom.org/wp-content/uploads/Floyd-Morris-Remake-1024x879-1.jpg"),
          backgroundColor: Colors.transparent,
        ),
      ],
    );
  }
}