# Data Model: Entry Type Management

## Entity: ExpenseType

| Field         | Type      | Required | Notes                                      |
|---------------|-----------|----------|--------------------------------------------|
| `name`        | String    | Yes      | Unique within expense types, max 50 chars  |
| `isFixed`     | bool      | Yes      | true = fixed amount, false = variable      |
| `fixedAmount` | double?   | No       | Null if isFixed == false; > 0 if set       |

## Entity: IncomeType

| Field  | Type      | Required | Notes                                  |
|--------|-----------|----------|----------------------------------------|
| `name` | String    | Yes      | Unique within income types, max 50 chars |

## Validation Rules

### ExpenseType
| Rule                              | Error Message                     |
|-----------------------------------|-----------------------------------|
| name must not be empty            | "Name is required"                |
| name must be unique among expense types | "A type with this name already exists" |
| if isFixed, fixedAmount > 0       | "Amount must be positive"         |
| fixedAmount max 2 decimal places  | "Invalid amount format"           |

### IncomeType
| Rule                              | Error Message                     |
|-----------------------------------|-----------------------------------|
| name must not be empty            | "Name is required"                |
| name must be unique among income types | "A type with this name already exists" |

## TypeRepository Contract

```dart
class TypeRepository {
  // Expense types
  List<ExpenseType> getExpenseTypes();
  void addExpenseType(ExpenseType type);

  // Income types
  List<IncomeType> getIncomeTypes();
  void addIncomeType(IncomeType type);

  // Reactivity
  Stream<void> get onChange;
}
```

## Data Flow

```
User tap-holds "Add Expense" button
  → onLongPress fires (not onTap)
  → CreateExpenseTypeForm opens as bottom sheet
  → User enters name
  → If isFixed toggle ON: user enters fixed amount
  → User taps Create
  → Validator checks
  → typeRepository.addExpenseType(type)
  → typeRepository.onChange fires
  → Expense type dropdown in 004 rebuilds with new type
  → Form closes

User tap-holds "Add Income" button
  → Same flow but for income types
  → Income type dropdown in 002 rebuilds
```
