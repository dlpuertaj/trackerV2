# Quickstart: Add Income Entry

## Prerequisites

- 001-balance-overview implemented (Entry model, EntryRepository)
- Flutter SDK (latest stable)

## Setup

```bash
# Ensure existing code compiles
flutter analyze

# Run tests
flutter test
```

## Key Implementation Steps

1. **Extend `EntryRepository`** — add `addEntry()` method and
   `getIncomeTypes()` (hardcoded fallback or from 003).

2. **Create `IncomeValidator`** — pure Dart class with validation
   logic (no widget dependency).

3. **Create `IncomeForm` widget** — bottom sheet with dropdown,
   text field, text area, Save/Cancel buttons.

4. **Create `SuccessPopup` widget** — AlertDialog showing updated
   balance.

5. **Add `AddIncomeButton`** — positioned at bottom of transactions
   table (005), next to Add Expense button.

## Test Commands

```bash
# Run all tests
flutter test

# Run income-specific tests
flutter test test/services/income_validator_test.dart
flutter test test/widgets/income_form_test.dart
flutter test test/widgets/success_popup_test.dart
```

## Verification

1. Open transactions table — see "Add Income" button at bottom
2. Tap Add Income — floating form appears with type dropdown,
   amount field, description field, Save and Cancel
3. Leave type unselected, tap Save — error "Please select a type"
4. Enter amount -50, tap Save — error "Amount must be positive"
5. Select type "Salary", enter 1000, description optional — tap Save
6. Success popup shows "Income Added Successfully" with new balance
7. Dismiss popup — new entry visible in transactions table
