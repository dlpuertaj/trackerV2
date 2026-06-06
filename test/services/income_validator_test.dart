import 'package:flutter_test/flutter_test.dart';
import 'package:money_tracker/services/income_validator.dart';

void main() {
  group('IncomeValidator', () {
    test('returns valid for complete valid input', () {
      final result = IncomeValidator.validateIncome(
        type: 'Salary',
        amountText: '5000.00',
        description: 'Monthly pay',
      );

      expect(result.isValid, isTrue);
      expect(result.typeError, isNull);
      expect(result.amountError, isNull);
      expect(result.descriptionError, isNull);
    });

    test('returns valid without description', () {
      final result = IncomeValidator.validateIncome(
        type: 'Salary',
        amountText: '100',
      );

      expect(result.isValid, isTrue);
    });

    test('returns typeError when type is null', () {
      final result = IncomeValidator.validateIncome(
        type: null,
        amountText: '100',
      );

      expect(result.isValid, isFalse);
      expect(result.typeError, 'Please select a type');
    });

    test('returns typeError when type is empty', () {
      final result = IncomeValidator.validateIncome(
        type: '',
        amountText: '100',
      );

      expect(result.isValid, isFalse);
      expect(result.typeError, 'Please select a type');
    });

    test('returns amountError when amount is null', () {
      final result = IncomeValidator.validateIncome(
        type: 'Salary',
        amountText: null,
      );

      expect(result.isValid, isFalse);
      expect(result.amountError, 'Amount must be positive');
    });

    test('returns amountError when amount is empty', () {
      final result = IncomeValidator.validateIncome(
        type: 'Salary',
        amountText: '',
      );

      expect(result.isValid, isFalse);
      expect(result.amountError, 'Amount must be positive');
    });

    test('returns amountError when amount is zero', () {
      final result = IncomeValidator.validateIncome(
        type: 'Salary',
        amountText: '0',
      );

      expect(result.isValid, isFalse);
      expect(result.amountError, 'Amount must be positive');
    });

    test('returns amountError when amount is negative', () {
      final result = IncomeValidator.validateIncome(
        type: 'Salary',
        amountText: '-50',
      );

      expect(result.isValid, isFalse);
      expect(result.amountError, 'Amount must be positive');
    });

    test('returns amountError when amount has more than 2 decimal places', () {
      final result = IncomeValidator.validateIncome(
        type: 'Salary',
        amountText: '50.123',
      );

      expect(result.isValid, isFalse);
      expect(result.amountError, 'Invalid amount format');
    });

    test('returns amountError when amount exceeds max', () {
      final result = IncomeValidator.validateIncome(
        type: 'Salary',
        amountText: '1000000000',
      );

      expect(result.isValid, isFalse);
      expect(result.amountError, 'Amount too large');
    });

    test('returns descriptionError when description exceeds 200 chars', () {
      final longDesc = 'a' * 201;

      final result = IncomeValidator.validateIncome(
        type: 'Salary',
        amountText: '100',
        description: longDesc,
      );

      expect(result.isValid, isFalse);
      expect(result.descriptionError, 'Description too long');
    });

    test('accepts description of exactly 200 chars', () {
      final longDesc = 'a' * 200;

      final result = IncomeValidator.validateIncome(
        type: 'Salary',
        amountText: '100',
        description: longDesc,
      );

      expect(result.isValid, isTrue);
      expect(result.descriptionError, isNull);
    });

    test('returns amountError for non-numeric text', () {
      final result = IncomeValidator.validateIncome(
        type: 'Salary',
        amountText: 'abc',
      );

      expect(result.isValid, isFalse);
      expect(result.amountError, 'Enter a valid number');
    });

    test('returns multiple errors when both type and amount are invalid', () {
      final result = IncomeValidator.validateIncome(
        type: null,
        amountText: '0',
      );

      expect(result.isValid, isFalse);
      expect(result.typeError, isNotNull);
      expect(result.amountError, isNotNull);
    });
  });
}
