import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:evencir_mood_app/core/theme/app_assets.dart';
import 'package:evencir_mood_app/core/theme/fitness_theme.dart';
import 'package:evencir_mood_app/features/home/presentation/fitness_home_screen.dart';
import 'package:evencir_mood_app/features/mood/presentation/mood_screen.dart';
import 'package:evencir_mood_app/features/plan/presentation/plan_screen.dart';

import 'fitness_bottom_navigation.dart';

class AppShell extends StatefulWidget {
  const AppShell({super.key});

  @override
  State<AppShell> createState() => _AppShellState();
}

class _AppShellState extends State<AppShell> {
  int _index = 0;

  static const _navItems = [
    FitnessNavItem(
      label: 'Nutrition',
      assetPath: AppAssets.iconNavNutrition,
    ),
    FitnessNavItem(
      label: 'Plan',
      assetPath: AppAssets.iconNavPlan,
    ),
    FitnessNavItem(
      label: 'Mood',
      assetPath: AppAssets.iconNavMood,
    ),
    FitnessNavItem(
      label: 'Profile',
      assetPath: AppAssets.iconNavProfile,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: context.fitnessSystemUi,
      child: Scaffold(
        backgroundColor: context.palette.background,
        body: SafeArea(
          top: false,
          bottom: false,
          child: Column(
            children: [
              Expanded(
                child: IndexedStack(
                  index: _index,
                  sizing: StackFit.expand,
                  children: const [
                    FitnessHomeScreen(),
                    PlanScreen(),
                    MoodScreen(),
                    _ProfilePlaceholder(),
                  ],
                ),
              ),
              FitnessBottomNavigation(
                currentIndex: _index,
                onTap: (i) => setState(() => _index = i),
                items: _navItems,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ProfilePlaceholder extends StatelessWidget {
  const _ProfilePlaceholder();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: true,
      bottom: false,
      child: Center(
        child: Text(
          'Profile',
          style: TextStyle(
            color: context.palette.textSecondary,
            fontSize: 18,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}
