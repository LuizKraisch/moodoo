import 'package:flutter/material.dart';
import 'package:moodoo/widgets/tap_bounce.dart';

class MoodooButton extends StatelessWidget {
  const MoodooButton({
    super.key,
    required this.text,
    this.onTap,
    this.backgroundColor,
    this.foregroundColor,
    this.disabledBackgroundColor,
    this.textStyle,
    this.leading,
    this.fullWidth = true,
    this.padding = const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
    this.bouncePeakScale = 1.22,
  });

  final String text;
  final VoidCallback? onTap;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final Color? disabledBackgroundColor;
  final TextStyle? textStyle;
  final Widget? leading;
  final bool fullWidth;
  final EdgeInsetsGeometry padding;
  final double bouncePeakScale;

  @override
  Widget build(BuildContext context) {
    return TapBounce(
      onTap: onTap,
      peakScale: bouncePeakScale,
      child: FilledButton(
        onPressed: onTap == null ? null : () {},
        style: FilledButton.styleFrom(
          shape: const StadiumBorder(),
          backgroundColor: backgroundColor,
          foregroundColor: foregroundColor,
          disabledBackgroundColor: disabledBackgroundColor,
          textStyle: textStyle ?? TextTheme.of(context).headlineSmall,
          minimumSize: fullWidth ? const Size(double.infinity, 0) : null,
          padding: padding,
        ),
        child: leading != null
            ? Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [leading!, const SizedBox(width: 10), Text(text)],
              )
            : Text(text),
      ),
    );
  }
}
