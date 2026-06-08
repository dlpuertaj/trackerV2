import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:money_tracker/services/entry_repository.dart';
import 'package:money_tracker/services/type_repository.dart';
import 'package:money_tracker/widgets/add_expense_button.dart';

void main() {
  group('AddExpenseButton', () {
    late EntryRepository repository;
    late TypeRepository typeRepository;

    setUp(() {
      repository = EntryRepository();
      typeRepository = TypeRepository();
    });

    Future<void> pumpButton(WidgetTester tester) {
      return tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: AddExpenseButton(
              repository: repository,
              typeRepository: typeRepository,
            ),
          ),
        ),
      );
    }

    testWidgets('renders Add Expense button', (tester) async {
      await pumpButton(tester);

      expect(find.text('Add Expense'), findsOneWidget);
    });

    testWidgets('tap opens expense form', (tester) async {
      await pumpButton(tester);

      await tester.tap(find.text('Add Expense'));
      await tester.pumpAndSettle();

      expect(find.text('Save'), findsOneWidget);
      expect(find.text('Cancel'), findsOneWidget);
    });
  });
}
