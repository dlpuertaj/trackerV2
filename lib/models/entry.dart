import 'validation_result.dart';

enum EntryType { income, expense }

class Entry {
  final String id;
  final double amount;
  final EntryType type;
  final String? description;
  final String? category;
  final DateTime date;

  Entry({
    required this.id,
    required this.amount,
    required this.type,
    this.description,
    this.category,
    DateTime? date,
  }) : date = date ?? DateTime.now();

  static ValidationResult validate({
    double? amount,
    EntryType? type,
    String? description,
  }) {
    String? amountError;
    String? typeError;
    String? descriptionError;

    if (amount == null) {
      amountError = 'Amount is required';
    } else if (amount <= 0) {
      amountError = 'Amount must be greater than zero';
    }

    if (type == null) {
      typeError = 'Type is required';
    }

    if (description != null && description.length > 200) {
      descriptionError = 'Description must be 200 characters or fewer';
    }

    return ValidationResult(
      amountError: amountError,
      typeError: typeError,
      descriptionError: descriptionError,
    );
  }
}
