import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:money_tracker/widgets/success_popup.dart';

void main() {
  group('SuccessPopup', () {
    testWidgets('shows income added message with updated balance',
        (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Builder(
            builder: (context) => ElevatedButton(
              onPressed: () => showSuccessPopup(
                context,
                updatedBalance: 5000.0,
              ),
              child: const Text('Open'),
            ),
          ),
        ),
      );

      await tester.tap(find.text('Open'));
      await tester.pumpAndSettle();

      expect(find.text('Income Added Successfully'), findsOneWidget);
      expect(find.textContaining('\$5000.00'), findsOneWidget);
      expect(find.text('OK'), findsOneWidget);
    });

    testWidgets('dismisses on OK tap', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Builder(
            builder: (context) => ElevatedButton(
              onPressed: () => showSuccessPopup(
                context,
                updatedBalance: 100.0,
              ),
              child: const Text('Open'),
            ),
          ),
        ),
      );

      await tester.tap(find.text('Open'));
      await tester.pumpAndSettle();

      await tester.tap(find.text('OK'));
      await tester.pumpAndSettle();

      expect(find.text('Income Added Successfully'), findsNothing);
    });
  });
}
