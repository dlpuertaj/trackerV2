import 'package:flutter_test/flutter_test.dart';
import 'package:money_tracker/models/expense_type.dart';
import 'package:money_tracker/models/income_type.dart';
import 'package:money_tracker/services/type_repository.dart';
import 'package:money_tracker/services/type_validator.dart';

void main() {
  group('ExpenseTypeValidator', () {
    late TypeRepository repository;

    setUp(() {
      repository = TypeRepository();
    });

    test('returns valid for valid expense type', () {
      final result = TypeValidator.validateExpenseType(
        name: 'Rent',
        isFixed: true,
        fixedAmount: 1000.0,
        existingTypes: repository.getExpenseTypes(),
      );

      expect(result.isValid, isTrue);
    });

    test('returns invalid when name is empty', () {
      final result = TypeValidator.validateExpenseType(
        name: '',
        isFixed: false,
        existingTypes: repository.getExpenseTypes(),
      );

      expect(result.isValid, isFalse);
      expect(result.nameError, isNotNull);
    });

    test('returns invalid when name is duplicate', () {
      repository.addExpenseType(ExpenseType(name: 'Rent', isFixed: true, fixedAmount: 1000.0));

      final result = TypeValidator.validateExpenseType(
        name: 'Rent',
        isFixed: false,
        existingTypes: repository.getExpenseTypes(),
      );

      expect(result.isValid, isFalse);
      expect(result.nameError, contains('already exists'));
    });

    test('returns invalid when fixed amount is zero', () {
      final result = TypeValidator.validateExpenseType(
        name: 'Rent',
        isFixed: true,
        fixedAmount: 0.0,
        existingTypes: repository.getExpenseTypes(),
      );

      expect(result.isValid, isFalse);
      expect(result.amountError, isNotNull);
    });

    test('returns invalid when fixed amount is negative', () {
      final result = TypeValidator.validateExpenseType(
        name: 'Rent',
        isFixed: true,
        fixedAmount: -100.0,
        existingTypes: repository.getExpenseTypes(),
      );

      expect(result.isValid, isFalse);
      expect(result.amountError, isNotNull);
    });

    test('returns valid when isFixed is false and amount is null', () {
      final result = TypeValidator.validateExpenseType(
        name: 'Rent',
        isFixed: false,
        fixedAmount: null,
        existingTypes: repository.getExpenseTypes(),
      );

      expect(result.isValid, isTrue);
    });
  });

  group('IncomeTypeValidator', () {
    late TypeRepository repository;

    setUp(() {
      repository = TypeRepository();
    });

    test('returns valid for valid income type', () {
      final result = TypeValidator.validateIncomeType(
        name: 'Salary',
        existingTypes: repository.getIncomeTypes(),
      );

      expect(result.isValid, isTrue);
    });

    test('returns invalid when name is empty', () {
      final result = TypeValidator.validateIncomeType(
        name: '',
        existingTypes: repository.getIncomeTypes(),
      );

      expect(result.isValid, isFalse);
      expect(result.nameError, isNotNull);
    });

    test('returns invalid when name is duplicate', () {
      repository.addIncomeType(IncomeType(name: 'Salary'));

      final result = TypeValidator.validateIncomeType(
        name: 'Salary',
        existingTypes: repository.getIncomeTypes(),
      );

      expect(result.isValid, isFalse);
      expect(result.nameError, contains('already exists'));
    });
  });
}
