import 'package:flutter/material.dart';

enum MoodooTextVariant {
  displayLarge,
  displaySmall,
  headlineMedium,
  headlineSmall,
  titleMedium,
  titleSmall,
  bodySmall,
}

class MoodooText extends StatelessWidget {
  const MoodooText(
    this.text, {
    super.key,
    required this.variant,
    this.fontSize,
    this.color,
    this.textAlign,
  });

  final String text;
  final MoodooTextVariant variant;
  final double? fontSize;
  final Color? color;
  final TextAlign? textAlign;

  TextStyle? _baseStyle(TextTheme tt) => switch (variant) {
    MoodooTextVariant.displayLarge => tt.displayLarge,
    MoodooTextVariant.displaySmall => tt.displaySmall,
    MoodooTextVariant.headlineMedium => tt.headlineMedium,
    MoodooTextVariant.headlineSmall => tt.headlineSmall,
    MoodooTextVariant.titleMedium => tt.titleMedium,
    MoodooTextVariant.titleSmall => tt.titleSmall,
    MoodooTextVariant.bodySmall => tt.bodySmall,
  };

  @override
  Widget build(BuildContext context) {
    final base = _baseStyle(Theme.of(context).textTheme);
    final style = (fontSize != null || color != null)
        ? base?.copyWith(fontSize: fontSize, color: color)
        : base;
    return Text(text, style: style, textAlign: textAlign);
  }
}
