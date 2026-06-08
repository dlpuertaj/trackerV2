import 'dart:async';
import '../models/entry.dart';
import '../models/expense_type.dart';

class EntryRepository {
  final List<Entry> _entries = [];
  final StreamController<void> _controller = StreamController<void>.broadcast();

  Stream<void> get onChange => _controller.stream;

  List<Entry> getAllEntries() {
    return List<Entry>.from(_entries)
      ..sort((a, b) => b.date.compareTo(a.date));
  }

  List<Entry> getEntriesByType(EntryType type) {
    return _entries.where((e) => e.type == type).toList()
      ..sort((a, b) => b.date.compareTo(a.date));
  }

  List<String> getIncomeTypes() {
    return ['Salary', 'Loan', 'Investment', 'Gift', 'Other'];
  }

  List<ExpenseType> getExpenseTypes() {
    return [
      ExpenseType(name: 'Rent', isFixed: true, fixedAmount: 1000.0),
      ExpenseType(name: 'Groceries', isFixed: false),
      ExpenseType(name: 'Utilities', isFixed: false),
    ];
  }

  void addEntry(Entry entry) {
    _entries.add(entry);
    _controller.add(null);
  }

  void removeEntry(String id) {
    _entries.removeWhere((e) => e.id == id);
    _controller.add(null);
  }

  void dispose() {
    _controller.close();
  }
}
