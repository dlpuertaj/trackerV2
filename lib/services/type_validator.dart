import '../models/expense_type.dart';
import '../models/income_type.dart';
import '../models/validation_result.dart';

class TypeValidator {
  static ValidationResult validateExpenseType({
    required String name,
    required bool isFixed,
    double? fixedAmount,
    required List<ExpenseType> existingTypes,
  }) {
    String? nameError;
    String? amountError;

    if (name.isEmpty) {
      nameError = 'Name is required';
    } else if (existingTypes.any((t) => t.name == name)) {
      nameError = 'A type with this name already exists';
    }

    if (isFixed) {
      if (fixedAmount == null || fixedAmount <= 0) {
        amountError = 'Amount must be positive';
      }
    }

    return ValidationResult(
      nameError: nameError,
      amountError: amountError,
    );
  }

  static ValidationResult validateIncomeType({
    required String name,
    required List<IncomeType> existingTypes,
  }) {
    String? nameError;

    if (name.isEmpty) {
      nameError = 'Name is required';
    } else if (existingTypes.any((t) => t.name == name)) {
      nameError = 'A type with this name already exists';
    }

    return ValidationResult(nameError: nameError);
  }
}
