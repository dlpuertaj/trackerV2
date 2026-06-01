import 'package:flutter/material.dart';
import 'package:money_tracker/pages/home_page.dart';
import 'package:money_tracker/services/entry_repository.dart';
import 'package:money_tracker/theme/app_theme.dart';

void main() {
  runApp(MoneyTrackerApp());
}

class MoneyTrackerApp extends StatelessWidget {
  MoneyTrackerApp({super.key});

  final EntryRepository _repository = EntryRepository();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Money Tracker',
      theme: AppTheme.light,
      home: HomePage(repository: _repository),
    );
  }
}
