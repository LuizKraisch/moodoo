import 'package:flutter/material.dart';
import 'package:moodoo/widgets/moodoo_text.dart';

class GradeCard extends StatelessWidget {
  const GradeCard({
    super.key,
    this.grade,
    this.size = 40,
    this.borderRadius = 12,
    this.fontSize,
  }) : assert(
         grade == null ||
             grade == 'S' ||
             grade == 'A' ||
             grade == 'B' ||
             grade == 'C' ||
             grade == 'D' ||
             grade == 'F',
         'grade must be one of: S, A, B, C, D, F, or null',
       );

  final String? grade;
  final double size;
  final double borderRadius;
  final double? fontSize;

  static const _colors = {
    'S': Color(0xFF8258FF),
    'A': Color(0xFF00B050),
    'B': Color(0xFF92D050),
    'C': Color(0xFFE0E032),
    'D': Color(0xFFFFC000),
    'F': Color(0xFFC00000),
  };

  static const _nullColor = Color(0xFFB8B8B8);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: grade != null ? _colors[grade] : _nullColor,
        borderRadius: BorderRadius.circular(borderRadius),
      ),
      child: Center(
        child: MoodooText(
          grade ?? '?',
          variant: MoodooTextVariant.displaySmall,
          color: const Color(0xFFFFFFFF),
          fontSize: fontSize,
        ),
      ),
    );
  }
}
