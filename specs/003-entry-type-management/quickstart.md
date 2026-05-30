# Quickstart: Entry Type Management

## Prerequisites

- 001-balance-overview implemented
- 002-add-income-entry implemented (Add Income button)
- 004-add-expense-entry implemented (Add Expense button)
- Flutter SDK (latest stable)

## Setup

```bash
flutter analyze
flutter test
```

## Key Implementation Steps

1. **Create `ExpenseType` and `IncomeType` models** with name,
   isFixed, fixedAmount fields.

2. **Create `TypeRepository`** with in-memory storage, methods to
   add/list types, and an `onChange` stream.

3. **Create `CreateExpenseTypeForm`** — bottom sheet with name field,
   fixed toggle, conditional value field, Create/Cancel buttons.

4. **Create `CreateIncomeTypeForm`** — bottom sheet with name field,
   Create/Cancel buttons (no toggle).

5. **Update Add Expense button (004)** — wrap in `GestureDetector`
   with `onTap` (add entry) and `onLongPress` (create type).

6. **Update Add Income button (002)** — same tap-hold pattern.

7. **Update expense/income type dropdowns** in 002 and 004 to
   subscribe to `TypeRepository.onChange` for live updates.

## Test Commands

```bash
flutter test
flutter test test/services/type_repository_test.dart
flutter test test/widgets/create_expense_type_form_test.dart
flutter test test/widgets/create_income_type_form_test.dart
```

## Verification

1. Open transactions table — see Add Income and Add Expense buttons
2. Short-tap Add Expense — opens expense entry form (004)
3. Tap-hold Add Expense — opens expense type creation form with name,
   toggle, value field (when toggled), Create, Cancel
4. Enter name "Rent", toggle Fixed ON, enter 1000, tap Create
5. Type saved — short-tap Add Expense again — "Rent" is in the dropdown
6. Tap-hold Add Income — opens income type creation form (name only)
7. Enter "Freelance", tap Create — available in income dropdown
8. Duplicate name shows error. Blank name shows error.
