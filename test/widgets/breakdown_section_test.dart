import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:money_tracker/widgets/breakdown_section.dart';

void main() {
  group('BreakdownSection', () {
    Future<void> pumpBreakdown(
      WidgetTester tester, {
      required double incomeTotal,
      required double expenseTotal,
    }) {
      return tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: BreakdownSection(
              incomeTotal: incomeTotal,
              expenseTotal: expenseTotal,
            ),
          ),
        ),
      );
    }

    testWidgets('displays income total with label', (tester) async {
      await pumpBreakdown(tester, incomeTotal: 1500.0, expenseTotal: 0.0);

      expect(find.text('Income'), findsOneWidget);
      expect(find.text('\$1,500.00'), findsOneWidget);
    });

    testWidgets('displays expense total with label', (tester) async {
      await pumpBreakdown(tester, incomeTotal: 0.0, expenseTotal: 800.50);

      expect(find.text('Expenses'), findsOneWidget);
      expect(find.text('\$800.50'), findsOneWidget);
    });

    testWidgets('displays both totals simultaneously', (tester) async {
      await pumpBreakdown(tester, incomeTotal: 2500.0, expenseTotal: 1200.0);

      expect(find.text('\$2,500.00'), findsOneWidget);
      expect(find.text('\$1,200.00'), findsOneWidget);
    });

    testWidgets('shows zero totals', (tester) async {
      await pumpBreakdown(tester, incomeTotal: 0.0, expenseTotal: 0.0);

      expect(find.text('\$0.00'), findsNWidgets(2));
    });

    testWidgets('income and expense have different visual styles',
        (tester) async {
      await pumpBreakdown(tester, incomeTotal: 500.0, expenseTotal: 300.0);

      final incomeLabel = find.text('Income');
      final expenseLabel = find.text('Expenses');

      final incomeWidget = tester.widget<Text>(incomeLabel);
      final expenseWidget = tester.widget<Text>(expenseLabel);

      expect(incomeWidget.style?.color, isNot(expenseWidget.style?.color));
    });

    testWidgets('displays income and expense in a row layout',
        (tester) async {
      await pumpBreakdown(tester, incomeTotal: 500.0, expenseTotal: 300.0);

      final incomeRow = find.text('\$500.00');
      final expenseRow = find.text('\$300.00');

      expect(incomeRow, findsOneWidget);
      expect(expenseRow, findsOneWidget);
    });
  });
}
