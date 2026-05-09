import 'package:flutter/material.dart';

import 'package:evencir_mood_app/core/theme/app_assets.dart';
import 'package:evencir_mood_app/core/theme/fitness_theme.dart';

class SixDotDragHandle extends StatelessWidget {
  const SixDotDragHandle({super.key});

  @override
  Widget build(BuildContext context) {
    final dotColor = context.palette.sixDotColor;
    const dot = 3.0;
    const gap = 2.5;
    return SizedBox(
      width: dot * 2 + gap,
      height: dot * 3 + gap * 2,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: List.generate(3, (r) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: List.generate(2, (c) {
              return Container(
                width: dot,
                height: dot,
                decoration: BoxDecoration(
                  color: dotColor,
                  shape: BoxShape.circle,
                ),
              );
            }),
          );
        }),
      ),
    );
  }
}

enum WorkoutPlanCategory { arms, legs }

abstract final class TrainingCalendarLayout {
  static const double workoutLaneHeight = 50;

  static const double weekBarTitleFontSize = 17;

  static const double weekBarMetaFontSize = 12;

  static const double workoutCardBorderRadius = 4;
}

abstract final class _TrainingDayStripTokens {
  static const double verticalPadding = 14;

  static const double verticalPaddingWithWorkout = 6;
}

class TrainingPurpleHeaderDivider extends StatelessWidget {
  const TrainingPurpleHeaderDivider({super.key, this.height = 2});

  final double height;

  @override
  Widget build(BuildContext context) {
    final c = context.palette.trainingPurpleDivider;
    return Container(
      height: height,
      width: double.infinity,
      decoration: BoxDecoration(
        color: c,
        boxShadow: [
          BoxShadow(
            color: c.withValues(alpha: 0.4),
            blurRadius: 6,
            offset: const Offset(0, 1),
          ),
        ],
      ),
    );
  }
}

class TrainingWeekHeader extends StatelessWidget {
  const TrainingWeekHeader({
    super.key,
    required this.weekLabel,
    required this.dateRange,
    required this.totalMinutes,
  });

  final String weekLabel;
  final String dateRange;
  final int totalMinutes;

  @override
  Widget build(BuildContext context) {
    final p = context.palette;
    final secondaryRow = TextStyle(
      color: p.textPrimary.withValues(alpha: 0.72),
      fontSize: TrainingCalendarLayout.weekBarMetaFontSize,
      fontWeight: FontWeight.w400,
      letterSpacing: 0.12,
      height: 1.2,
    );
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      decoration: BoxDecoration(color: p.trainingWeekBarBg),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            weekLabel,
            style: TextStyle(
              color: p.textPrimary,
              fontSize: TrainingCalendarLayout.weekBarTitleFontSize,
              fontWeight: FontWeight.w600,
              letterSpacing: -0.45,
              height: 1.22,
            ),
          ),
          const SizedBox(height: 6),
          Row(
            crossAxisAlignment: CrossAxisAlignment.baseline,
            textBaseline: TextBaseline.alphabetic,
            children: [
              Expanded(child: Text(dateRange, style: secondaryRow)),
              Text('Total: ${totalMinutes}min', style: secondaryRow),
            ],
          ),
        ],
      ),
    );
  }
}

class TrainingDayRow extends StatelessWidget {
  const TrainingDayRow({
    super.key,
    required this.dayShort,
    required this.dayNumber,
    this.workout,
    this.showDividerBelow = true,
    this.isSelected = false,
    this.onTap,
  });

  final String dayShort;
  final int dayNumber;
  final TrainingWorkoutSlot? workout;
  final bool showDividerBelow;
  final bool isSelected;
  final VoidCallback? onTap;

  bool get _emphasizeDayLabels => isSelected || workout != null;

  TextStyle _weekdayStyle(FitnessPalette p) {
    final baseSecondary = TextStyle(
      color: p.textPrimary.withValues(alpha: 0.72),
      fontSize: 14,
      fontWeight: FontWeight.w400,
      letterSpacing: 0.12,
      height: 1.2,
    );
    if (_emphasizeDayLabels) {
      return TextStyle(
        color: p.textPrimary,
        fontSize: 14,
        fontWeight: FontWeight.w700,
        letterSpacing: 0.12,
        height: 1.2,
      );
    }
    return baseSecondary;
  }

  TextStyle _dateStyle(FitnessPalette p) {
    const fs = 21.0;
    if (_emphasizeDayLabels) {
      return TextStyle(
        color: p.textPrimary,
        fontSize: fs,
        fontWeight: FontWeight.w700,
        letterSpacing: -0.45,
        height: 1.22,
      );
    }
    return TextStyle(
      color: p.textSecondary,
      fontSize: fs,
      fontWeight: FontWeight.w400,
      letterSpacing: -0.45,
      height: 1.22,
    );
  }

  @override
  Widget build(BuildContext context) {
    final p = context.palette;

    final content = Padding(
      padding: EdgeInsets.symmetric(
        vertical: workout != null
            ? _TrainingDayStripTokens.verticalPaddingWithWorkout
            : _TrainingDayStripTokens.verticalPadding,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 44,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(dayShort, style: _weekdayStyle(p)),
                const SizedBox(height: 2),
                Text('$dayNumber', style: _dateStyle(p)),
              ],
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: SizedBox(
              height: TrainingCalendarLayout.workoutLaneHeight,
              width: double.infinity,
              child: workout != null
                  ? TrainingWorkoutCard(workout: workout!)
                  : const SizedBox.shrink(),
            ),
          ),
        ],
      ),
    );

    final paddedColumn = Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        onTap != null
            ? GestureDetector(
                behavior: HitTestBehavior.translucent,
                onTap: onTap,
                child: content,
              )
            : content,
        if (showDividerBelow) Container(height: 0.5, color: p.trainingDayLine),
      ],
    );

    return paddedColumn;
  }
}

class TrainingWorkoutSlot {
  const TrainingWorkoutSlot({
    required this.category,
    required this.tagLabel,
    required this.title,
    required this.durationLabel,
  });

  final WorkoutPlanCategory category;
  final String tagLabel;
  final String title;
  final String durationLabel;
}

class _WorkoutCategoryGlyph extends StatelessWidget {
  const _WorkoutCategoryGlyph({required this.category, required this.color});

  final WorkoutPlanCategory category;
  final Color color;

  @override
  Widget build(BuildContext context) {
    if (category == WorkoutPlanCategory.arms) {
      return SizedBox(
        width: 13,
        height: 13,
        child: ColorFiltered(
          colorFilter: ColorFilter.mode(color, BlendMode.srcIn),
          child: Image.asset(
            AppAssets.iconPlanArmWorkout,
            width: 13,
            height: 13,
            fit: BoxFit.contain,
          ),
        ),
      );
    }
    return Icon(Icons.directions_run_rounded, size: 13, color: color);
  }
}

class TrainingWorkoutCard extends StatelessWidget {
  const TrainingWorkoutCard({super.key, required this.workout});

  final TrainingWorkoutSlot workout;

  @override
  Widget build(BuildContext context) {
    final p = context.palette;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final isArms = workout.category == WorkoutPlanCategory.arms;
    final tagBg = isArms ? p.armsTagBg : p.legsTagBg;
    final iconColor = isArms
        ? FitnessPalette.armsIcon
        : FitnessPalette.legsIcon;

    final rr = TrainingCalendarLayout.workoutCardBorderRadius;

    return Material(
      color: Colors.transparent,
      borderRadius: BorderRadius.circular(rr),
      clipBehavior: Clip.antiAlias,
      child: SizedBox.expand(
        child: InkWell(
          onTap: () {},
          borderRadius: BorderRadius.circular(rr),
          splashColor: p.textPrimary.withValues(alpha: 0.08),
          child: Container(
            decoration: BoxDecoration(
              color: p.card,
              borderRadius: BorderRadius.circular(rr),
              boxShadow: isDark
                  ? [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.4),
                        blurRadius: 10,
                        offset: const Offset(0, 5),
                        spreadRadius: 0,
                      ),
                    ]
                  : null,
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  width: 4,
                  decoration: BoxDecoration(
                    color: p.textPrimary,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(rr),
                      bottomLeft: Radius.circular(rr),
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(8, 2, 10, 2),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(right: 6),
                          child: SixDotDragHandle(),
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 6,
                                  vertical: 1,
                                ),
                                decoration: BoxDecoration(
                                  color: tagBg,
                                  borderRadius: BorderRadius.circular(2),
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    _WorkoutCategoryGlyph(
                                      category: workout.category,
                                      color: iconColor,
                                    ),
                                    const SizedBox(width: 4),
                                    Text(
                                      workout.tagLabel,
                                      style: TextStyle(
                                        color: iconColor,
                                        fontSize: 10,
                                        fontWeight: FontWeight.w600,
                                        letterSpacing: 0.04,
                                        height: 1,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 2),
                              Text(
                                workout.title,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  color: p.textPrimary,
                                  fontSize: 13,
                                  fontWeight: FontWeight.w600,
                                  letterSpacing: -0.35,
                                  height: 1,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 6),
                          child: Text(
                            workout.durationLabel,
                            textAlign: TextAlign.right,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              color: p.textPrimary.withValues(alpha: 0.72),
                              fontSize: 11,
                              fontWeight: FontWeight.w400,
                              letterSpacing: 0.06,
                              height: 1,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class TrainingTealSectionDivider extends StatelessWidget {
  const TrainingTealSectionDivider({super.key});

  @override
  Widget build(BuildContext context) {
    final teal = context.palette.trainingTealSection;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Container(
        height: 2,
        width: double.infinity,
        decoration: BoxDecoration(
          color: teal,
          borderRadius: BorderRadius.circular(2),
          boxShadow: [
            BoxShadow(
              color: teal.withValues(alpha: 0.35),
              blurRadius: 8,
              offset: const Offset(0, 1),
            ),
          ],
        ),
      ),
    );
  }
}
