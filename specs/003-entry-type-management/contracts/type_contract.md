# Contracts: Entry Type Management

## TypeRepository Contract

Shared type store consumed by 002 (Add Income) and 004 (Add Expense).

```dart
abstract class TypeRepository {
  List<ExpenseType> getExpenseTypes();
  List<IncomeType> getIncomeTypes();
  void addExpenseType(ExpenseType type);
  void addIncomeType(IncomeType type);
  Stream<void> get onChange;
}
```

## Expense Type Form Contract

```dart
class ExpenseTypeFormData {
  final String name;
  final bool isFixed;
  final double? fixedAmount; // Non-null only if isFixed == true
}

/// Returns the created type data if saved, or null if cancelled.
Future<ExpenseType?> showCreateExpenseTypeForm(BuildContext context);

ValidationResult validate(ExpenseTypeFormData data);

class ValidationResult {
  final bool isValid;
  final String? nameError;
  final String? amountError;
}
```

## Income Type Form Contract

```dart
class IncomeTypeFormData {
  final String name;
}

Future<IncomeType?> showCreateIncomeTypeForm(BuildContext context);

ValidationResult validate(IncomeTypeFormData data);

class ValidationResult {
  final bool isValid;
  final String? nameError;
}
```

## Button Gesture Contract

```dart
// In the Add Expense / Add Income button widgets (002, 004):
// onTap → opens the respective add-entry form
// onLongPress → opens the respective create-type form

Widget build(BuildContext context) {
  return GestureDetector(
    onTap: () => showExpenseForm(context),
    onLongPress: () => showCreateExpenseTypeForm(context),
    child: ... // Button UI
  );
}
```
