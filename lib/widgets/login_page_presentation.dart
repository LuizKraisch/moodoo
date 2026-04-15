import 'package:flutter/material.dart';

class LoginPagePresentation extends StatelessWidget {
  const LoginPagePresentation({super.key});

  static const List<Color> _moodColors = [
    Color(0xFF8258FF),
    Color(0xFF8258FF),
    Color(0xFFFFC000),
    Color(0xFF00B050),
    Color(0xFF8258FF),
    Color(0xFFFFC000),
    Color(0xFF92D050),
    Color(0xFF8258FF),
    Color(0xFF1C1C1C),
    Color(0xFF1C1C1C),
    Color(0xFFCC2200),
    Color(0xFF92D050),
    Color(0xFFFFC000),
    Color(0xFF1C1C1C),
    Color(0xFF1C1C1C),
    Color(0xFF1C1C1C),
    Color(0xFF92D050),
    Color(0xFFCC2200),
    Color(0xFF8258FF),
    Color(0xFF00B050),
  ];

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: LayoutBuilder(
        builder: (context, constraints) => ClipRect(
          child: Transform.translate(
            offset: const Offset(-60, 220),
            child: OverflowBox(
              maxWidth: double.infinity,
              maxHeight: double.infinity,
              child: Transform.rotate(
                angle: -0.30,
                child: Container(
                  width: constraints.maxWidth + 200,
                  height: constraints.maxHeight,
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.surface,
                    borderRadius: BorderRadius.circular(120),
                  ),
                  padding: const EdgeInsets.all(40),
                  child: GridView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    padding: const EdgeInsets.all(6),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 4,
                          crossAxisSpacing: 10,
                          mainAxisSpacing: 10,
                          childAspectRatio: 1,
                        ),
                    itemCount: _moodColors.length,
                    itemBuilder: (context, index) => Container(
                      margin: EdgeInsets.all(3),
                      decoration: BoxDecoration(
                        color: _moodColors[index],
                        borderRadius: BorderRadius.circular(40),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
