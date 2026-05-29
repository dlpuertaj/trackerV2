# Implementation Plan: Add Expense Entry

**Branch**: `004-add-expense-entry` | **Date**: 2026-05-24 | **Spec**: [spec.md](spec.md)

**Input**: Feature specification from `specs/004-add-expense-entry/spec.md`

**Note**: This template is filled in by the `/speckit.plan` command. See `.specify/templates/plan-template.md` for the execution workflow.

## Summary

Add a floating form for creating expense entries, accessible from an
"Add Expense" button at the bottom of the transactions table (005),
next to the Add Income button (002). The form includes a type dropdown
(variable vs fixed), amount field (auto-filled for fixed types),
optional description, Save and Cancel. On save, validate, persist,
update balance in real-time, and show a success popup.

## Technical Context

**Language/Version**: Dart (latest stable channel)

**Primary Dependencies**: Flutter SDK only — no external packages.
Floating form uses built-in `showModalBottomSheet`.

**Storage**: Requires write capability to shared `EntryRepository`
(via `addEntry()`). Fixed expense types read from `ExpenseType`
repository (003).

**Testing**: `flutter_test` for widget tests (form, validation,
auto-fill for fixed types, save/cancel flow, success popup), `test`
for pure Dart unit tests. TDD mandatory per Constitution Principle I.

**Target Platform**: Android (min SDK 21+), iOS (12.0+)

**Project Type**: mobile-app (Flutter)

**Performance Goals**: Form opens within 200ms. Save completes and
popup appears within 500ms.

**Constraints**: Offline-only, no external dependencies. Type and
amount mandatory. Fixed types auto-fill amount (editable). Description
optional.

**Scale/Scope**: Single user. Expense creation only — no edit or delete.

## Constitution Check

*GATE: Must pass before Phase 0 research. Re-check after Phase 1 design.*

### Principle I — Test-Driven Development (Non-Negotiable)
- Validation logic (amount, type required) MUST have unit tests first.
- Widget tests MUST verify: form opens, fixed-type auto-fill, variable
  type empty fields, validation errors, save/cancel, success popup.
- **Status**: ✅ Compliant.

### Principle II — Technology Stack
- Flutter + Dart. Built-in widgets only (DropdownButton, TextField,
  showModalBottomSheet).
- **Status**: ✅ Compliant.

### Principle III — Offline-First Architecture
- No network calls. All data local. No authentication.
- **Status**: ✅ Compliant.

### Principle IV — Minimal External Dependencies
- Zero external packages. Pure Flutter SDK.
- **Status**: ✅ Compliant.

### Principle V — Simplicity & Modern UX
- Floating form overlay — user stays in context.
- Fixed types auto-fill amount, reducing taps.
- Success popup confirms with updated balance.
- **Status**: ✅ Compliant.

## Project Structure

### Documentation (this feature)

```text
specs/004-add-expense-entry/
├── plan.md              # This file
├── research.md          # Phase 0 output
├── data-model.md        # Phase 1 output
├── quickstart.md        # Phase 1 output
├── contracts/           # Phase 1 output
└── tasks.md             # Phase 2 output
```

### Source Code (repository root)

```text
lib/
├── models/
│   └── entry.dart              # Shared (from 001)
├── services/
│   ├── entry_repository.dart   # Shared (extended by 002)
│   └── expense_validator.dart  # Validation logic
├── widgets/
│   ├── add_expense_button.dart # Button at bottom of transactions table
│   ├── expense_form.dart       # Floating form with auto-fill for fixed types
│   └── success_popup.dart      # "Expense added successfully" dialog
└── pages/
    └── transactions_page.dart  # Updated with both add buttons

test/
├── services/
│   └── expense_validator_test.dart
├── widgets/
│   ├── add_expense_button_test.dart
│   ├── expense_form_test.dart
│   └── success_popup_test.dart
└── pages/
    └── transactions_page_test.dart
```

**Structure Decision**: Single Flutter project. Mirrors 002 structure
with expense-specific validation and fixed-type auto-fill logic.

## Complexity Tracking

No violations — all gates pass without justification needed.
