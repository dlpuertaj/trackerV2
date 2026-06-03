import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:money_tracker/models/entry.dart';
import 'package:money_tracker/widgets/transactions_table.dart';

void main() {
  group('TransactionsTable', () {
    testWidgets('shows empty state when entries list is empty',
        (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: TransactionsTable(entries: [], onTapEntry: (_) {}),
          ),
        ),
      );

      expect(find.text('No transactions yet'), findsOneWidget);
    });

    testWidgets('renders row with amount sign, date, and name',
        (tester) async {
      final entry = Entry(
        id: '1',
        amount: 50.0,
        type: EntryType.income,
        description: 'Freelance',
        date: DateTime(2026, 5, 24),
      );

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: TransactionsTable(
              entries: [entry],
              onTapEntry: (_) {},
            ),
          ),
        ),
      );

      expect(find.textContaining('\$50.00'), findsOneWidget);
      expect(find.textContaining('May 24, 2026'), findsOneWidget);
      expect(find.text('Freelance'), findsOneWidget);
    });

    testWidgets('income rows have green tint, expense rows have red tint',
        (tester) async {
      final income = Entry(
        id: '1',
        amount: 100.0,
        type: EntryType.income,
        date: DateTime(2026, 5, 24),
      );
      final expense = Entry(
        id: '2',
        amount: 30.0,
        type: EntryType.expense,
        date: DateTime(2026, 5, 23),
      );

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: TransactionsTable(
              entries: [income, expense],
              onTapEntry: (_) {},
            ),
          ),
        ),
      );

      final containers = tester.widgetList<Container>(find.byType(Container));
      final incomeRows = containers.where((c) {
        return c.color == Colors.green.shade50;
      });
      final expenseRows = containers.where((c) {
        return c.color == Colors.red.shade50;
      });

      expect(incomeRows.length, 1);
      expect(expenseRows.length, 1);
    });

    testWidgets('entries are in reverse-chronological order',
        (tester) async {
      final oldest = Entry(
        id: '1',
        amount: 10.0,
        type: EntryType.income,
        date: DateTime(2026, 5, 1),
        description: 'Oldest',
      );
      final middle = Entry(
        id: '2',
        amount: 20.0,
        type: EntryType.income,
        date: DateTime(2026, 5, 15),
        description: 'Middle',
      );
      final newest = Entry(
        id: '3',
        amount: 30.0,
        type: EntryType.income,
        date: DateTime(2026, 5, 24),
        description: 'Newest',
      );

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: TransactionsTable(
              entries: [oldest, middle, newest],
              onTapEntry: (_) {},
            ),
          ),
        ),
      );

      final texts = tester.widgetList<Text>(find.byType(Text)).toList();
      final indexOfNewest = texts.indexWhere((t) => t.data == 'Newest');
      final indexOfMiddle = texts.indexWhere((t) => t.data == 'Middle');
      final indexOfOldest = texts.indexWhere((t) => t.data == 'Oldest');

      expect(indexOfNewest, lessThan(indexOfMiddle));
      expect(indexOfMiddle, lessThan(indexOfOldest));
    });

    testWidgets('table scrolls when entries exceed screen', (tester) async {
      final entries = List.generate(
        20,
        (i) => Entry(
          id: i.toString(),
          amount: 10.0,
          type: EntryType.income,
          date: DateTime(2026, 5, 24 - i),
          description: 'Entry $i',
        ),
      );

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: TransactionsTable(
              entries: entries,
              onTapEntry: (_) {},
            ),
          ),
        ),
      );

      // Verify first entry is visible
      expect(find.text('Entry 0'), findsOneWidget);

      // Scroll down and verify last entry is visible
      await tester.scrollUntilVisible(
        find.text('Entry 19'),
        300,
        scrollable: find.byType(Scrollable).first,
      );

      expect(find.text('Entry 19'), findsOneWidget);
    });
  });
}
