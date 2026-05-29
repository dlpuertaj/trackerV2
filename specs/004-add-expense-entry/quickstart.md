# Quickstart: Add Expense Entry

## Prerequisites

- 001-balance-overview implemented (Entry model, EntryRepository)
- 002-add-income-entry implemented (addEntry, form pattern)
- Flutter SDK (latest stable)

## Setup

```bash
# Ensure existing code compiles
flutter analyze

# Run tests
flutter test
```

## Key Implementation Steps

1. **Add `ExpenseType` model** (or import from 003) with `name`,
   `isFixed`, and `fixedAmount` fields.

2. **Add `getExpenseTypes()` to `EntryRepository`** — returns list of
   available expense types (from 003 or hardcoded fallback).

3. **Create `ExpenseValidator`** — pure Dart validation logic.

4. **Create `ExpenseForm` widget** — bottom sheet with type dropdown,
   amount field (auto-fills for fixed types), description text area,
   Save/Cancel buttons.

5. **Create `SuccessPopup` widget** — reuse pattern from 002.

6. **Add `AddExpenseButton`** — positioned at bottom of transactions
   table, next to Add Income button (002).

## Test Commands

```bash
flutter test
flutter test test/services/expense_validator_test.dart
flutter test test/widgets/expense_form_test.dart
flutter test test/widgets/success_popup_test.dart
```

## Verification

1. Open transactions table — see "Add Expense" button next to
   "Add Income" at the bottom
2. Tap Add Expense — floating form with type dropdown, amount,
   description, Save, Cancel
3. Select a fixed type (e.g., Rent) — amount auto-fills to 1000
4. Select a variable type (e.g., Groceries) — amount field empty
5. Leave type unselected, tap Save — error "Please select a type"
6. Enter valid data, tap Save — success popup with updated balance
