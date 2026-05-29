# Contracts: Add Expense Entry

## EntryRepository Contract

Extends the shared contract with expense type lookup.

```dart
abstract class EntryRepository {
  // Read (from 001)
  List<Entry> getAllEntries();
  List<Entry> getEntriesByType(EntryType type);
  Stream<void> get onChange;

  // Write (from 002)
  void addEntry(Entry entry);

  // Expense types (shared from 003)
  List<ExpenseType> getExpenseTypes();
}

class ExpenseType {
  final String name;
  final bool isFixed;
  final double? fixedAmount;
}
```

## Expense Form Contract

```dart
class ExpenseFormData {
  final String? type;        // Selected expense type name
  final double? amount;      // Parsed amount (auto-filled for fixed)
  final String? description; // Optional description text
}

Future<ExpenseFormData?> showExpenseForm(BuildContext context);

ValidationResult validate(ExpenseFormData data);

class ValidationResult {
  final bool isValid;
  final String? typeError;
  final String? amountError;
}
```

## Success Popup Contract

```dart
Future<void> showSuccessPopup(BuildContext context, {
  required double updatedBalance,
});
```
