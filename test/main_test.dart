import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:money_tracker/main.dart' as app;
import 'package:money_tracker/pages/home_page.dart';
import 'package:money_tracker/services/entry_repository.dart';
import 'package:money_tracker/services/type_repository.dart';

void main() {
  testWidgets('app renders MaterialApp with HomePage', (tester) async {
    final repository = EntryRepository();
    final typeRepository = TypeRepository();
    await tester.pumpWidget(app.MoneyTrackerApp(
      repository: repository,
      typeRepository: typeRepository,
    ));

    expect(find.byType(MaterialApp), findsOneWidget);
    expect(find.byType(HomePage), findsOneWidget);
  });
}
