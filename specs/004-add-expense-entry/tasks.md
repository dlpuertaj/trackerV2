# Tasks: Add Expense Entry (004)

**Input**: Design documents from `specs/004-add-expense-entry/`

**Tests**: Per Constitution Principle I (TDD is Non-Negotiable), tests are MANDATORY.
Tests MUST be written first and MUST fail before any implementation code is written.

---

## Phase 1: Setup

- [X] T001 Run `flutter analyze` to confirm project compiles
- [X] T002 Run `flutter test` to confirm existing tests pass

---

## Phase 2: Foundational (Validator + Repository Extension)

**Purpose**: Validation logic and expense type lookup shared by all expense stories.

### Tests (write first, must fail)

- [X] T003 [P] Write unit test for `ExpenseValidator` in `test/services/expense_validator_test.dart` — verify all rules: type required, amount > 0, max 2 decimal places, description ≤ 200 chars
- [X] T004 [P] Write unit test for `EntryRepository.getExpenseTypes()` in `test/services/entry_repository_test.dart` — verify hardcoded fallback list with fixed types (e.g., Rent $1000) and variable types (e.g., Groceries)

### Implementation

- [X] T005 Implement `ExpenseValidator` in `lib/services/expense_validator.dart` — pure Dart class with `validate(ExpenseFormData)` returning `ValidationResult`
- [X] T006 Extend `EntryRepository` in `lib/services/entry_repository.dart` — add `getExpenseTypes()` returning hardcoded fallback list (Rent/Fixed 1000, Groceries/Variable, Utilities/Variable)

**Checkpoint**: `flutter test` passes for all validator + repository tests

---

## Phase 3: User Story 1 — Add a Variable Expense Entry via Floating Form (P1) 🎯 MVP

**Goal**: Tap "Add Expense" → bottom sheet with type dropdown, amount field, optional description, Save/Cancel. Variable types leave amount empty. Save validates, persists, shows success popup.

**Independent Test**: Balance 500. Select Groceries (variable), enter 50, enter "Weekly shop", Save. Popup shows "Expense added successfully" with balance 450. Entry visible in table.

### Tests (write first, must fail)

- [X] T007 [P] [US1] Write widget test for `ExpenseForm` render in `test/widgets/expense_form_test.dart` — verify form renders with type dropdown, amount field, description field, Save/Cancel buttons
- [X] T008 [P] [US1] Write widget test for form validation in `test/widgets/expense_form_test.dart` — verify "Please select a type" and "Amount must be positive" errors on Save with invalid data
- [X] T009 [P] [US1] Write widget test for variable type save flow in `test/widgets/expense_form_test.dart` — verify valid data calls `addEntry`, returns form data, success popup shows
- [X] T010 [P] [US1] Write widget test for `SuccessPopup` in `test/widgets/success_popup_test.dart` — verify dialog shows "Expense added successfully" and updated balance with dismiss button
- [X] T011 [P] [US1] Write widget test for `AddExpenseButton` in `test/widgets/add_expense_button_test.dart` — verify tap opens `ExpenseForm`

### Implementation

- [X] T012 [US1] Implement `ExpenseForm` in `lib/widgets/expense_form.dart` — `showModalBottomSheet` with `DropdownButton` for types, `TextField` for amount, `TextField` for description (optional), Save/Cancel buttons, calls `ExpenseValidator` on Save
- [X] T013 [US1] Implement `SuccessPopup` in `lib/widgets/success_popup.dart` — `AlertDialog` with title "Expense Added Successfully", body showing formatted updated balance, "OK" dismiss button
- [X] T014 [US1] Implement `AddExpenseButton` in `lib/widgets/add_expense_button.dart` — `ElevatedButton` that opens `ExpenseForm`, wires Save to `EntryRepository.addEntry()`, shows `SuccessPopup` on completion

**Checkpoint**: `flutter test` passes. Variable expense flow works end-to-end with validation and success popup.

---

## Phase 4: User Story 2 — Add a Fixed Expense Entry (P2)

**Goal**: Selecting a fixed expense type (e.g., Rent $1000) auto-fills the amount field. Amount is pre-filled but editable.

**Independent Test**: Balance 1500. Select Rent (fixed $1000). Amount field pre-filled with 1000. Add description "Monthly rent", tap Save. Popup shows balance 500.

### Tests (write first, must fail)

- [X] T015 [P] [US2] Write widget test for fixed type auto-fill in `test/widgets/expense_form_test.dart` — verify selecting a fixed type pre-fills the amount field with the type's `fixedAmount`
- [X] T016 [P] [US2] Write widget test for fixed type editable amount in `test/widgets/expense_form_test.dart` — verify pre-filled amount can be overridden by user

### Implementation

- [X] T017 [US2] Add fixed-type auto-fill to `ExpenseForm` in `lib/widgets/expense_form.dart` — `onChanged` handler on the type dropdown checks `isFixed` and pre-fills amount `TextEditingController` with `fixedAmount.toString()`

**Checkpoint**: `flutter test` passes. Selecting a fixed type auto-fills amount; amount field remains editable.

---

## Phase 5: User Story 3 — Cancel Adding an Expense (P3)

**Goal**: Tapping Cancel closes the form without saving. Balance unchanged.

**Independent Test**: Open form, select type, enter data, tap Cancel. Form closes. No entry saved. Balance unchanged.

### Tests (write first, must fail)

- [X] T018 [US3] Write widget test for Cancel flow in `test/widgets/expense_form_test.dart` — verify tapping Cancel closes form, returns `null`, no entry saved

### Implementation

- [X] T019 [US3] Cancel is already handled by the `ExpenseForm` widget (Cancel button calls `Navigator.pop(context, null)`) — verify implementation is correct

**Checkpoint**: `flutter test` passes. Cancel closes form without saving.

---

## Phase 6: Polish

- [X] T020 Run `flutter analyze` — zero errors and warnings
- [X] T021 Run `flutter test` — all 130+ tests pass

---

## Dependencies & Execution Order

```
Phase 1        Phase 2                  Phase 3                           Phase 4      Phase 5      Phase 6
T001 ──→ T003 ──→ T005 ──→ T007 ──→ T012 ──→ T015 ──→ T017 ──→ T018 ──→ T019 ──→ T020
T002     T004     T006     T008     T013     T016               (optional)     T021
                          T009     T014
                          T010
                          T011
```

### Phase Dependencies
- **Phase 1**: No dependencies
- **Phase 2**: Depends on Phase 1 — blocks all stories
- **Phase 3 (US1)**: Depends on Phases 1–2
- **Phase 4 (US2)**: Depends on Phase 3 (adds auto-fill to the existing form)
- **Phase 5 (US3)**: Depends on Phase 3 (tests cancel on the existing form)
- **Phase 6**: Depends on Phases 3–5

### User Story Dependencies
- **US1 (P1)**: Core form — no dependencies on other stories
- **US2 (P2)**: Depends on US1 form existing
- **US3 (P3)**: Depends on US1 form existing

### Parallel Opportunities
- T003, T004: foundational tests in parallel
- T007, T008, T009, T010, T011: US1 widget tests all [P]
- T012, T013, T014: US1 implementation all [P] (different files)
- T015, T016: US2 tests in parallel

---

## Parallel Example: User Story 1

```bash
# Write all US1 widget tests in parallel:
Task: "Write widget test for ExpenseForm render in test/widgets/expense_form_test.dart"
Task: "Write widget test for form validation in test/widgets/expense_form_test.dart"
Task: "Write widget test for variable type save flow in test/widgets/expense_form_test.dart"
Task: "Write widget test for SuccessPopup in test/widgets/success_popup_test.dart"
Task: "Write widget test for AddExpenseButton in test/widgets/add_expense_button_test.dart"
```

---

## Implementation Strategy

### MVP (User Story 1 Only)
1. Phase 1: Verify project
2. Phase 2: ExpenseValidator + repository extension
3. Phase 3: ExpenseForm (variable) + AddExpenseButton + SuccessPopup
4. **STOP and VALIDATE**: Variable expense flow works end-to-end

### Incremental Delivery
1. MVP: Variable expense creation (US1)
2. Add fixed-type auto-fill (US2) — small delta on the same form
3. Cancel flow (US3) — already built from US1, just verified explicitly

### Shared Widget Note
US1, US2, and US3 all share the same `ExpenseForm` widget. US1 builds the core form. US2 adds the auto-fill behavior on type selection. US3 verifies the Cancel button. All tests live in `test/widgets/expense_form_test.dart`.
