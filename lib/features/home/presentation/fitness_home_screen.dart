import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:evencir_mood_app/core/theme/app_assets.dart';
import 'package:evencir_mood_app/core/theme/fitness_theme.dart';
import 'package:evencir_mood_app/features/home/presentation/widgets/featured_workout_card.dart';
import 'package:evencir_mood_app/features/home/presentation/widgets/insight_cards.dart';
import 'package:evencir_mood_app/features/home/presentation/widgets/month_calendar_bottom_sheet.dart';
import 'package:evencir_mood_app/features/home/presentation/widgets/weekly_calendar_row.dart';

class FitnessHomeScreen extends StatefulWidget {
  const FitnessHomeScreen({super.key});

  @override
  State<FitnessHomeScreen> createState() => _FitnessHomeScreenState();
}

class _FitnessHomeScreenState extends State<FitnessHomeScreen>
    with SingleTickerProviderStateMixin {
  static const _horizontalPad = 20.0;

  late DateTime _selectedDate;

  late AnimationController _entranceController;
  late Animation<double> _entranceCurve;

  @override
  void initState() {
    super.initState();
    final n = DateTime.now();
    _selectedDate = DateTime(n.year, n.month, n.day);
    _entranceController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 720),
    );
    _entranceCurve = CurvedAnimation(
      parent: _entranceController,
      curve: Curves.easeOutCubic,
    );
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) _entranceController.forward();
    });
  }

  @override
  void dispose() {
    _entranceController.dispose();
    super.dispose();
  }

  List<WeekDayModel> _buildWeekDays() {
    const labels = ['M', 'TU', 'W', 'TH', 'F', 'SA', 'SU'];
    final base = DateTime(
      _selectedDate.year,
      _selectedDate.month,
      _selectedDate.day,
    );
    final monday = base.subtract(Duration(days: base.weekday - 1));
    return [
      for (var i = 0; i < 7; i++)
        WeekDayModel(
          label: labels[i],
          date: monday.add(Duration(days: i)).day,
          isSelected: isSameCalendarDay(
            monday.add(Duration(days: i)),
            _selectedDate,
          ),
        ),
    ];
  }

  Future<void> _openMonthCalendar() async {
    final picked = await showFitnessMonthCalendarPicker(
      context,
      selectedDate: _selectedDate,
    );
    if (!mounted || picked == null) return;
    setState(() {
      _selectedDate = DateTime(picked.year, picked.month, picked.day);
    });
  }

  @override
  Widget build(BuildContext context) {
    final p = context.palette;
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: context.fitnessSystemUi,
      child: Scaffold(
        backgroundColor: p.background,
        body: SafeArea(
          top: true,
          bottom: false,
          child: Column(
            children: [
              Expanded(
                child: AnimatedBuilder(
                  animation: _entranceCurve,
                  builder: (context, child) {
                    return Opacity(
                      opacity: _entranceCurve.value,
                      child: Transform.translate(
                        offset: Offset(0, 10 * (1 - _entranceCurve.value)),
                        child: child,
                      ),
                    );
                  },
                  child: CustomScrollView(
                    physics: const BouncingScrollPhysics(
                      parent: AlwaysScrollableScrollPhysics(),
                    ),
                    slivers: [
                      SliverPadding(
                        padding: const EdgeInsets.fromLTRB(
                          _horizontalPad,
                          14,
                          _horizontalPad,
                          0,
                        ),
                        sliver: SliverToBoxAdapter(
                          child: _TopBar(
                            onBell: () {},
                            onWeekTap: _openMonthCalendar,
                          ),
                        ),
                      ),
                      SliverPadding(
                        padding: const EdgeInsets.fromLTRB(
                          _horizontalPad,
                          6,
                          _horizontalPad,
                          0,
                        ),
                        sliver: SliverToBoxAdapter(
                          child: Material(
                            color: Colors.transparent,
                            child: InkWell(
                              onTap: _openMonthCalendar,
                              borderRadius:
                                  BorderRadius.circular(FitnessRadii.sheet),
                              child: Padding(
                                padding: const EdgeInsets.only(bottom: 4),
                                child: Text(
                                  formatTodayLine(_selectedDate),
                                  style: p.homeTodayLine,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      SliverPadding(
                        padding: const EdgeInsets.fromLTRB(
                          _horizontalPad,
                          18,
                          _horizontalPad,
                          8,
                        ),
                        sliver: SliverToBoxAdapter(
                          child: WeeklyCalendarRow(
                            days: _buildWeekDays(),
                            onDaySelected: (i) {
                              final base = DateTime(
                                _selectedDate.year,
                                _selectedDate.month,
                                _selectedDate.day,
                              );
                              final monday = base.subtract(
                                Duration(days: base.weekday - 1),
                              );
                              setState(() {
                                _selectedDate = monday.add(Duration(days: i));
                              });
                            },
                          ),
                        ),
                      ),
                      SliverToBoxAdapter(
                        child: Center(
                          child: Container(
                            width: 36,
                            height: 4,
                            margin: const EdgeInsets.only(bottom: 18),
                            decoration: BoxDecoration(
                              color: p.dividerHandle,
                              borderRadius: BorderRadius.circular(100),
                            ),
                          ),
                        ),
                      ),
                      SliverPadding(
                        padding: const EdgeInsets.fromLTRB(
                          _horizontalPad,
                          0,
                          _horizontalPad,
                          12,
                        ),
                        sliver: SliverToBoxAdapter(
                          child: _SectionTitle(
                            title: 'Workouts',
                            trailing: const _HomeWeatherChip(),
                          ),
                        ),
                      ),
                      SliverPadding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: _horizontalPad,
                        ),
                        sliver: SliverToBoxAdapter(
                          child: TweenAnimationBuilder<double>(
                            tween: Tween(begin: 0.98, end: 1),
                            duration: const Duration(milliseconds: 500),
                            curve: Curves.easeOutCubic,
                            builder: (context, scale, child) {
                              return Transform.scale(
                                scale: scale,
                                alignment: Alignment.center,
                                child: child,
                              );
                            },
                            child: FeaturedWorkoutCard(
                              metaLine:
                                  '${formatShortMonthDay(_selectedDate)} - 25m - 30m',
                              title: 'Upper Body',
                              onTap: () {},
                            ),
                          ),
                        ),
                      ), 
                      SliverPadding(
                        padding: const EdgeInsets.fromLTRB(
                          _horizontalPad,
                          28,
                          _horizontalPad,
                          18,
                        ),
                        sliver: SliverToBoxAdapter(
                          child: Text(
                            'My Insights',
                            style: p.homeSectionTitle,
                          ),
                        ),
                      ),
                      SliverPadding(
                        padding: const EdgeInsets.fromLTRB(
                          _horizontalPad,
                          0,
                          _horizontalPad,
                          0,
                        ),
                        sliver: SliverToBoxAdapter(
                          child: IntrinsicHeight(
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Expanded(
                                  child: CaloriesInsightCard(
                                    consumed: 550,
                                    remaining: 1950,
                                    maxCalories: 2500,
                                  ),
                                ),
                                const SizedBox(width: 10),
                                Expanded(
                                  child: WeightInsightCard(
                                    kg: 75,
                                    deltaLabel: '+1.6kg',
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      SliverPadding(
                        padding: const EdgeInsets.fromLTRB(
                          _horizontalPad,
                          8,
                          _horizontalPad,
                          100,
                        ),
                        sliver: SliverToBoxAdapter(
                          child: HydrationInsightCard(
                            percentText: '0%',
                            notificationText: '500 ml added to water log',
                            litersCurrent: 0,
                            litersGoal: 2,
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
    );
  }
}

class _HomeWeatherChip extends StatelessWidget {
  const _HomeWeatherChip();

  static const Duration _swap = Duration(milliseconds: 500);

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final fg = context.palette.textPrimary;

    final switchKey = isDark ? 'd' : 'l';

    late final Widget glyph;

    if (!isDark) {
      glyph = Icon(
        Icons.brightness_2_rounded,
        size: 18,
        color: fg,
      );
    } else {
      glyph = Image.asset(
        AppAssets.iconHomeDayLight,
        width: 18,
        height: 18,
        fit: BoxFit.contain,
        filterQuality: FilterQuality.high,
      );
    }

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          width: 18,
          height: 18,
          child: AnimatedSwitcher(
            duration: _swap,
            switchInCurve: Curves.easeOut,
            switchOutCurve: Curves.easeIn,
            transitionBuilder: (child, anim) => FadeTransition(
              opacity: anim,
              child: ScaleTransition(
                scale:
                    Tween<double>(begin: 0.88, end: 1).animate(anim),
                child: child,
              ),
            ),
            child: SizedBox(
              width: 18,
              height: 18,
              key: ValueKey<String>(switchKey),
              child: Center(child: glyph),
            ),
          ),
        ),
        const SizedBox(width: 4),
        Text(
          '9°',
          style: TextStyle(
            color: fg,
            fontSize: 18,
            fontWeight: FontWeight.w700,
          ),
        ),
      ],
    );
  }
}

class _TopBar extends StatelessWidget {
  const _TopBar({required this.onBell, required this.onWeekTap});

  final VoidCallback onBell;
  final VoidCallback onWeekTap;

  @override
  Widget build(BuildContext context) {
    final p = context.palette;
    const trailingW = 40.0;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          width: trailingW,
          child: Align(
            alignment: Alignment.centerLeft,
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: onBell,
                customBorder: const CircleBorder(),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(0, 8, 8, 8),
                  child: SizedBox(
                    width: 20,
                    height: 20,
                    child: ColorFiltered(
                      colorFilter: ColorFilter.mode(
                        p.textPrimary.withValues(alpha: 0.95),
                        BlendMode.srcIn,
                      ),
                      child: Image.asset(
                        AppAssets.iconHomeNotification,
                        width: 20,
                        height: 20,
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
        Expanded(
          child: Center(
            child: InkWell(
              onTap: onWeekTap,
              borderRadius: BorderRadius.circular(FitnessRadii.card),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 6,
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 18,
                      height: 18,
                      child: ColorFiltered(
                        colorFilter: ColorFilter.mode(
                          p.textPrimary.withValues(alpha: 0.92),
                          BlendMode.srcIn,
                        ),
                        child: Image.asset(
                          AppAssets.iconHomeWeekChip,
                          width: 18,
                          height: 18,
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                    const SizedBox(width: 6),
                    Text(
                      'Week 1/4',
                      style: TextStyle(
                        color: p.textPrimary,
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                        letterSpacing: -0.25,
                      ),
                    ),
                    const SizedBox(width: 0),
                    Icon(
                      Icons.arrow_drop_down,
                      size: 22,
                      color: p.textPrimary.withValues(alpha: 0.55),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        const SizedBox(width: trailingW),
      ],
    );
  }
}

class _SectionTitle extends StatelessWidget {
  const _SectionTitle({required this.title, this.trailing});

  final String title;
  final Widget? trailing;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          title,
          style: context.palette.homeSectionTitle,
        ),
        const Spacer(),
        if (trailing != null) trailing!,
      ],
    );
  }
}
