import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

const _lightBackground = Color(0xFFFFFFFF);
const _lightCard = Color(0xFF343434);
const _lightCardBackground = Color(0xFFDDDDDD);
const _lightDisabled = Color(0xFFC4C4C4);
const _lightSubtitle = Color(0xFF777777);

const _darkBackground = Color(0xFF1C1C1C);
const _darkCard = Color(0xFF272727);
const _darkDisabled = Color(0xFF131313);
const _darkSubtitle = Color(0xFFB8B8B8);

final lightTheme = ThemeData(
  brightness: Brightness.light,
  scaffoldBackgroundColor: _lightBackground,
  colorScheme: const ColorScheme.light(
    surface: _lightBackground,
    primary: _lightCard,
    onPrimary: _lightBackground,
    secondary: _lightDisabled,
    onSurface: _lightCard,
  ),
  cardColor: _lightCard,
  disabledColor: _lightDisabled,
  textTheme: _applyTextColors(primary: _lightCard, subtitle: _lightSubtitle),
);

final darkTheme = ThemeData(
  brightness: Brightness.dark,
  scaffoldBackgroundColor: _darkBackground,
  colorScheme: const ColorScheme.dark(
    surface: _darkBackground,
    primary: _darkCard,
    onPrimary: _lightBackground,
    secondary: _darkDisabled,
    onSurface: _darkCard,
  ),
  cardColor: _darkCard,
  disabledColor: _darkDisabled,
  textTheme: _applyTextColors(
    primary: _lightBackground,
    subtitle: _darkSubtitle,
  ),
);

extension AppColors on ColorScheme {
  Color get subtitle =>
      brightness == Brightness.dark ? _darkSubtitle : _lightSubtitle;
  Color get pillBackground =>
      brightness == Brightness.dark ? Colors.black : _lightDisabled;
  Color get cardBackground =>
      brightness == Brightness.dark ? primary : _lightCardBackground;
}

TextTheme _applyTextColors({required Color primary, required Color subtitle}) {
  final base = _buildTextTheme();
  return base
      .apply(
        bodyColor: primary,
        displayColor: primary,
        decorationColor: subtitle,
      )
      .copyWith(
        titleMedium: base.titleMedium!.copyWith(color: subtitle),
        titleSmall: base.titleSmall!.copyWith(color: subtitle),
        bodySmall: base.bodySmall!.copyWith(color: subtitle),
        displaySmall: base.displaySmall!.copyWith(color: _lightBackground),
        headlineSmall: base.headlineSmall!.copyWith(color: subtitle),
      );
}

TextTheme _buildTextTheme() => TextTheme(
  displayLarge: GoogleFonts.funnelDisplay(
    fontSize: 30,
    fontWeight: FontWeight.bold,
  ),
  displaySmall: GoogleFonts.funnelDisplay(
    fontSize: 20,
    fontWeight: FontWeight.bold,
  ),
  headlineMedium: GoogleFonts.funnelDisplay(
    fontSize: 20,
    fontWeight: FontWeight.bold,
  ),
  headlineSmall: GoogleFonts.funnelDisplay(
    fontSize: 17,
    fontWeight: FontWeight.bold,
  ),
  titleMedium: GoogleFonts.funnelDisplay(
    fontSize: 20,
    fontWeight: FontWeight.bold,
  ),
  titleSmall: GoogleFonts.funnelDisplay(
    fontSize: 15,
    fontWeight: FontWeight.bold,
  ),
  bodySmall: GoogleFonts.funnelDisplay(
    fontSize: 10,
    fontWeight: FontWeight.bold,
  ),
);
