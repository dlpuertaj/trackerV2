import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:money_tracker/widgets/balance_display.dart';

void main() {
  group('BalanceDisplay', () {
    Future<void> pumpBalance(WidgetTester tester, double balance) {
      return tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: BalanceDisplay(balance: balance),
          ),
        ),
      );
    }

    testWidgets('displays positive balance', (tester) async {
      await pumpBalance(tester, 1250.50);

      expect(find.text('\$1,250.50'), findsOneWidget);
    });

    testWidgets('displays zero balance', (tester) async {
      await pumpBalance(tester, 0.0);

      expect(find.text('\$0.00'), findsOneWidget);
    });

    testWidgets('displays negative balance with minus sign', (tester) async {
      await pumpBalance(tester, -350.75);

      expect(find.text('-\$350.75'), findsOneWidget);
    });

    testWidgets('uses neutral colour for balance text', (tester) async {
      await pumpBalance(tester, 1000.0);

      final text = tester.widget<Text>(find.byType(Text));
      expect(text.style?.color, isNot(Colors.green));
      expect(text.style?.color, isNot(Colors.red));
    });

    testWidgets('displays balance in large font', (tester) async {
      await pumpBalance(tester, 500.0);

      final text = tester.widget<Text>(find.byType(Text));
      expect(text.style?.fontSize, greaterThan(28.0));
    });
  });
}
