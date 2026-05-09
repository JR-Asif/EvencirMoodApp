import 'package:flutter/material.dart';

import 'fitness_fonts.dart';
import 'fitness_palette.dart';

export 'fitness_fonts.dart';
export 'fitness_palette.dart';

abstract final class FitnessRadii {
  static const double card = 12;
  static const double sheet = 8;
  static const double pill = 100;
}

TextTheme fitnessTextTheme(TextTheme base) {
  return base.copyWith(
    displayLarge: base.displayLarge?.copyWith(
      fontWeight: FontWeight.w700,
      letterSpacing: -0.5,
    ),
    headlineMedium: base.headlineMedium?.copyWith(
      fontWeight: FontWeight.w700,
      letterSpacing: -0.3,
    ),
    titleLarge: base.titleLarge?.copyWith(
      fontWeight: FontWeight.w600,
      letterSpacing: -0.2,
    ),
    bodyLarge: base.bodyLarge?.copyWith(
      fontWeight: FontWeight.w500,
      letterSpacing: 0.1,
    ),
    bodyMedium: base.bodyMedium?.copyWith(
      fontWeight: FontWeight.w400,
      letterSpacing: 0.15,
    ),
    labelLarge: base.labelLarge?.copyWith(
      fontWeight: FontWeight.w600,
      letterSpacing: 0.2,
    ),
  );
}

ThemeData buildFitnessDarkTheme() {
  const p = FitnessPalette.dark;
  final colorScheme = ColorScheme.dark(
    surface: p.background,
    primary: p.neonGreen,
    secondary: p.cyanAccent,
    onSurface: p.textPrimary,
    onPrimary: p.background,
  );

  final textTheme = fitnessTextTheme(const TextTheme()).apply(
    fontFamily: FitnessFontFamilies.primary,
    bodyColor: p.textPrimary,
    displayColor: p.textPrimary,
  );

  return ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    fontFamily: FitnessFontFamilies.primary,
    scaffoldBackgroundColor: p.background,
    colorScheme: colorScheme,
    splashFactory: InkRipple.splashFactory,
    textTheme: textTheme,
    primaryTextTheme: textTheme,
    iconTheme: IconThemeData(color: p.textSecondary, size: 24),
    primaryIconTheme: IconThemeData(color: p.textPrimary, size: 24),
    extensions: const [FitnessPalette.dark],
  );
}

ThemeData buildFitnessLightTheme() {
  const p = FitnessPalette.light;
  final colorScheme = ColorScheme.light(
    surface: p.background,
    primary: p.neonGreen,
    secondary: p.cyanAccent,
    onSurface: p.textPrimary,
    onPrimary: Colors.white,
  );

  final textTheme = fitnessTextTheme(const TextTheme()).apply(
    fontFamily: FitnessFontFamilies.primary,
    bodyColor: p.textPrimary,
    displayColor: p.textPrimary,
  );

  return ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    fontFamily: FitnessFontFamilies.primary,
    scaffoldBackgroundColor: p.background,
    colorScheme: colorScheme,
    splashFactory: InkRipple.splashFactory,
    textTheme: textTheme,
    primaryTextTheme: textTheme,
    iconTheme: IconThemeData(color: p.textSecondary, size: 24),
    primaryIconTheme: IconThemeData(color: p.textPrimary, size: 24),
    extensions: const [FitnessPalette.light],
  );
}
