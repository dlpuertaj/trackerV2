import 'package:flutter/material.dart';
import 'package:money_tracker/theme/app_theme.dart';

void main() {
  runApp(const MoneyTrackerApp());
}

class MoneyTrackerApp extends StatelessWidget {
  const MoneyTrackerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Money Tracker',
      theme: AppTheme.light,
      home: const Scaffold(
        body: Center(
          child: Text('Money Tracker'),
        ),
      ),
    );
  }
}
