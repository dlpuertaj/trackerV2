import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:money_tracker/models/entry.dart';
import 'package:money_tracker/pages/home_page.dart';
import 'package:money_tracker/services/entry_repository.dart';

void main() {
  group('HomePage', () {
    late EntryRepository repository;

    setUp(() {
      repository = EntryRepository();
    });

    Future<void> pumpHomePage(WidgetTester tester) {
      return tester.pumpWidget(
        MaterialApp(
          home: HomePage(repository: repository),
        ),
      );
    }

    testWidgets('shows balance of 0.00 with no entries', (tester) async {
      await pumpHomePage(tester);

      final balanceKey = find.byKey(const Key('balanceDisplay'));
      expect(balanceKey, findsOneWidget);

      final balanceText = find.descendant(
        of: balanceKey,
        matching: find.text('\$0.00'),
      );
      expect(balanceText, findsOneWidget);
    });

    testWidgets('shows correct balance with income and expenses',
        (tester) async {
      repository.addEntry(
        Entry(id: '1', amount: 500.0, type: EntryType.income),
      );
      repository.addEntry(
        Entry(id: '2', amount: 200.0, type: EntryType.expense),
      );

      await pumpHomePage(tester);

      final balanceKey = find.byKey(const Key('balanceDisplay'));
      final balanceText = find.descendant(
        of: balanceKey,
        matching: find.text('\$300.00'),
      );
      expect(balanceText, findsOneWidget);
    });

    testWidgets('updates balance when entries change', (tester) async {
      await pumpHomePage(tester);

      final balanceKey = find.byKey(const Key('balanceDisplay'));
      var balanceText = find.descendant(
        of: balanceKey,
        matching: find.text('\$0.00'),
      );
      expect(balanceText, findsOneWidget);

      repository.addEntry(
        Entry(id: '1', amount: 100.0, type: EntryType.income),
      );
      await tester.pump();

      balanceText = find.descendant(
        of: balanceKey,
        matching: find.text('\$100.00'),
      );
      expect(balanceText, findsOneWidget);
    });

    testWidgets('shows negative balance when expenses exceed income',
        (tester) async {
      repository.addEntry(
        Entry(id: '1', amount: 50.0, type: EntryType.income),
      );
      repository.addEntry(
        Entry(id: '2', amount: 200.0, type: EntryType.expense),
      );

      await pumpHomePage(tester);

      final balanceKey = find.byKey(const Key('balanceDisplay'));
      final balanceText = find.descendant(
        of: balanceKey,
        matching: find.text('-\$150.00'),
      );
      expect(balanceText, findsOneWidget);
    });

    testWidgets('balance is visible at top of screen', (tester) async {
      await pumpHomePage(tester);

      final balanceKey = find.byKey(const Key('balanceDisplay'));
      expect(balanceKey, findsOneWidget);

      final textWidget = tester.widget<Text>(
        find.descendant(of: balanceKey, matching: find.byType(Text)),
      );
      expect(textWidget.style?.fontSize, greaterThan(20.0));
    });
  });
}
