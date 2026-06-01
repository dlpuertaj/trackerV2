import 'package:flutter_test/flutter_test.dart';
import 'package:money_tracker/models/validation_result.dart';

void main() {
  group('ValidationResult', () {
    test('isValid is true when no errors', () {
      final result = ValidationResult();
      expect(result.isValid, true);
    });

    test('isValid is false when typeError is set', () {
      final result = ValidationResult(typeError: 'Please select a type');
      expect(result.isValid, false);
    });

    test('isValid is false when amountError is set', () {
      final result = ValidationResult(amountError: 'Amount must be positive');
      expect(result.isValid, false);
    });

    test('isValid is false when descriptionError is set', () {
      final result = ValidationResult(descriptionError: 'Description too long');
      expect(result.isValid, false);
    });

    test('isValid is false when nameError is set', () {
      final result = ValidationResult(nameError: 'Name is required');
      expect(result.isValid, false);
    });

    test('error fields are nullable and default to null', () {
      final result = ValidationResult();
      expect(result.typeError, isNull);
      expect(result.amountError, isNull);
      expect(result.descriptionError, isNull);
      expect(result.nameError, isNull);
    });
  });
}
