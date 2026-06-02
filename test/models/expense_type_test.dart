import 'package:flutter_test/flutter_test.dart';
import 'package:money_tracker/models/expense_type.dart';

void main() {
  group('ExpenseType', () {
    test('creates expense type with all fields', () {
      final type = ExpenseType(
        name: 'Rent',
        isFixed: true,
        fixedAmount: 1000.0,
      );

      expect(type.name, 'Rent');
      expect(type.isFixed, isTrue);
      expect(type.fixedAmount, 1000.0);
    });

    test('creates expense type without fixed amount when variable', () {
      final type = ExpenseType(
        name: 'Groceries',
        isFixed: false,
      );

      expect(type.name, 'Groceries');
      expect(type.isFixed, isFalse);
      expect(type.fixedAmount, isNull);
    });
  });
}
