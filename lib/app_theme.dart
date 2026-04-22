import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

const _lightBackground = Color(0xFFFFFFFF);
const _lightCard = Color(0xFF343434);
const _lightDisabled = Color(0xFFC4C4C4);
const _lightSubtitle = Color(0xFFB8B8B8);

const _darkBackground = Color(0xFF1C1C1C);
const _darkCard = Color(0xFF272727);
const _darkDisabled = Color(0xFF131313);
const _darkSubtitle = Color(0xFFB8B8B8);

// COLORS

final lightTheme = ThemeData(
  brightness: Brightness.light,
  scaffoldBackgroundColor: _lightBackground,
  colorScheme: const ColorScheme.light(
    brightness: Brightness.light,
    surface: _lightBackground,
    primary: _lightCard,
    onPrimary: _lightBackground,
    secondary: _lightDisabled,
    onSurface: _lightCard,
  ),
  cardColor: _lightCard,
  disabledColor: _lightDisabled,
  textTheme: _applyColors(
    _buildTextTheme(),
    primary: _lightCard,
    subtitle: _lightSubtitle,
    displaySmall: _lightBackground,
    tertiary: _lightSubtitle,
  ),
);

final darkTheme = ThemeData(
  brightness: Brightness.dark,
  scaffoldBackgroundColor: _darkBackground,
  colorScheme: const ColorScheme.dark(
    brightness: Brightness.dark,
    surface: _darkBackground,
    primary: _darkCard,
    onPrimary: _lightBackground,
    secondary: _darkDisabled,
    onSurface: _darkCard,
  ),
  cardColor: _darkCard,
  disabledColor: _darkDisabled,
  textTheme: _applyColors(
    _buildTextTheme(),
    primary: _lightBackground,
    subtitle: _darkSubtitle,
    displaySmall: _lightBackground,
    tertiary: _darkSubtitle,
  ),
);

extension AppColors on ColorScheme {
  Color get subtitle =>
      brightness == Brightness.dark ? _darkSubtitle : _lightSubtitle;
}

// TEXT THEMES

TextTheme _buildTextTheme() => TextTheme(
  displayLarge: GoogleFonts.funnelDisplay(
    fontSize: 30,
    fontWeight: FontWeight.bold,
  ),
  displayMedium: GoogleFonts.funnelDisplay(),
  displaySmall: GoogleFonts.funnelDisplay(
    fontSize: 20,
    fontWeight: FontWeight.bold,
  ),
  headlineLarge: GoogleFonts.funnelDisplay(),
  headlineMedium: GoogleFonts.funnelDisplay(
    fontSize: 20,
    fontWeight: FontWeight.bold,
  ),
  headlineSmall: GoogleFonts.funnelDisplay(
    fontSize: 17,
    fontWeight: FontWeight.bold,
  ),
  titleLarge: GoogleFonts.funnelDisplay(),
  titleMedium: GoogleFonts.funnelDisplay(
    fontSize: 20,
    fontWeight: FontWeight.bold,
  ),
  titleSmall: GoogleFonts.funnelDisplay(
    fontSize: 15,
    fontWeight: FontWeight.bold,
  ),
  bodyLarge: GoogleFonts.funnelDisplay(
    fontSize: 20,
    fontWeight: FontWeight.bold,
  ),
  bodyMedium: GoogleFonts.funnelDisplay(),
  bodySmall: GoogleFonts.funnelDisplay(
    fontSize: 10,
    fontWeight: FontWeight.bold,
  ),
  labelLarge: GoogleFonts.funnelDisplay(),
  labelMedium: GoogleFonts.funnelDisplay(
    fontSize: 15,
    fontWeight: FontWeight.bold,
  ),
  labelSmall: GoogleFonts.funnelDisplay(),
);

TextTheme _applyColors(
  TextTheme base, {
  required Color primary,
  required Color subtitle,
  required Color displaySmall,
  required Color tertiary,
}) => base
    .apply(bodyColor: primary, displayColor: primary, decorationColor: subtitle)
    .copyWith(
      titleMedium: base.titleMedium!.copyWith(color: subtitle),
      titleSmall: base.titleSmall!.copyWith(color: subtitle),
      bodySmall: base.bodySmall!.copyWith(color: subtitle),
      displaySmall: base.displaySmall!.copyWith(color: displaySmall),
      headlineSmall: base.headlineSmall!.copyWith(color: tertiary),
    );
