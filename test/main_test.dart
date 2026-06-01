import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:money_tracker/main.dart' as app;

void main() {
  testWidgets('app renders MaterialApp with AppTheme', (tester) async {
    await tester.pumpWidget(const app.MoneyTrackerApp());

    expect(find.byType(MaterialApp), findsOneWidget);
  });
}
