import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:money_tracker/models/expense_type.dart';
import 'package:money_tracker/services/type_repository.dart';
import 'package:money_tracker/widgets/create_expense_type_form.dart';

void main() {
  group('CreateExpenseTypeForm', () {
    late TypeRepository repository;

    setUp(() {
      repository = TypeRepository();
    });

    Future<void> openForm(WidgetTester tester) {
      return tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Builder(
              builder: (context) => ElevatedButton(
                onPressed: () => showCreateExpenseTypeForm(
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

    testWidgets('renders form with name field, toggle, and buttons',
        (tester) async {
      await openForm(tester);
      await tester.tap(find.text('Open'));
      await tester.pumpAndSettle();

      expect(find.text('Create Expense Type'), findsOneWidget);
      expect(find.byType(TextField), findsOneWidget);
      expect(find.byType(Switch), findsOneWidget);
      expect(find.text('Create'), findsOneWidget);
      expect(find.text('Cancel'), findsOneWidget);
    });

    testWidgets('value field is hidden when toggle is off', (tester) async {
      await openForm(tester);
      await tester.tap(find.text('Open'));
      await tester.pumpAndSettle();

      expect(find.byType(TextField), findsOneWidget);
    });

    testWidgets('value field appears when toggle is on', (tester) async {
      await openForm(tester);
      await tester.tap(find.text('Open'));
      await tester.pumpAndSettle();

      await tester.tap(find.byType(Switch));
      await tester.pumpAndSettle();

      expect(find.byType(TextField), findsNWidgets(2));
    });

    testWidgets('Create saves expense type and closes form', (tester) async {
      await openForm(tester);
      await tester.tap(find.text('Open'));
      await tester.pumpAndSettle();

      await tester.enterText(find.byType(TextField).first, 'Rent');
      await tester.tap(find.text('Create'));
      await tester.pumpAndSettle();

      final types = repository.getExpenseTypes();
      expect(types.length, 1);
      expect(types.first.name, 'Rent');
      expect(find.text('Create Expense Type'), findsNothing);
    });

    testWidgets('Cancel discards and closes form', (tester) async {
      await openForm(tester);
      await tester.tap(find.text('Open'));
      await tester.pumpAndSettle();

      await tester.enterText(find.byType(TextField).first, 'Rent');
      await tester.tap(find.text('Cancel'));
      await tester.pumpAndSettle();

      expect(repository.getExpenseTypes(), isEmpty);
      expect(find.text('Create Expense Type'), findsNothing);
    });

    testWidgets('shows error for blank name', (tester) async {
      await openForm(tester);
      await tester.tap(find.text('Open'));
      await tester.pumpAndSettle();

      await tester.tap(find.text('Create'));
      await tester.pumpAndSettle();

      expect(find.text('Name is required'), findsOneWidget);
    });

    testWidgets('shows error for duplicate name', (tester) async {
      repository.addExpenseType(
        ExpenseType(name: 'Rent', isFixed: true, fixedAmount: 1000.0),
      );

      await openForm(tester);
      await tester.tap(find.text('Open'));
      await tester.pumpAndSettle();

      await tester.enterText(find.byType(TextField).first, 'Rent');
      await tester.tap(find.byType(Switch));
      await tester.pumpAndSettle();

      await tester.enterText(find.byType(TextField).last, '1000');
      await tester.tap(find.text('Create'));
      await tester.pumpAndSettle();

      expect(find.text('A type with this name already exists'), findsOneWidget);
    });

    testWidgets('shows error for invalid amount when fixed', (tester) async {
      await openForm(tester);
      await tester.tap(find.text('Open'));
      await tester.pumpAndSettle();

      await tester.enterText(find.byType(TextField).first, 'Rent');
      await tester.tap(find.byType(Switch));
      await tester.pumpAndSettle();

      await tester.enterText(find.byType(TextField).last, '0');
      await tester.tap(find.text('Create'));
      await tester.pumpAndSettle();

      expect(find.text('Amount must be positive'), findsOneWidget);
    });
  });
}
