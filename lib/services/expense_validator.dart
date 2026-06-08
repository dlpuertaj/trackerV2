import 'package:money_tracker/models/validation_result.dart';

class ExpenseValidator {
  static ValidationResult validateExpense({
    required String? type,
    required String? amountText,
    String? description,
  }) {
    String? typeError;
    String? amountError;
    String? descriptionError;

    if (type == null || type.isEmpty) {
      typeError = 'Please select a type';
    }

    if (amountText == null || amountText.trim().isEmpty) {
      amountError = 'Amount must be positive';
    } else {
      final parsed = double.tryParse(amountText.trim());
      if (parsed == null) {
        amountError = 'Enter a valid number';
      } else if (parsed <= 0) {
        amountError = 'Amount must be positive';
      } else {
        final parts = amountText.trim().split('.');
        if (parts.length == 2 && parts[1].length > 2) {
          amountError = 'Invalid amount format';
        } else if (parsed > 999999999.99) {
          amountError = 'Amount too large';
        }
      }
    }

    if (description != null && description.length > 200) {
      descriptionError = 'Description too long';
    }

    return ValidationResult(
      typeError: typeError,
      amountError: amountError,
      descriptionError: descriptionError,
    );
  }
}
