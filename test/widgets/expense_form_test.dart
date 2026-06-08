import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:money_tracker/models/entry.dart';
import 'package:money_tracker/services/entry_repository.dart';
import 'package:money_tracker/widgets/expense_form.dart';

void main() {
  group('ExpenseForm', () {
    late EntryRepository repository;

    setUp(() {
      repository = EntryRepository();
    });

    Future<void> openForm(WidgetTester tester) {
      return tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Builder(
              builder: (context) => ElevatedButton(
                onPressed: () => showExpenseForm(
                  context,
                  repository: repository,
                ),
                child: const Text('Open'),
              ),
            ),
          ),
        ),
      );
    }

    testWidgets('renders form with type dropdown, amount, description, buttons',
        (tester) async {
      await openForm(tester);
      await tester.tap(find.text('Open'));
      await tester.pumpAndSettle();

      expect(find.text('Add Expense'), findsOneWidget);
      expect(find.byType(DropdownButtonFormField<String>), findsOneWidget);
      expect(find.byType(TextField), findsNWidgets(2));
      expect(find.text('Save'), findsOneWidget);
      expect(find.text('Cancel'), findsOneWidget);
    });

    testWidgets('shows validation errors when fields are empty',
        (tester) async {
      await openForm(tester);
      await tester.tap(find.text('Open'));
      await tester.pumpAndSettle();

      await tester.tap(find.text('Save'));
      await tester.pumpAndSettle();

      expect(find.text('Please select a type'), findsOneWidget);
      expect(find.text('Amount must be positive'), findsOneWidget);
    });

    testWidgets('selecting fixed type pre-fills amount field', (tester) async {
      await openForm(tester);
      await tester.tap(find.text('Open'));
      await tester.pumpAndSettle();

      // Select Rent (fixed type with $1000)
      await tester.tap(find.byType(DropdownButtonFormField<String>));
      await tester.pumpAndSettle();
      await tester.tap(find.textContaining('Rent').last);
      await tester.pumpAndSettle();

      final amountField = tester.widget<TextField>(find.byType(TextField).first);
      expect(amountField.controller?.text, '1000.00');
    });

    testWidgets('pre-filled amount from fixed type can be overridden',
        (tester) async {
      await openForm(tester);
      await tester.tap(find.text('Open'));
      await tester.pumpAndSettle();

      // Select Rent — auto-fills $1000
      await tester.tap(find.byType(DropdownButtonFormField<String>));
      await tester.pumpAndSettle();
      await tester.tap(find.textContaining('Rent').last);
      await tester.pumpAndSettle();

      // Override amount
      await tester.enterText(find.byType(TextField).first, '950');

      // Save
      await tester.tap(find.text('Save'));
      await tester.pumpAndSettle();

      final entries = repository.getAllEntries();
      expect(entries.length, 1);
      expect(entries.first.amount, 950.0);
    });

    testWidgets('Cancel closes form without saving', (tester) async {
      await openForm(tester);
      await tester.tap(find.text('Open'));
      await tester.pumpAndSettle();

      // Select type and enter data
      await tester.tap(find.byType(DropdownButtonFormField<String>));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Groceries').last);
      await tester.pumpAndSettle();
      await tester.enterText(find.byType(TextField).first, '50');

      // Tap Cancel
      await tester.tap(find.text('Cancel'));
      await tester.pumpAndSettle();

      // Verify no entry was saved
      expect(repository.getAllEntries(), isEmpty);
      // Verify form is closed
      expect(find.text('Add Expense'), findsNothing);
    });

    testWidgets('saves expense entry on valid input for variable type',
        (tester) async {
      await openForm(tester);
      await tester.tap(find.text('Open'));
      await tester.pumpAndSettle();

      // Select type (Groceries — variable)
      await tester.tap(find.byType(DropdownButtonFormField<String>));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Groceries').last);
      await tester.pumpAndSettle();

      // Enter amount
      await tester.enterText(find.byType(TextField).first, '50');

      // Enter description
      await tester.enterText(find.byType(TextField).last, 'Weekly shop');

      // Save
      await tester.tap(find.text('Save'));
      await tester.pumpAndSettle();

      final entries = repository.getAllEntries();
      expect(entries.length, 1);
      expect(entries.first.amount, 50.0);
      expect(entries.first.type, EntryType.expense);
      expect(entries.first.category, 'Groceries');
      expect(entries.first.description, 'Weekly shop');
    });
  });
}
