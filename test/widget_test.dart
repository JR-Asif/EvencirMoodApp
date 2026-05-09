import 'package:flutter_test/flutter_test.dart';

import 'package:evencir_mood_app/main.dart';

void main() {
  testWidgets('Fitness home shows key sections', (WidgetTester tester) async {
    await tester.pumpWidget(const EvencirFitnessApp());
    await tester.pumpAndSettle();

    expect(find.text('Workouts'), findsOneWidget);
    expect(find.text('Upper Body'), findsOneWidget);
    expect(find.text('My Insights'), findsOneWidget);
    expect(find.text('Nutrition'), findsOneWidget);
  });
}
