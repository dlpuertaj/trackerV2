import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:money_tracker/models/entry.dart';
import 'package:money_tracker/services/entry_repository.dart';
import 'package:money_tracker/widgets/income_form.dart';

void main() {
  group('IncomeForm', () {
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
                onPressed: () => showIncomeForm(
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

      expect(find.text('Add Income'), findsOneWidget);
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

    testWidgets('saves entry on valid input', (tester) async {
      await openForm(tester);
      await tester.tap(find.text('Open'));
      await tester.pumpAndSettle();

      // Select type
      await tester.tap(find.byType(DropdownButtonFormField<String>));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Salary').last);
      await tester.pumpAndSettle();

      // Enter amount
      await tester.enterText(find.byType(TextField).first, '5000');

      // Enter description
      await tester.enterText(find.byType(TextField).last, 'Monthly salary');

      // Save
      await tester.tap(find.text('Save'));
      await tester.pumpAndSettle();

      final entries = repository.getAllEntries();
      expect(entries.length, 1);
      expect(entries.first.amount, 5000.0);
      expect(entries.first.type, EntryType.income);
      expect(entries.first.category, 'Salary');
      expect(entries.first.description, 'Monthly salary');
    });
  });
}
