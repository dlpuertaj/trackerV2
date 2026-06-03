import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:money_tracker/models/income_type.dart';
import 'package:money_tracker/services/type_repository.dart';
import 'package:money_tracker/widgets/create_income_type_form.dart';

void main() {
  group('CreateIncomeTypeForm', () {
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
                onPressed: () => showCreateIncomeTypeForm(
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

    testWidgets('renders form with name field only (no toggle or value)',
        (tester) async {
      await openForm(tester);
      await tester.tap(find.text('Open'));
      await tester.pumpAndSettle();

      expect(find.text('Create Income Type'), findsOneWidget);
      expect(find.byType(TextField), findsOneWidget);
      expect(find.byType(Switch), findsNothing);
      expect(find.text('Create'), findsOneWidget);
      expect(find.text('Cancel'), findsOneWidget);
    });

    testWidgets('Create saves income type and closes form', (tester) async {
      await openForm(tester);
      await tester.tap(find.text('Open'));
      await tester.pumpAndSettle();

      await tester.enterText(find.byType(TextField).first, 'Salary');
      await tester.tap(find.text('Create'));
      await tester.pumpAndSettle();

      final types = repository.getIncomeTypes();
      expect(types.length, 1);
      expect(types.first.name, 'Salary');
      expect(find.text('Create Income Type'), findsNothing);
    });

    testWidgets('Cancel discards and closes form', (tester) async {
      await openForm(tester);
      await tester.tap(find.text('Open'));
      await tester.pumpAndSettle();

      await tester.enterText(find.byType(TextField).first, 'Salary');
      await tester.tap(find.text('Cancel'));
      await tester.pumpAndSettle();

      expect(repository.getIncomeTypes(), isEmpty);
      expect(find.text('Create Income Type'), findsNothing);
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
      repository.addIncomeType(IncomeType(name: 'Salary'));

      await openForm(tester);
      await tester.tap(find.text('Open'));
      await tester.pumpAndSettle();

      await tester.enterText(find.byType(TextField).first, 'Salary');
      await tester.tap(find.text('Create'));
      await tester.pumpAndSettle();

      expect(find.text('A type with this name already exists'), findsOneWidget);
    });
  });
}
