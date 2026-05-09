import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:evencir_mood_app/core/theme/fitness_theme.dart';
import 'package:evencir_mood_app/features/plan/presentation/training_calendar_widgets.dart';

class PlanScreen extends StatefulWidget {
  const PlanScreen({super.key});

  @override
  State<PlanScreen> createState() => _PlanScreenState();
}

class _PlanScreenState extends State<PlanScreen> {
  static const double _hPad = 20.0;

  static const double _bottomPad = 24;

  static const int _heroWeekIndex = 1;

  var _selectedWeekIndex = _heroWeekIndex;
  var _selectedDayIndex = 0;

  static List<_PlanWeek> get _weeks => const [
    _PlanWeek(
      weekLabel: 'Week 1/8',
      dateRange: 'December 1-7',
      totalMinutes: 40,
      days: [
        (d: 'Mon', n: 1, w: null),
        (
          d: 'Tue',
          n: 2,
          w: TrainingWorkoutSlot(
            category: WorkoutPlanCategory.arms,
            tagLabel: 'Arms Workout',
            title: 'Push strength',
            durationLabel: '20m - 25m',
          ),
        ),
        (d: 'Wed', n: 3, w: null),
        (d: 'Thu', n: 4, w: null),
        (d: 'Fri', n: 5, w: null),
        (d: 'Sat', n: 6, w: null),
        (d: 'Sun', n: 7, w: null),
      ],
    ),
    _PlanWeek(
      weekLabel: 'Week 2/8',
      dateRange: 'December 8-14',
      totalMinutes: 60,
      days: [
        (
          d: 'Mon',
          n: 8,
          w: TrainingWorkoutSlot(
            category: WorkoutPlanCategory.arms,
            tagLabel: 'Arms Workout',
            title: 'Arm Blaster',
            durationLabel: '25m - 30m',
          ),
        ),
        (d: 'Tue', n: 9, w: null),
        (d: 'Wed', n: 10, w: null),
        (
          d: 'Thu',
          n: 11,
          w: TrainingWorkoutSlot(
            category: WorkoutPlanCategory.legs,
            tagLabel: 'Leg Workout',
            title: 'Leg Day Blitz',
            durationLabel: '25m - 30m',
          ),
        ),
        (d: 'Fri', n: 12, w: null),
        (d: 'Sat', n: 13, w: null),
        (d: 'Sun', n: 14, w: null),
      ],
    ),
    _PlanWeek(
      weekLabel: 'Week 3/8',
      dateRange: 'December 15-21',
      totalMinutes: 45,
      days: [
        (d: 'Mon', n: 15, w: null),
        (
          d: 'Tue',
          n: 16,
          w: TrainingWorkoutSlot(
            category: WorkoutPlanCategory.legs,
            tagLabel: 'Leg Workout',
            title: 'Power squats',
            durationLabel: '30m - 40m',
          ),
        ),
        (d: 'Wed', n: 17, w: null),
        (d: 'Thu', n: 18, w: null),
        (d: 'Fri', n: 19, w: null),
        (d: 'Sat', n: 20, w: null),
        (d: 'Sun', n: 21, w: null),
      ],
    ),
    _PlanWeek(
      weekLabel: 'Week 4/8',
      dateRange: 'December 22-28',
      totalMinutes: 50,
      days: [
        (d: 'Mon', n: 22, w: null),
        (d: 'Tue', n: 23, w: null),
        (d: 'Wed', n: 24, w: null),
        (d: 'Thu', n: 25, w: null),
        (d: 'Fri', n: 26, w: null),
        (d: 'Sat', n: 27, w: null),
        (d: 'Sun', n: 28, w: null),
      ],
    ),
    _PlanWeek(
      weekLabel: 'Week 5/8',
      dateRange: 'December 29 - January 4',
      totalMinutes: 55,
      days: [
        (d: 'Mon', n: 29, w: null),
        (d: 'Tue', n: 30, w: null),
        (d: 'Wed', n: 31, w: null),
        (d: 'Thu', n: 1, w: null),
        (d: 'Fri', n: 2, w: null),
        (d: 'Sat', n: 3, w: null),
        (d: 'Sun', n: 4, w: null),
      ],
    ),
    _PlanWeek(
      weekLabel: 'Week 6/8',
      dateRange: 'January 5-11',
      totalMinutes: 48,
      days: [
        (d: 'Mon', n: 5, w: null),
        (d: 'Tue', n: 6, w: null),
        (d: 'Wed', n: 7, w: null),
        (d: 'Thu', n: 8, w: null),
        (d: 'Fri', n: 9, w: null),
        (d: 'Sat', n: 10, w: null),
        (d: 'Sun', n: 11, w: null),
      ],
    ),
    _PlanWeek(
      weekLabel: 'Week 7/8',
      dateRange: 'January 12-18',
      totalMinutes: 52,
      days: [
        (d: 'Mon', n: 12, w: null),
        (d: 'Tue', n: 13, w: null),
        (d: 'Wed', n: 14, w: null),
        (d: 'Thu', n: 15, w: null),
        (d: 'Fri', n: 16, w: null),
        (d: 'Sat', n: 17, w: null),
        (d: 'Sun', n: 18, w: null),
      ],
    ),
    _PlanWeek(
      weekLabel: 'Week 8/8',
      dateRange: 'January 19-25',
      totalMinutes: 35,
      days: [
        (d: 'Mon', n: 19, w: null),
        (d: 'Tue', n: 20, w: null),
        (d: 'Wed', n: 21, w: null),
        (d: 'Thu', n: 22, w: null),
        (d: 'Fri', n: 23, w: null),
        (d: 'Sat', n: 24, w: null),
        (d: 'Sun', n: 25, w: null),
      ],
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final hero = _weeks[_heroWeekIndex];

    final p = context.palette;

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: context.fitnessSystemUi,
      child: Scaffold(
        backgroundColor: p.background,
        body: SafeArea(
          top: true,
          bottom: false,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: _hPad),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            'Training Calendar',
                            style: TextStyle(
                              color: p.textPrimary,
                              fontSize: 20,
                              fontWeight: FontWeight.w400,
                              letterSpacing: 0,
                              height: 1.02,
                            ),
                          ),
                        ],
                      ),
                    ),
                    TextButton(
                      onPressed: () {},
                      style: TextButton.styleFrom(
                        foregroundColor: p.textPrimary,
                        padding: EdgeInsets.zero,
                        minimumSize: const Size(44, 36),
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      ),
                      child: Text(
                        'Save',
                        style: TextStyle(
                          color: p.textPrimary.withValues(alpha: 0.72),
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          letterSpacing: 0.12,
                          height: 1.2,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              const TrainingPurpleHeaderDivider(),
              const SizedBox(height: 8),
              Expanded(
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(
                    parent: AlwaysScrollableScrollPhysics(),
                  ),
                  padding: const EdgeInsets.only(bottom: _bottomPad),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      TrainingWeekHeader(
                        weekLabel: hero.weekLabel,
                        dateRange: hero.dateRange,
                        totalMinutes: hero.totalMinutes,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: _hPad),
                        child: Column(
                          children: [
                            for (var i = 0; i < 7; i++)
                              TrainingDayRow(
                                dayShort: hero.days[i].d,
                                dayNumber: hero.days[i].n,
                                workout: hero.days[i].w,
                                showDividerBelow: i < 6,
                                isSelected:
                                    _selectedWeekIndex == _heroWeekIndex &&
                                    _selectedDayIndex == i,
                                onTap: () {
                                  setState(() {
                                    _selectedWeekIndex = _heroWeekIndex;
                                    _selectedDayIndex = i;
                                  });
                                },
                              ),
                          ],
                        ),
                      ),
                      const TrainingTealSectionDivider(),
                      TrainingWeekHeader(
                        weekLabel: _weeks[_heroWeekIndex + 1].weekLabel,
                        dateRange: _weeks[_heroWeekIndex + 1].dateRange,
                        totalMinutes: _weeks[_heroWeekIndex + 1].totalMinutes,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: _hPad),
                        child: Column(
                          children: [
                            for (var i = 0; i < _weeks[2].days.length; i++)
                              TrainingDayRow(
                                dayShort: _weeks[2].days[i].d,
                                dayNumber: _weeks[2].days[i].n,
                                workout: _weeks[2].days[i].w,
                                showDividerBelow: i < _weeks[2].days.length - 1,
                                isSelected:
                                    _selectedWeekIndex == 2 &&
                                    _selectedDayIndex == i,
                                onTap: () {
                                  setState(() {
                                    _selectedWeekIndex = 2;
                                    _selectedDayIndex = i;
                                  });
                                },
                              ),
                          ],
                        ),
                      ),
                      for (var w = 3; w < _weeks.length; w++) ...[
                        const TrainingTealSectionDivider(),
                        _ScrollWeekBlock(
                          weekIndex: w,
                          selectedWeekIndex: _selectedWeekIndex,
                          selectedDayIndex: _selectedDayIndex,
                          weeks: _weeks,
                          hPad: _hPad,
                          onSelectDay: (weekIndex, dayIndex) {
                            setState(() {
                              _selectedWeekIndex = weekIndex;
                              _selectedDayIndex = dayIndex;
                            });
                          },
                        ),
                      ],
                      const TrainingTealSectionDivider(),
                      _ScrollWeekBlock(
                        weekIndex: 0,
                        selectedWeekIndex: _selectedWeekIndex,
                        selectedDayIndex: _selectedDayIndex,
                        weeks: _weeks,
                        hPad: _hPad,
                        onSelectDay: (weekIndex, dayIndex) {
                          setState(() {
                            _selectedWeekIndex = weekIndex;
                            _selectedDayIndex = dayIndex;
                          });
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

typedef _DayEntry = ({String d, int n, TrainingWorkoutSlot? w});

class _PlanWeek {
  const _PlanWeek({
    required this.weekLabel,
    required this.dateRange,
    required this.totalMinutes,
    required this.days,
  });

  final String weekLabel;
  final String dateRange;
  final int totalMinutes;
  final List<_DayEntry> days;
}

class _ScrollWeekBlock extends StatelessWidget {
  const _ScrollWeekBlock({
    required this.weekIndex,
    required this.selectedWeekIndex,
    required this.selectedDayIndex,
    required this.weeks,
    required this.hPad,
    required this.onSelectDay,
  });

  final int weekIndex;
  final int selectedWeekIndex;
  final int selectedDayIndex;
  final List<_PlanWeek> weeks;
  final double hPad;
  final void Function(int weekIndex, int dayIndex) onSelectDay;

  @override
  Widget build(BuildContext context) {
    final w = weeks[weekIndex];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        TrainingWeekHeader(
          weekLabel: w.weekLabel,
          dateRange: w.dateRange,
          totalMinutes: w.totalMinutes,
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: hPad),
          child: Column(
            children: [
              for (var i = 0; i < w.days.length; i++)
                TrainingDayRow(
                  dayShort: w.days[i].d,
                  dayNumber: w.days[i].n,
                  workout: w.days[i].w,
                  showDividerBelow: i < w.days.length - 1,
                  isSelected:
                      weekIndex == selectedWeekIndex && i == selectedDayIndex,
                  onTap: () => onSelectDay(weekIndex, i),
                ),
            ],
          ),
        ),
      ],
    );
  }
}
