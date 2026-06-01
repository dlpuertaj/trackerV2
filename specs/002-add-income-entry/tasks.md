# Tasks: Add Income Entry (002)

**Input**: Design documents from `specs/002-add-income-entry/`

**Tests**: Per Constitution Principle I (TDD is Non-Negotiable), tests are MANDATORY.
Tests MUST be written first and MUST fail before any implementation code is written.

---

## Phase 1: Setup

- [ ] T001 Run `flutter analyze` to confirm project compiles
- [ ] T002 Run `flutter test` to confirm existing tests pass

---

## Phase 2: Foundational (Repository Extension + Validator)

**Purpose**: Extend `EntryRepository` with write capability. Create pure-Dart `IncomeValidator`.

### Tests (write first, must fail)

- [ ] T003 [P] Write unit test for `EntryRepository.addEntry()` in `test/services/entry_repository_test.dart` — verify entry is stored, id auto-generated if null, date auto-set if null, `onChange` fires
- [ ] T004 [P] Write unit test for `EntryRepository.getIncomeTypes()` in `test/services/entry_repository_test.dart` — verify hardcoded fallback list: Salary, Loan, Investment, Gift, Other
- [ ] T005 [P] Write unit test for `IncomeValidator` in `test/services/income_validator_test.dart` — verify all validation rules: type required, amount > 0, max 2 decimal places, max 999999999.99, description ≤ 200 chars

### Implementation

- [ ] T006 Extend `EntryRepository` in `lib/services/entry_repository.dart` — add `addEntry()` (auto-generates id, sets date, stores, fires `onChange`) and `getIncomeTypes()` (returns hardcoded fallback list)
- [ ] T007 Implement `IncomeValidator` in `lib/services/income_validator.dart` — pure Dart class with `validate(IncomeFormData)` returning `ValidationResult` with field-level errors

**Checkpoint**: `flutter test` passes for all repository + validator tests

---

## Phase 3: User Story 1 — Add a New Income Entry via Floating Form (P1) 🎯 MVP

**Goal**: Tap "Add Income" button → floating bottom sheet with type dropdown, amount field, optional description, Save/Cancel. On save: validate, persist, show success popup with updated balance.

**Independent Test**: Starting balance 0. Select "Salary", enter 500, enter "Monthly pay", tap Save. Popup shows "Income added successfully" with balance 500. Dismiss → new entry visible in table.

### Tests (write first, must fail)

- [ ] T008 [P] [US1] Write widget test for `IncomeForm` in `test/widgets/income_form_test.dart` — verify form renders with type dropdown, amount field, description field, Save/Cancel buttons
- [ ] T009 [P] [US1] Write widget test for form validation in `test/widgets/income_form_test.dart` — verify "Please select a type" and "Amount must be positive" errors on Save with invalid data
- [ ] T010 [P] [US1] Write widget test for save flow in `test/widgets/income_form_test.dart` — verify valid data calls `addEntry` and returns form data
- [ ] T011 [P] [US1] Write widget test for `SuccessPopup` in `test/widgets/success_popup_test.dart` — verify dialog shows "Income added successfully" and updated balance with dismiss button
- [ ] T012 [P] [US1] Write widget test for `AddIncomeButton` in `test/widgets/add_income_button_test.dart` — verify tap opens `IncomeForm`

### Implementation

- [ ] T013 [US1] Implement `IncomeForm` in `lib/widgets/income_form.dart` — `showModalBottomSheet` with `DropdownButton` for types, `TextField` for amount, `TextField` for description (optional), Save/Cancel buttons, calls `IncomeValidator` on Save
- [ ] T014 [US1] Implement `SuccessPopup` in `lib/widgets/success_popup.dart` — `AlertDialog` with title "Income Added Successfully", body showing formatted updated balance, "OK" dismiss button
- [ ] T015 [US1] Implement `AddIncomeButton` in `lib/widgets/add_income_button.dart` — `ElevatedButton` that opens `IncomeForm`, wires Save to `EntryRepository.addEntry()`, shows `SuccessPopup` on completion

**Checkpoint**: `flutter test` passes. Tap Add Income → form → valid save → success popup with updated balance → entry in table.

---

## Phase 4: Polish

- [ ] T016 Run `flutter analyze` — zero errors and warnings
- [ ] T017 Run `flutter test` — all 12+ tests pass

---

## Dependencies & Execution Order

```
Phase 1        Phase 2                  Phase 3                            Phase 4
T001 ──→ T003 ──→ T006 ──→ T008 ──→ T013 ──→ T016
T002     T004     T007     T009     T014     T017
         T005             T010     T015
                          T011
                          T012
```

### Phase Dependencies
- **Phase 1**: No dependencies
- **Phase 2**: Depends on Phase 1 — blocks US1
- **Phase 3 (US1)**: Depends on Phases 1–2
- **Phase 4**: Depends on Phase 3

### Parallel Opportunities
- T003, T004, T005: foundational tests in parallel
- T008, T009, T010, T011, T012: all US1 widget tests in parallel (different files)
- T013, T014, T015: implementation can be done in parallel (different files)
- T016, T017: can run in parallel

---

## Parallel Example: User Story 1

```bash
# Write all US1 widget tests in parallel:
Task: "Write widget test for IncomeForm render in test/widgets/income_form_test.dart"
Task: "Write widget test for form validation in test/widgets/income_form_test.dart"
Task: "Write widget test for save flow in test/widgets/income_form_test.dart"
Task: "Write widget test for SuccessPopup in test/widgets/success_popup_test.dart"
Task: "Write widget test for AddIncomeButton in test/widgets/add_income_button_test.dart"
```

---

## Implementation Strategy

### MVP (User Story 1)
1. Phase 1: Verify project
2. Phase 2: Repository extension + validator
3. Phase 3: IncomeForm + SuccessPopup + AddIncomeButton
4. **STOP and VALIDATE**: Full add-income flow works end-to-end

### Integration Note
- `AddIncomeButton` takes an `EntryRepository` via constructor
- `IncomeForm` receives a callback `onSave(Entry entry)` — the button widget handles the save + success popup
- The button will eventually be positioned at the bottom of the transactions table (005); for now it works standalone
