# Implementation Plan: Entry Type Management

**Branch**: `003-entry-type-management` | **Date**: 2026-05-24 | **Spec**: [spec.md](spec.md)

**Input**: Feature specification from `specs/003-entry-type-management/spec.md`

## Summary

Add the ability to create expense and income types on-the-fly via
tap-hold on the Add Expense (004) and Add Income (002) buttons at
the bottom of the transactions table (005). A floating form appears
with name, a fixed/variable toggle (expense only), and value field
(enabled when fixed). Types are immediately available in dropdowns.

## Technical Context

**Language/Version**: Dart (latest stable channel)

**Primary Dependencies**: Flutter SDK only. `showModalBottomSheet`,
`TextField`, `Switch`, `ElevatedButton`. `GestureDetector` for
tap-hold detection (long press).

**Storage**: Shared `TypeRepository` (in-memory or local persistence)
for expense and income types. Must be accessible by 002 and 004 forms.

**Testing**: `flutter_test` for widget tests (form, toggle behaviour,
validation, tap-hold gesture). `test` for pure Dart unit tests.

**Target Platform**: Android (min SDK 21+), iOS (12.0+)

**Project Type**: mobile-app (Flutter)

**Performance Goals**: Form opens within 200ms of tap-hold. Types
available in dropdowns immediately (same-frame state update).

**Constraints**: Offline-only, no external dependencies. Tap-hold must
not interfere with short-tap (which opens add-entry forms). Expense
toggle controls value field visibility.

**Scale/Scope**: Single user. Create only — no edit/delete in scope.

## Constitution Check

*GATE: Must pass before Phase 0 research. Re-check after Phase 1 design.*

### Principle I — Test-Driven Development (Non-Negotiable)
- Validation logic (name required, duplicate check, amount validation)
  MUST have unit tests written first.
- Widget tests MUST verify: tap-hold vs short-tap behaviour, toggle
  enabling/disabling the value field, create/cancel flow.
- **Status**: ✅ Compliant.

### Principle II — Technology Stack
- Flutter + Dart. `GestureDetector.onLongPress` for tap-hold.
  Built-in widgets only.
- **Status**: ✅ Compliant.

### Principle III — Offline-First Architecture
- No network calls. All data local. No authentication.
- **Status**: ✅ Compliant.

### Principle IV — Minimal External Dependencies
- Zero external packages. Pure Flutter SDK.
- **Status**: ✅ Compliant.

### Principle V — Simplicity & Modern UX
- Tap-hold is an intuitive mobile pattern for secondary actions.
- Floating form keeps user in context.
- Toggle clearly shows fixed vs variable without separate screens.
- **Status**: ✅ Compliant.

## Project Structure

### Documentation (this feature)

```text
specs/003-entry-type-management/
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
│   ├── expense_type.dart       # ExpenseType: name, isFixed, fixedAmount
│   └── income_type.dart        # IncomeType: name
├── services/
│   └── type_repository.dart    # Shared type store (CRUD for types)
├── widgets/
│   ├── create_expense_type_form.dart  # Floating form with toggle
│   └── create_income_type_form.dart   # Floating form (name only)

# The Add Expense / Add Income buttons in 002/004 are updated to support
# both short-tap (add entry) and tap-hold (create type).
# The transactions_page.dart in 005 hosts both buttons.

test/
├── services/
│   └── type_repository_test.dart
├── widgets/
│   ├── create_expense_type_form_test.dart
│   └── create_income_type_form_test.dart
└── pages/
    └── transactions_page_test.dart
```

**Structure Decision**: Single Flutter project. New `TypeRepository`
shared by both income and expense forms. The 002/004 button widgets
gain tap-hold handling via `GestureDetector`.

## Complexity Tracking

No violations — all gates pass without justification needed.
