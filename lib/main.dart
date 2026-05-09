import 'package:flutter/material.dart';

import 'package:evencir_mood_app/core/theme/fitness_theme.dart';
import 'package:evencir_mood_app/features/shell/presentation/app_shell.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const EvencirFitnessApp());
}

class EvencirFitnessApp extends StatelessWidget {
  const EvencirFitnessApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fitness',
      debugShowCheckedModeBanner: false,
      theme: buildFitnessLightTheme(),
      darkTheme: buildFitnessDarkTheme(),
      themeMode: ThemeMode.system,
      home: const AppShell(),
    );
  }
}
