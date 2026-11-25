import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:bottom_navigator_bar_lab/main.dart';

void main() {
  testWidgets('Shell shows app bar title and four bar labels', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const MyApp());

    expect(find.text('Lab 05: Exercise A'), findsOneWidget);
    expect(find.byType(BottomNavigationBar), findsOneWidget);
    for (final label in ['Home', 'Alarm', 'Business', 'School']) {
      expect(find.text(label), findsOneWidget);
    }
  });
}
