import 'package:flutter_test/flutter_test.dart';
import 'package:money_tracker/services/expense_validator.dart';

void main() {
  group('ExpenseValidator', () {
    test('returns valid for complete valid input', () {
      final result = ExpenseValidator.validateExpense(
        type: 'Groceries',
        amountText: '50.00',
        description: 'Weekly shop',
      );

      expect(result.isValid, isTrue);
      expect(result.typeError, isNull);
      expect(result.amountError, isNull);
      expect(result.descriptionError, isNull);
    });

    test('returns valid without description', () {
      final result = ExpenseValidator.validateExpense(
        type: 'Groceries',
        amountText: '100',
      );

      expect(result.isValid, isTrue);
    });

    test('returns typeError when type is null', () {
      final result = ExpenseValidator.validateExpense(
        type: null,
        amountText: '100',
      );

      expect(result.isValid, isFalse);
      expect(result.typeError, 'Please select a type');
    });

    test('returns typeError when type is empty', () {
      final result = ExpenseValidator.validateExpense(
        type: '',
        amountText: '100',
      );

      expect(result.isValid, isFalse);
      expect(result.typeError, 'Please select a type');
    });

    test('returns amountError when amount is null', () {
      final result = ExpenseValidator.validateExpense(
        type: 'Groceries',
        amountText: null,
      );

      expect(result.isValid, isFalse);
      expect(result.amountError, 'Amount must be positive');
    });

    test('returns amountError when amount is empty', () {
      final result = ExpenseValidator.validateExpense(
        type: 'Groceries',
        amountText: '',
      );

      expect(result.isValid, isFalse);
      expect(result.amountError, 'Amount must be positive');
    });

    test('returns amountError when amount is zero', () {
      final result = ExpenseValidator.validateExpense(
        type: 'Groceries',
        amountText: '0',
      );

      expect(result.isValid, isFalse);
      expect(result.amountError, 'Amount must be positive');
    });

    test('returns amountError when amount is negative', () {
      final result = ExpenseValidator.validateExpense(
        type: 'Groceries',
        amountText: '-50',
      );

      expect(result.isValid, isFalse);
      expect(result.amountError, 'Amount must be positive');
    });

    test('returns amountError when amount has more than 2 decimal places',
        () {
      final result = ExpenseValidator.validateExpense(
        type: 'Groceries',
        amountText: '50.123',
      );

      expect(result.isValid, isFalse);
      expect(result.amountError, 'Invalid amount format');
    });

    test('returns descriptionError when description exceeds 200 chars', () {
      final longDesc = 'a' * 201;

      final result = ExpenseValidator.validateExpense(
        type: 'Groceries',
        amountText: '100',
        description: longDesc,
      );

      expect(result.isValid, isFalse);
      expect(result.descriptionError, 'Description too long');
    });

    test('accepts description of exactly 200 chars', () {
      final longDesc = 'a' * 200;

      final result = ExpenseValidator.validateExpense(
        type: 'Groceries',
        amountText: '100',
        description: longDesc,
      );

      expect(result.isValid, isTrue);
      expect(result.descriptionError, isNull);
    });

    test('returns amountError for non-numeric text', () {
      final result = ExpenseValidator.validateExpense(
        type: 'Groceries',
        amountText: 'abc',
      );

      expect(result.isValid, isFalse);
      expect(result.amountError, 'Enter a valid number');
    });

    test('returns multiple errors when both type and amount are invalid', () {
      final result = ExpenseValidator.validateExpense(
        type: null,
        amountText: '0',
      );

      expect(result.isValid, isFalse);
      expect(result.typeError, isNotNull);
      expect(result.amountError, isNotNull);
    });
  });
}
