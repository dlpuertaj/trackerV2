import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:money_tracker/models/entry.dart';
import 'package:money_tracker/widgets/entry_list.dart';

void main() {
  group('EntryList', () {
    Future<void> pumpEntryList(WidgetTester tester, List<Entry> entries) {
      return tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: EntryList(entries: entries),
          ),
        ),
      );
    }

    testWidgets('shows empty state when no entries', (tester) async {
      await pumpEntryList(tester, []);

      expect(find.text('No entries yet'), findsOneWidget);
    });

    testWidgets('displays entry amount with positive sign for income',
        (tester) async {
      final entry = Entry(
        id: '1',
        amount: 250.0,
        type: EntryType.income,
        description: 'Salary',
        date: DateTime(2026, 5, 24),
      );

      await pumpEntryList(tester, [entry]);

      expect(find.textContaining('+'), findsOneWidget);
      expect(find.textContaining('\$250.00'), findsOneWidget);
    });

    testWidgets('displays entry amount with negative sign for expense',
        (tester) async {
      final entry = Entry(
        id: '1',
        amount: 80.50,
        type: EntryType.expense,
        description: 'Groceries',
        date: DateTime(2026, 5, 24),
      );

      await pumpEntryList(tester, [entry]);

      expect(find.textContaining('-'), findsOneWidget);
      expect(find.textContaining('\$80.50'), findsOneWidget);
    });

    testWidgets('displays entry description', (tester) async {
      final entry = Entry(
        id: '1',
        amount: 100.0,
        type: EntryType.income,
        description: 'Freelance work',
        date: DateTime(2026, 5, 24),
      );

      await pumpEntryList(tester, [entry]);

      expect(find.text('Freelance work'), findsOneWidget);
    });

    testWidgets('displays income label for income entries', (tester) async {
      final entry = Entry(
        id: '1',
        amount: 500.0,
        type: EntryType.income,
        description: 'Bonus',
        date: DateTime(2026, 5, 24),
      );

      await pumpEntryList(tester, [entry]);

      expect(find.text('Income'), findsOneWidget);
    });

    testWidgets('displays expense label for expense entries', (tester) async {
      final entry = Entry(
        id: '1',
        amount: 30.0,
        type: EntryType.expense,
        description: 'Coffee',
        date: DateTime(2026, 5, 24),
      );

      await pumpEntryList(tester, [entry]);

      expect(find.text('Expense'), findsOneWidget);
    });

    testWidgets('renders entries in reverse-chronological order',
        (tester) async {
      final entry1 = Entry(
        id: '1',
        amount: 100.0,
        type: EntryType.income,
        date: DateTime(2026, 5, 22),
      );
      final entry2 = Entry(
        id: '2',
        amount: 50.0,
        type: EntryType.expense,
        date: DateTime(2026, 5, 23),
      );
      final entry3 = Entry(
        id: '3',
        amount: 200.0,
        type: EntryType.income,
        date: DateTime(2026, 5, 24),
      );

      await pumpEntryList(tester, [entry1, entry2, entry3]);

      final entries = find.byType(ListTile);
      expect(entries, findsNWidgets(3));
    });

    testWidgets('scrolls when many entries', (tester) async {
      final entries = List<Entry>.generate(
        15,
        (i) => Entry(
          id: '$i',
          amount: 100.0,
          type: EntryType.income,
          description: 'Entry $i',
          date: DateTime(2026, 5, 24).subtract(Duration(days: i)),
        ),
      );

      await pumpEntryList(tester, entries);

      expect(find.text('Entry 0'), findsOneWidget);

      await tester.scrollUntilVisible(
        find.text('Entry 14'),
        100.0,
      );
      expect(find.text('Entry 14'), findsOneWidget);
    });

    testWidgets('entry does not show description when not provided',
        (tester) async {
      final entry = Entry(
        id: '1',
        amount: 100.0,
        type: EntryType.income,
        date: DateTime(2026, 5, 24),
      );

      await pumpEntryList(tester, [entry]);

      expect(find.byType(ListTile), findsOneWidget);
      expect(find.text('Income'), findsOneWidget);
    });
  });
}
