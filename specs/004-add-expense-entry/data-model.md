# Data Model: Add Expense Entry

## Entity: Entry (Extended)

Reuses the shared Entry from 001-balance-overview. No new fields.

| Field         | Type      | Required | Source                             |
|---------------|-----------|----------|------------------------------------|
| `id`          | String    | Yes      | Auto-generated UUID                |
| `amount`      | double    | Yes      | User input (variable) or auto-filled (fixed) |
| `type`        | EntryType | Yes      | Always `expense` for this feature  |
| `description` | String    | No       | User input (optional, max 200)     |
| `category`    | String    | No       | Selected expense type name         |
| `date`        | DateTime  | Yes      | Auto-set to current time           |

## Expense Type Model

```dart
class ExpenseType {
  final String name;
  final bool isFixed;        // true = fixed amount, false = variable
  final double? fixedAmount; // Only non-null if isFixed == true
}
```

## Validation Rules

| Field       | Rule                                  | Error Message                 |
|-------------|---------------------------------------|-------------------------------|
| type        | Must select a type                    | "Please select a type"        |
| amount      | Must be a positive number > 0         | "Amount must be positive"     |
| amount      | Must have at most 2 decimal places    | "Invalid amount format"       |
| amount      | Must be a valid number                | "Enter a valid number"        |
| desc        | Must not exceed 200 characters        | "Description too long"        |

## Repository Extension

```dart
abstract class EntryRepository {
  // Existing (from 001, 002)
  List<Entry> getAllEntries();
  List<Entry> getEntriesByType(EntryType type);
  Stream<void> get onChange;
  void addEntry(Entry entry);

  // Added or read from shared store
  List<ExpenseType> getExpenseTypes();
}
```

## Data Flow

```
User taps "Add Expense" button
  → Bottom sheet opens with expense form
  → User selects type from dropdown
  → If type.isFixed: amount auto-filled with type.fixedAmount
  → If type.variable: amount field empty
  → User optionally enters description
  → User taps Save
  → Validator checks type + amount
  → If invalid: show inline errors
  → If valid: repository.addEntry(entry)
  → Balance updates (001 listens to onChange)
  → Transactions table updates (005 listens to onChange)
  → Success popup shows "Expense added successfully" with balance
```
