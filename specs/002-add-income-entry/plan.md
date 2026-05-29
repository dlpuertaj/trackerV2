# Implementation Plan: Add Income Entry

**Branch**: `002-add-income-entry` | **Date**: 2026-05-24 | **Spec**: [spec.md](spec.md)

**Input**: Feature specification from `specs/002-add-income-entry/spec.md`

**Note**: This template is filled in by the `/speckit.plan` command. See `.specify/templates/plan-template.md` for the execution workflow.

## Summary

Add a floating form for creating income entries, accessible from an
"Add Income" button at the bottom of the transactions table (005).
The form includes a type dropdown, amount field, optional description,
Save and Cancel buttons. On save, validate, persist, update balance
in real-time, and show a success popup with the updated balance.

## Technical Context

**Language/Version**: Dart (latest stable channel)

**Primary Dependencies**: Flutter SDK only — no external packages.
Floating form uses built-in `showModalBottomSheet` or `AlertDialog`.

**Storage**: Requires write capability to a shared `EntryRepository`.
For this feature, the repository must support `addEntry()` (previously
read-only in 001). In-memory or local persistence.

**Testing**: `flutter_test` for widget tests (form validation, save
flow, popup display), `test` for pure Dart unit tests (validation
logic). TDD mandatory per Constitution Principle I.

**Target Platform**: Android (min SDK 21+), iOS (12.0+)

**Project Type**: mobile-app (Flutter)

**Performance Goals**: Form opens within 200ms of button tap. Save
completes and popup appears within 500ms.

**Constraints**: Offline-only, no external dependencies. Form must
be a floating overlay (not a new page/screen). Only type and amount
mandatory. Description optional.

**Scale/Scope**: Single user. Entry creation only — no edit or delete
in this feature.

## Constitution Check

*GATE: Must pass before Phase 0 research. Re-check after Phase 1 design.*

### Principle I — Test-Driven Development (Non-Negotiable)
- All validation logic (amount, type required) MUST have unit tests
  written first.
- Widget tests MUST verify: form opens, type selection, save/cancel
  flow, validation errors, success popup.
- **Status**: ✅ Compliant — test plan defined in tasks.

### Principle II — Technology Stack
- Flutter + Dart. Uses built-in widgets (DropdownButton, TextField,
  showModalBottomSheet).
- **Status**: ✅ Compliant.

### Principle III — Offline-First Architecture
- No network calls. All data local. No authentication.
- **Status**: ✅ Compliant.

### Principle IV — Minimal External Dependencies
- Zero external packages. Pure Flutter SDK.
- **Status**: ✅ Compliant.

### Principle V — Simplicity & Modern UX
- Floating form overlay — keeps user in context.
- Clear validation feedback, success popup with updated balance.
- **Status**: ✅ Compliant.

## Project Structure

### Documentation (this feature)

```text
specs/002-add-income-entry/
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
│   ├── entry_repository.dart   # Extended with addEntry()
│   └── income_validator.dart   # Validation logic
├── widgets/
│   ├── add_income_button.dart  # Button at bottom of transactions table
│   ├── income_form.dart        # Floating form (type, amount, description)
│   └── success_popup.dart      # "Income added successfully" dialog
└── pages/
    └── transactions_page.dart  # Updated to include add buttons

test/
├── services/
│   └── income_validator_test.dart
├── widgets/
│   ├── add_income_button_test.dart
│   ├── income_form_test.dart
│   └── success_popup_test.dart
└── pages/
    └── transactions_page_test.dart
```

**Structure Decision**: Single Flutter project. Extends existing
models and repository from 001. New validation logic extracted to
dedicated service for testability.

## Complexity Tracking

No violations — all gates pass without justification needed.
