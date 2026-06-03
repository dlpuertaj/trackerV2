import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:money_tracker/models/entry.dart';
import 'package:money_tracker/widgets/transaction_detail.dart';

void main() {
  group('TransactionDetail', () {
    testWidgets('displays all entry fields', (tester) async {
      final entry = Entry(
        id: '1',
        amount: 150.0,
        type: EntryType.income,
        description: 'Freelance project',
        category: 'Work',
        date: DateTime(2026, 5, 24),
      );

      await tester.pumpWidget(
        MaterialApp(
          home: Builder(
            builder: (context) => ElevatedButton(
              onPressed: () => showTransactionDetail(
                context,
                entry: entry,
              ),
              child: const Text('Open'),
            ),
          ),
        ),
      );

      await tester.tap(find.text('Open'));
      await tester.pumpAndSettle();

      expect(find.textContaining('\$150.00'), findsOneWidget);
      expect(find.text('Income'), findsOneWidget);
      expect(find.text('Work'), findsOneWidget);
      expect(find.text('Freelance project'), findsOneWidget);
    });

    testWidgets('has a dismiss action', (tester) async {
      final entry = Entry(
        id: '1',
        amount: 50.0,
        type: EntryType.expense,
        description: 'Groceries',
        date: DateTime(2026, 5, 24),
      );

      await tester.pumpWidget(
        MaterialApp(
          home: Builder(
            builder: (context) => ElevatedButton(
              onPressed: () => showTransactionDetail(
                context,
                entry: entry,
              ),
              child: const Text('Open'),
            ),
          ),
        ),
      );

      await tester.tap(find.text('Open'));
      await tester.pumpAndSettle();

      expect(find.text('Groceries'), findsOneWidget);

      // Dismiss by tapping Close
      await tester.tap(find.text('Close'));
      await tester.pumpAndSettle();

      expect(find.text('Groceries'), findsNothing);
    });
  });
}
