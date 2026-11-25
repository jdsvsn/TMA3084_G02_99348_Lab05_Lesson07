import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:bottom_navigator_bar_lab/main.dart';

const tabs = [
  (icon: Icons.home, label: 'Home'),
  (icon: Icons.alarm, label: 'Alarm'),
  (icon: Icons.business, label: 'Business'),
  (icon: Icons.school, label: 'School'),
];

void main() {
  testWidgets('Starts on Home screen', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());

    expect(find.text('Bottom Navigation Bar'), findsOneWidget);
    expect(find.text('Home'), findsNWidgets(2));
  });

  testWidgets('Tapping each bar icon shows its screen', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const MyApp());

    for (final tab in tabs) {
      await tester.tap(find.byIcon(tab.icon));
      await tester.pumpAndSettle();

      // Label appears twice: once in the bar, once on the screen.
      expect(find.text(tab.label), findsNWidgets(2));
      for (final other in tabs.where((t) => t.label != tab.label)) {
        expect(find.text(other.label), findsOneWidget);
      }
    }
  });
}
