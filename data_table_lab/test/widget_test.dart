import 'package:flutter_test/flutter_test.dart';

import 'package:data_table_lab/main.dart';

/// Returns the given cell texts ordered top to bottom as they appear on screen.
List<String> rowOrder(WidgetTester tester, List<String> texts) {
  final sorted = [...texts]
    ..sort(
      (a, b) => tester
          .getTopLeft(find.text(a))
          .dy
          .compareTo(tester.getTopLeft(find.text(b)).dy),
    );
  return sorted;
}

const makes = ['Honda', 'Toyota', 'BMW'];

void main() {
  testWidgets('Shows title, headers and cars in default order', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const MyApp());

    expect(find.text('Lab 05: Exercise B'), findsOneWidget);
    for (final header in ['Car Make', 'Model', 'Price']) {
      expect(find.text(header), findsOneWidget);
    }
    expect(rowOrder(tester, makes), ['Honda', 'Toyota', 'BMW']);
  });

  testWidgets('Tapping Car Make sorts ascending by make', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const MyApp());
    await tester.tap(find.text('Car Make'));
    await tester.pumpAndSettle();

    expect(rowOrder(tester, makes), ['BMW', 'Honda', 'Toyota']);
  });

  testWidgets('Tapping Model sorts ascending by model year', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const MyApp());
    await tester.tap(find.text('Model'));
    await tester.pumpAndSettle();

    expect(rowOrder(tester, ['2021', '2011', '2010']), [
      '2010',
      '2011',
      '2021',
    ]);
    expect(rowOrder(tester, makes), ['BMW', 'Toyota', 'Honda']);
  });

  testWidgets('Tapping Price sorts ascending by price', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const MyApp());
    await tester.tap(find.text('Price'));
    await tester.pumpAndSettle();

    expect(rowOrder(tester, ['35000', '6000', '9000']), [
      '6000',
      '9000',
      '35000',
    ]);
    expect(rowOrder(tester, makes), ['Toyota', 'BMW', 'Honda']);
  });
}
