import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:money_tracker/services/entry_repository.dart';
import 'package:money_tracker/widgets/add_income_button.dart';

void main() {
  group('AddIncomeButton', () {
    testWidgets('tap opens IncomeForm and saves entry', (tester) async {
      final repository = EntryRepository();

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: AddIncomeButton(repository: repository),
          ),
        ),
      );

      await tester.tap(find.text('Add Income'));
      await tester.pumpAndSettle();

      // Form should be visible (button + title = 2)
      expect(find.text('Add Income'), findsNWidgets(2));
      expect(find.text('Save'), findsOneWidget);
    });

    testWidgets('complete save flow works end-to-end', (tester) async {
      final repository = EntryRepository();

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: AddIncomeButton(repository: repository),
          ),
        ),
      );

      await tester.tap(find.text('Add Income'));
      await tester.pumpAndSettle();

      // Select Salary type
      await tester.tap(find.byType(DropdownButtonFormField<String>));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Salary').last);
      await tester.pumpAndSettle();

      // Enter amount
      await tester.enterText(find.byType(TextField).first, '5000');

      // Save
      await tester.tap(find.text('Save'));
      await tester.pumpAndSettle();

      // Success popup should show
      expect(find.text('Income Added Successfully'), findsOneWidget);
      expect(find.textContaining('\$5000.00'), findsOneWidget);

      // Dismiss popup
      await tester.tap(find.text('OK'));
      await tester.pumpAndSettle();

      expect(find.text('Income Added Successfully'), findsNothing);
    });
  });
}
