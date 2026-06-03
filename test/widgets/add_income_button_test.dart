import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:money_tracker/services/entry_repository.dart';
import 'package:money_tracker/widgets/add_income_button.dart';

void main() {
  group('AddIncomeButton', () {
    late EntryRepository repository;

    setUp(() {
      repository = EntryRepository();
    });

    Future<void> pumpButton(WidgetTester tester) {
      return tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: AddIncomeButton(repository: repository),
          ),
        ),
      );
    }

    testWidgets('renders Add Income button', (tester) async {
      await pumpButton(tester);

      expect(find.text('Add Income'), findsOneWidget);
    });

    testWidgets('tap opens income form', (tester) async {
      await pumpButton(tester);

      await tester.tap(find.text('Add Income'));
      await tester.pumpAndSettle();

      expect(find.text('Save'), findsOneWidget);
      expect(find.text('Cancel'), findsOneWidget);
    });

    testWidgets('full flow: form -> save -> success popup', (tester) async {
      await pumpButton(tester);

      await tester.tap(find.text('Add Income'));
      await tester.pumpAndSettle();

      // Select type
      await tester.tap(find.byType(DropdownButtonFormField<String>));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Salary').last);
      await tester.pumpAndSettle();

      // Enter amount
      await tester.enterText(find.byType(TextField).first, '3000');

      // Save
      await tester.tap(find.text('Save'));
      await tester.pumpAndSettle();

      // Verify success popup appears
      expect(find.text('Income Added Successfully'), findsOneWidget);
      expect(find.text('OK'), findsOneWidget);

      // Verify entry was saved
      final entries = repository.getAllEntries();
      expect(entries.length, 1);
      expect(entries.first.amount, 3000.0);
    });
  });
}
