import 'package:flutter/material.dart';
import 'package:money_tracker/models/entry.dart';
import 'package:money_tracker/pages/home_page.dart';
import 'package:money_tracker/services/entry_repository.dart';
import 'package:money_tracker/theme/app_theme.dart';

void main() {
  final repository = EntryRepository();
  _seedDummyData(repository);
  runApp(MoneyTrackerApp(repository: repository));
}

void _seedDummyData(EntryRepository repository) {
  repository.addEntry(
    Entry(
      id: '1',
      amount: 3500.0,
      type: EntryType.income,
      description: 'Monthly salary',
      category: 'Salary',
      date: DateTime(2026, 6, 1),
    ),
  );
  repository.addEntry(
    Entry(
      id: '2',
      amount: 120.0,
      type: EntryType.expense,
      description: 'Weekly groceries',
      category: 'Food',
      date: DateTime(2026, 5, 30),
    ),
  );
  repository.addEntry(
    Entry(
      id: '3',
      amount: 45.0,
      type: EntryType.expense,
      description: 'Internet subscription',
      category: 'Utilities',
      date: DateTime(2026, 5, 28),
    ),
  );
  repository.addEntry(
    Entry(
      id: '4',
      amount: 500.0,
      type: EntryType.income,
      description: 'Freelance website redesign',
      category: 'Freelance',
      date: DateTime(2026, 5, 25),
    ),
  );
  repository.addEntry(
    Entry(
      id: '5',
      amount: 200.0,
      type: EntryType.expense,
      description: 'Dinner at Italian place',
      category: 'Dining',
      date: DateTime(2026, 5, 24),
    ),
  );
  repository.addEntry(
    Entry(
      id: '6',
      amount: 15.0,
      type: EntryType.expense,
      description: 'Netflix monthly',
      category: 'Entertainment',
      date: DateTime(2026, 5, 22),
    ),
  );
}

class MoneyTrackerApp extends StatelessWidget {
  final EntryRepository repository;

  const MoneyTrackerApp({super.key, required this.repository});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Money Tracker',
      theme: AppTheme.light,
      home: HomePage(repository: repository),
    );
  }
}
