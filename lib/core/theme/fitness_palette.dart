import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'fitness_fonts.dart';

@immutable
class FitnessPalette extends ThemeExtension<FitnessPalette> {
  const FitnessPalette({
    required this.background,
    required this.card,
    required this.cardElevated,
    required this.textPrimary,
    required this.textSecondary,
    required this.textTertiary,
    required this.navItemUnselected,
    required this.neonGreen,
    required this.cyanAccent,
    required this.hydrationBlue,
    required this.trendGreen,
    required this.featuredWorkoutAccentBar,
    required this.hydrationLogBanner,
    required this.dividerHandle,
    required this.calendarDaySelected,
    required this.calendarDaySelectedLabel,
    required this.moodBackdropTop,
    required this.moodGlowCore,
    required this.moodGlowMid,
    required this.trainingPurpleDivider,
    required this.trainingTealSection,
    required this.trainingWeekBarBg,
    required this.armsTagBg,
    required this.legsTagBg,
    required this.trainingDayLine,
    required this.monthSheetBarrier,
    required this.sixDotColor,
    required this.insightProgressTrack,
  });

  final Color background;
  final Color card;
  final Color cardElevated;
  final Color textPrimary;
  final Color textSecondary;
  final Color textTertiary;
  final Color navItemUnselected;
  final Color neonGreen;
  final Color cyanAccent;
  final Color hydrationBlue;
  final Color trendGreen;
  final Color featuredWorkoutAccentBar;
  final Color hydrationLogBanner;
  final Color dividerHandle;
  final Color calendarDaySelected;
  final Color calendarDaySelectedLabel;
  final Color moodBackdropTop;
  final Color moodGlowCore;
  final Color moodGlowMid;
  final Color trainingPurpleDivider;
  final Color trainingTealSection;
  final Color trainingWeekBarBg;
  final Color armsTagBg;
  final Color legsTagBg;
  final Color trainingDayLine;
  final Color monthSheetBarrier;
  final Color sixDotColor;

  final Color insightProgressTrack;

  Color calendarDaySelectedFill({double opacity = 0.22}) =>
      calendarDaySelected.withValues(alpha: opacity);

  static const Color armsIcon = Color(0xFF34D978);
  static const Color legsIcon = Color(0xFF4855DF);

  static const FitnessPalette dark = FitnessPalette(
    background: Color(0xFF000000),
    card: Color(0xFF18181C),
    cardElevated: Color(0xFF1E1E24),
    textPrimary: Color(0xFFFFFFFF),
    textSecondary: Color(0xFF8E8E93),
    textTertiary: Color(0xFF636366),
    navItemUnselected: Color(0xFF66667E),
    neonGreen: Color(0xFF34D978),
    cyanAccent: Color(0xFF32D8D8),
    hydrationBlue: Color(0xFF4DA3FF),
    trendGreen: Color(0xFF34C759),
    featuredWorkoutAccentBar: Color(0xFF32AAB7),
    hydrationLogBanner: Color(0xFF1B3D45),
    dividerHandle: Color(0xFF3A3A3C),
    calendarDaySelected: Color(0xFF20B76F),
    calendarDaySelectedLabel: Color(0xFF157A52),
    moodBackdropTop: Color(0xFF0C1118),
    moodGlowCore: Color.fromARGB(255, 49, 116, 135),
    moodGlowMid: Color(0xFF070A0F),
    trainingPurpleDivider: Color(0xFF5E5CE6),
    trainingTealSection: Color(0xFF30D5C8),
    trainingWeekBarBg: Color(0xFF2C2C2E),
    armsTagBg: Color(0xFF1C3D2E),
    legsTagBg: Color(0xFF1E2140),
    trainingDayLine: Color(0xFF2C2C2E),
    monthSheetBarrier: Color(0x8C000000),
    sixDotColor: Color(0xFF636366),
    insightProgressTrack: Color(0xFF3A3A3C),
  );

  static const FitnessPalette light = FitnessPalette(
    background: Color(0xFFF2F2F7),
    card: Color(0xFFFFFFFF),
    cardElevated: Color(0xFFE5E5EA),
    textPrimary: Color(0xFF000000),
    textSecondary: Color(0xFF636366),
    textTertiary: Color(0xFF8E8E93),
    navItemUnselected: Color(0xFF8E8E93),
    neonGreen: Color(0xFF34D978),
    cyanAccent: Color(0xFF32D8D8),
    hydrationBlue: Color(0xFF007AFF),
    trendGreen: Color(0xFF34C759),
    featuredWorkoutAccentBar: Color(0xFF32AAB7),
    hydrationLogBanner: Color(0xFFE3F4F6),
    dividerHandle: Color(0xFFC7C7CC),
    calendarDaySelected: Color(0xFF20B76F),
    calendarDaySelectedLabel: Color(0xFF0D5C38),
    moodBackdropTop: Color(0xFFF4F9F8),
    moodGlowCore: Color(0xFFC8E8E4),
    moodGlowMid: Color(0xFFF8F9FC),
    trainingPurpleDivider: Color(0xFF5E5CE6),
    trainingTealSection: Color(0xFF30D5C8),
    trainingWeekBarBg: Color(0xFFE5E5EA),
    armsTagBg: Color(0xFFE8F5EE),
    legsTagBg: Color(0xFFE8EAFF),
    trainingDayLine: Color(0xFFD1D1D6),
    monthSheetBarrier: Color(0x66000000),
    sixDotColor: Color(0xFF8E8E93),
    insightProgressTrack: Color(0xFFD1D1D6),
  );

  @override
  FitnessPalette copyWith({
    Color? background,
    Color? card,
    Color? cardElevated,
    Color? textPrimary,
    Color? textSecondary,
    Color? textTertiary,
    Color? navItemUnselected,
    Color? neonGreen,
    Color? cyanAccent,
    Color? hydrationBlue,
    Color? trendGreen,
    Color? featuredWorkoutAccentBar,
    Color? hydrationLogBanner,
    Color? dividerHandle,
    Color? calendarDaySelected,
    Color? calendarDaySelectedLabel,
    Color? moodBackdropTop,
    Color? moodGlowCore,
    Color? moodGlowMid,
    Color? trainingPurpleDivider,
    Color? trainingTealSection,
    Color? trainingWeekBarBg,
    Color? armsTagBg,
    Color? legsTagBg,
    Color? trainingDayLine,
    Color? monthSheetBarrier,
    Color? sixDotColor,
    Color? insightProgressTrack,
  }) {
    return FitnessPalette(
      background: background ?? this.background,
      card: card ?? this.card,
      cardElevated: cardElevated ?? this.cardElevated,
      textPrimary: textPrimary ?? this.textPrimary,
      textSecondary: textSecondary ?? this.textSecondary,
      textTertiary: textTertiary ?? this.textTertiary,
      navItemUnselected: navItemUnselected ?? this.navItemUnselected,
      neonGreen: neonGreen ?? this.neonGreen,
      cyanAccent: cyanAccent ?? this.cyanAccent,
      hydrationBlue: hydrationBlue ?? this.hydrationBlue,
      trendGreen: trendGreen ?? this.trendGreen,
      featuredWorkoutAccentBar:
          featuredWorkoutAccentBar ?? this.featuredWorkoutAccentBar,
      hydrationLogBanner: hydrationLogBanner ?? this.hydrationLogBanner,
      dividerHandle: dividerHandle ?? this.dividerHandle,
      calendarDaySelected: calendarDaySelected ?? this.calendarDaySelected,
      calendarDaySelectedLabel:
          calendarDaySelectedLabel ?? this.calendarDaySelectedLabel,
      moodBackdropTop: moodBackdropTop ?? this.moodBackdropTop,
      moodGlowCore: moodGlowCore ?? this.moodGlowCore,
      moodGlowMid: moodGlowMid ?? this.moodGlowMid,
      trainingPurpleDivider:
          trainingPurpleDivider ?? this.trainingPurpleDivider,
      trainingTealSection: trainingTealSection ?? this.trainingTealSection,
      trainingWeekBarBg: trainingWeekBarBg ?? this.trainingWeekBarBg,
      armsTagBg: armsTagBg ?? this.armsTagBg,
      legsTagBg: legsTagBg ?? this.legsTagBg,
      trainingDayLine: trainingDayLine ?? this.trainingDayLine,
      monthSheetBarrier: monthSheetBarrier ?? this.monthSheetBarrier,
      sixDotColor: sixDotColor ?? this.sixDotColor,
      insightProgressTrack: insightProgressTrack ?? this.insightProgressTrack,
    );
  }

  @override
  FitnessPalette lerp(ThemeExtension<FitnessPalette>? other, double t) {
    if (other is! FitnessPalette) return this;
    Color lc(Color a, Color b) => Color.lerp(a, b, t)!;
    return FitnessPalette(
      background: lc(background, other.background),
      card: lc(card, other.card),
      cardElevated: lc(cardElevated, other.cardElevated),
      textPrimary: lc(textPrimary, other.textPrimary),
      textSecondary: lc(textSecondary, other.textSecondary),
      textTertiary: lc(textTertiary, other.textTertiary),
      navItemUnselected: lc(navItemUnselected, other.navItemUnselected),
      neonGreen: lc(neonGreen, other.neonGreen),
      cyanAccent: lc(cyanAccent, other.cyanAccent),
      hydrationBlue: lc(hydrationBlue, other.hydrationBlue),
      trendGreen: lc(trendGreen, other.trendGreen),
      featuredWorkoutAccentBar:
          lc(featuredWorkoutAccentBar, other.featuredWorkoutAccentBar),
      hydrationLogBanner: lc(hydrationLogBanner, other.hydrationLogBanner),
      dividerHandle: lc(dividerHandle, other.dividerHandle),
      calendarDaySelected: lc(calendarDaySelected, other.calendarDaySelected),
      calendarDaySelectedLabel:
          lc(calendarDaySelectedLabel, other.calendarDaySelectedLabel),
      moodBackdropTop: lc(moodBackdropTop, other.moodBackdropTop),
      moodGlowCore: lc(moodGlowCore, other.moodGlowCore),
      moodGlowMid: lc(moodGlowMid, other.moodGlowMid),
      trainingPurpleDivider:
          lc(trainingPurpleDivider, other.trainingPurpleDivider),
      trainingTealSection: lc(trainingTealSection, other.trainingTealSection),
      trainingWeekBarBg: lc(trainingWeekBarBg, other.trainingWeekBarBg),
      armsTagBg: lc(armsTagBg, other.armsTagBg),
      legsTagBg: lc(legsTagBg, other.legsTagBg),
      trainingDayLine: lc(trainingDayLine, other.trainingDayLine),
      monthSheetBarrier: lc(monthSheetBarrier, other.monthSheetBarrier),
      sixDotColor: lc(sixDotColor, other.sixDotColor),
      insightProgressTrack: lc(insightProgressTrack, other.insightProgressTrack),
    );
  }

  TextStyle get homeTodayLine => TextStyle(
        fontFamily: FitnessFontFamilies.primary,
        color: textPrimary,
        fontSize: 16,
        fontWeight: FontWeight.w700,
        height: 19.2 / 16,
        letterSpacing: 0,
      );

  TextStyle get homeSectionTitle => TextStyle(
        fontFamily: FitnessFontFamilies.primary,
        color: textPrimary,
        fontSize: 22,
        fontWeight: FontWeight.w700,
        letterSpacing: -0.5,
      );

  TextStyle get featuredWorkoutMeta => TextStyle(
        fontFamily: FitnessFontFamilies.primary,
        color: textSecondary,
        fontSize: 12,
        fontWeight: FontWeight.w700,
        height: 14.4 / 12,
        letterSpacing: 0,
      );

  TextStyle get featuredWorkoutTitle => TextStyle(
        fontFamily: FitnessFontFamilies.primary,
        color: textPrimary,
        fontSize: 22,
        fontWeight: FontWeight.w700,
        height: 28.8 / 24,
        letterSpacing: -0.48,
      );

  TextStyle get insightMetricValue => TextStyle(
        fontFamily: FitnessFontFamilies.primary,
        color: textPrimary,
        fontSize: 30,
        fontWeight: FontWeight.w600,
        height: 1.0,
        letterSpacing: 0,
        fontFeatures: const [FontFeature.tabularFigures()],
      );

  TextStyle get insightUnitLabel => TextStyle(
        fontFamily: FitnessFontFamilies.primary,
        color: textPrimary,
        fontSize: 16,
        fontWeight: FontWeight.w600,
        height: 21.6 / 18,
        letterSpacing: 0,
      );

  TextStyle get insightFooterLabel => TextStyle(
        fontFamily: FitnessFontFamilies.primary,
        color: textPrimary,
        fontSize: 18,
        fontWeight: FontWeight.w700,
        height: 21.6 / 18,
        letterSpacing: 0,
      );

  TextStyle get insightSecondaryEmphasis => TextStyle(
        fontFamily: FitnessFontFamilies.primary,
        color: textSecondary,
        fontSize: 18,
        fontWeight: FontWeight.w700,
        height: 21.6 / 18,
        letterSpacing: 0,
      );
}

extension FitnessPaletteContext on BuildContext {
  FitnessPalette get palette =>
      Theme.of(this).extension<FitnessPalette>() ?? FitnessPalette.dark;

  SystemUiOverlayStyle get fitnessSystemUi {
    final p = palette;
    final dark = Theme.of(this).brightness == Brightness.dark;
    return SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: dark ? Brightness.light : Brightness.dark,
      statusBarBrightness: dark ? Brightness.dark : Brightness.light,
      systemNavigationBarColor: p.background,
      systemNavigationBarIconBrightness:
          dark ? Brightness.light : Brightness.dark,
    );
  }
}
