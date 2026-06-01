# Tasks: Entry Type Management (003)

**Input**: Design documents from `specs/003-entry-type-management/`

**Tests**: Per Constitution Principle I (TDD is Non-Negotiable), tests are MANDATORY.
Tests MUST be written first and MUST fail before any implementation code is written.

---

## Phase 1: Setup

- [ ] T001 Run `flutter analyze` to confirm project compiles
- [ ] T002 Run `flutter test` to confirm existing tests pass

---

## Phase 2: Foundational (Models + Repository)

**Purpose**: Data layer shared by both income and expense type forms.

### Tests (write first, must fail)

- [ ] T003 [P] Write unit test for `ExpenseType` model in `test/models/expense_type_test.dart` — verify fields `name`, `isFixed`, `fixedAmount`, validation rules
- [ ] T004 [P] Write unit test for `IncomeType` model in `test/models/income_type_test.dart` — verify fields `name`, validation rules
- [ ] T005 [P] Write unit test for `TypeRepository` in `test/services/type_repository_test.dart` — verify `getExpenseTypes()`, `getIncomeTypes()`, `addExpenseType()`, `addIncomeType()`, duplicate rejection, `onChange` stream
- [ ] T006 [P] Write unit test for expense type validator in `test/services/type_validator_test.dart` — verify empty name, duplicate name, zero/negative amount, invalid decimal
- [ ] T007 [P] Write unit test for income type validator in `test/services/type_validator_test.dart` — verify empty name, duplicate name

### Implementation

- [ ] T008 Implement `ExpenseType` model in `lib/models/expense_type.dart` — `name`, `isFixed`, `fixedAmount`
- [ ] T009 Implement `IncomeType` model in `lib/models/income_type.dart` — `name`
- [ ] T010 Implement `TypeRepository` in `lib/services/type_repository.dart` — in-memory store with add/list for both types, uniqueness check, `onChange` stream
- [ ] T011 Implement type validators in `lib/services/type_validator.dart` — pure Dart functions returning `ValidationResult` with field-level errors

**Checkpoint**: `flutter test` passes for all model + repository + validator tests

---

## Phase 3: User Story 1 — Create Expense Type via Tap-Hold (P1) 🎯 MVP

**Goal**: Tap-hold Add Expense button → floating form with name field, Fixed toggle, conditional value field, Create/Cancel buttons.

**Independent Test**: Tap-hold Add Expense, enter "Rent", toggle Fixed on, enter 1000, tap Create. "Rent" appears in expense type dropdown. Tap-hold then Cancel → no type created.

### Tests (write first, must fail)

- [ ] T012 [P] [US1] Write widget test for `CreateExpenseTypeForm` in `test/widgets/create_expense_type_form_test.dart` — verify form renders with name field, toggle, value field (hidden when toggle off)
- [ ] T013 [P] [US1] Write widget test for create flow in `test/widgets/create_expense_type_form_test.dart` — verify Create button saves type, Cancel discards
- [ ] T014 [P] [US1] Write widget test for validation in `test/widgets/create_expense_type_form_test.dart` — verify blank name shows error, duplicate shows error, invalid amount shows error

### Implementation

- [ ] T015 [US1] Implement `CreateExpenseTypeForm` in `lib/widgets/create_expense_type_form.dart` — `showModalBottomSheet` with name `TextField`, `Switch` for fixed, conditional `TextField` for amount, Create/Cancel buttons, client-side validation before save
- [ ] T016 [US1] Implement `AddExpenseButton` wrapper in `lib/widgets/add_expense_button.dart` — `GestureDetector` with `onTap` (delegates to 004's add-expense form) and `onLongPress` (opens `CreateExpenseTypeForm`)

**Checkpoint**: `flutter test` passes. Tap-hold Add Expense → form with toggle; Create saves type; Cancel discards; validation works.

---

## Phase 4: User Story 2 — Create Income Type via Tap-Hold (P2)

**Goal**: Tap-hold Add Income button → floating form with name field, Create/Cancel buttons. No toggle or value field.

**Independent Test**: Tap-hold Add Income, enter "Freelance", tap Create. "Freelance" appears in income type dropdown. Cancel → no type created.

### Tests (write first, must fail)

- [ ] T017 [P] [US2] Write widget test for `CreateIncomeTypeForm` in `test/widgets/create_income_type_form_test.dart` — verify form renders with name field only (no toggle/value)
- [ ] T018 [P] [US2] Write widget test for create flow in `test/widgets/create_income_type_form_test.dart` — verify Create saves, Cancel discards, validation errors appear

### Implementation

- [ ] T019 [US2] Implement `CreateIncomeTypeForm` in `lib/widgets/create_income_type_form.dart` — `showModalBottomSheet` with name `TextField`, Create/Cancel buttons, client-side validation
- [ ] T020 [US2] Implement `AddIncomeButton` wrapper in `lib/widgets/add_income_button.dart` — `GestureDetector` with `onTap` (delegates to 002's add-income form) and `onLongPress` (opens `CreateIncomeTypeForm`)

**Checkpoint**: `flutter test` passes. Both tap-hold flows work; both Create and Cancel behave correctly; duplicates rejected.

---

## Phase 5: Polish

- [ ] T021 Run `flutter analyze` — zero errors and warnings
- [ ] T022 Run `flutter test` — all 15+ tests pass

---

## Dependencies & Execution Order

```
Phase 1        Phase 2                   Phase 3             Phase 4        Phase 5
T001 ──→ T003 ──→ T008 ──→ T012 ──→ T015 ──→ T017 ──→ T019 ──→ T021
T002     T004     T009     T013     T016     T018     T020     T022
         T005     T010     T014
         T006     T011
         T007
```

### Phase Dependencies
- **Phase 1**: No dependencies
- **Phase 2**: Depends on Phase 1 — blocks both stories
- **Phase 3 (US1)**: Depends on Phases 1–2
- **Phase 4 (US2)**: Depends on Phases 1–2 (can start after Phase 2, no dependency on US1)
- **Phase 5**: Depends on Phases 3–4

### User Story Dependencies
- **US1 (P1)**: Can start after Phase 2 — no dependency on US2
- **US2 (P2)**: Can start after Phase 2 — no dependency on US1

### Parallel Opportunities
- T003, T004, T005, T006, T007: all [P], write in parallel
- T008, T009, T010, T011: all [P], implement in parallel
- T012, T013, T014: US1 widget tests in parallel
- T017, T018: US2 widget tests in parallel
- Phases 3 and 4 can proceed in parallel (different files, no dependencies between them)

---

## Parallel Example: Foundational Phase

```bash
# Write all foundational tests in parallel:
Task: "Write unit test for ExpenseType model in test/models/expense_type_test.dart"
Task: "Write unit test for IncomeType model in test/models/income_type_test.dart"
Task: "Write unit test for TypeRepository in test/services/type_repository_test.dart"
Task: "Write unit test for expense type validator in test/services/type_validator_test.dart"
Task: "Write unit test for income type validator in test/services/type_validator_test.dart"
```

## Parallel Example: User Story 1

```bash
# Write all US1 tests in parallel:
Task: "Write widget test for CreateExpenseTypeForm in test/widgets/create_expense_type_form_test.dart"
Task: "Write widget test for create flow in test/widgets/create_expense_type_form_test.dart"
Task: "Write widget test for validation in test/widgets/create_expense_type_form_test.dart"
```

---

## Implementation Strategy

### MVP (User Story 1 Only)
1. Phase 1: Verify project
2. Phase 2: Models + Repository + Validators
3. Phase 3: CreateExpenseTypeForm + AddExpenseButton wrapper
4. **STOP and VALIDATE**: Expense type form works with toggle, validation, Create/Cancel

### Incremental Delivery
1. MVP: Expense type creation (US1)
2. Add income type creation (US2)
3. Both share the same TypeRepository; each increment independently testable

### Integration Note
The `AddExpenseButton` and `AddIncomeButton` wrappers use `GestureDetector` with `onTap` and `onLongPress`. The `onTap` callbacks delegate to the actual add-entry forms from 002 and 004 — those callbacks can be injected via constructor or a callback prop, keeping the button widgets decoupled from the form implementations.
