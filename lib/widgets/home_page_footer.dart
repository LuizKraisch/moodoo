import 'package:flutter/material.dart';

class HomePageFooter extends StatelessWidget {
  const HomePageFooter({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(color: Theme.of(context).colorScheme.primary, width: 1),
        ),
      ),
      padding: const EdgeInsets.fromLTRB(30, 16, 30, 40),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            width: 200,
            child: Text(
              "you didn't add your mood for today",
              style: TextTheme.of(context).headlineSmall,
            ),
          ),
          FilledButton(
            onPressed: () {},
            style: FilledButton.styleFrom(
              shape: StadiumBorder(),
              textStyle: TextTheme.of(context).headlineSmall,
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
            ),
            child: Text('add mood'),
          ),
        ],
      ),
    );
  }
}