import 'dart:async';
import '../models/expense_type.dart';
import '../models/income_type.dart';

class TypeRepository {
  final List<ExpenseType> _expenseTypes = [];
  final List<IncomeType> _incomeTypes = [];
  final StreamController<void> _controller = StreamController<void>.broadcast();

  Stream<void> get onChange => _controller.stream;

  List<ExpenseType> getExpenseTypes() => List.unmodifiable(_expenseTypes);

  List<IncomeType> getIncomeTypes() => List.unmodifiable(_incomeTypes);

  void addExpenseType(ExpenseType type) {
    if (_expenseTypes.any((t) => t.name == type.name)) {
      throw ArgumentError('A type with this name already exists');
    }
    _expenseTypes.add(type);
    _controller.add(null);
  }

  void addIncomeType(IncomeType type) {
    if (_incomeTypes.any((t) => t.name == type.name)) {
      throw ArgumentError('A type with this name already exists');
    }
    _incomeTypes.add(type);
    _controller.add(null);
  }

  void dispose() {
    _controller.close();
  }
}
