import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:money_tracker/main.dart' as app;
import 'package:money_tracker/pages/home_page.dart';

void main() {
  testWidgets('app renders MaterialApp with HomePage', (tester) async {
    await tester.pumpWidget(app.MoneyTrackerApp());

    expect(find.byType(MaterialApp), findsOneWidget);
    expect(find.byType(HomePage), findsOneWidget);
  });
}
