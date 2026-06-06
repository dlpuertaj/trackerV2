import 'dart:async';
import 'package:flutter/material.dart';
import 'package:money_tracker/models/entry.dart';
import 'package:money_tracker/services/entry_repository.dart';
import 'package:money_tracker/widgets/add_expense_button.dart';
import 'package:money_tracker/widgets/add_income_button.dart';
import 'package:money_tracker/widgets/balance_display.dart';
import 'package:money_tracker/widgets/transactions_table.dart';
import 'package:money_tracker/widgets/transaction_detail.dart';

class HomePage extends StatefulWidget {
  final EntryRepository repository;

  const HomePage({
    super.key,
    required this.repository,
  });

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  double _balance = 0.0;
  List<Entry> _entries = [];
  StreamSubscription<void>? _subscription;

  @override
  void initState() {
    super.initState();
    _calculateBalance();
    _subscription = widget.repository.onChange.listen((_) {
      _calculateBalance();
    });
  }

  @override
  void dispose() {
    _subscription?.cancel();
    super.dispose();
  }

  void _calculateBalance() {
    final entries = widget.repository.getAllEntries();
    final income = entries
        .where((e) => e.type == EntryType.income)
        .fold<double>(0.0, (sum, e) => sum + e.amount);
    final expense = entries
        .where((e) => e.type == EntryType.expense)
        .fold<double>(0.0, (sum, e) => sum + e.amount);
    setState(() {
      _balance = income - expense;
      _entries = entries;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Money Tracker'),
      ),
      body: Column(
        children: [
          BalanceDisplay(key: const Key('balanceDisplay'), balance: _balance),
          Expanded(
            child: TransactionsTable(
              entries: _entries,
              onTapEntry: (entry) {
                showTransactionDetail(context, entry: entry);
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Row(
              children: [
                Expanded(
                  child: AddIncomeButton(repository: widget.repository),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: AddExpenseButton(repository: widget.repository),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
