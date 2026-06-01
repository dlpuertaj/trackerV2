# Implementation Plan: View Transactions

**Branch**: `005-view-transactions` | **Date**: 2026-05-24 | **Spec**: [spec.md](spec.md)

**Input**: Feature specification from `specs/005-view-transactions/spec.md`

## Summary

Add a scrollable transactions table on the main screen, positioned
between the balance (001) at the top and the add buttons (002/004) at
the bottom. Each row shows amount, date, and name, with distinct
colours for income vs expense. Tapping a row opens a floating detail
form.

## Technical Context

**Language/Version**: Dart (latest stable channel)

**Primary Dependencies**: Flutter SDK only. `ListView.builder` for
scrollable rows. `showModalBottomSheet` for detail form.

**Storage**: Read-only via shared `EntryRepository.getAllEntries()`.

**Testing**: `flutter_test` for widget tests (layout, row colours,
tap-to-detail, empty state, scrolling). TDD mandatory.

**Target Platform**: Android (min SDK 21+), iOS (12.0+)

**Project Type**: mobile-app (Flutter)

**Performance Goals**: Table renders full list within 500ms.
`ListView.builder` handles 100+ entries at 60 fps. Detail form opens
within 300ms of tap.

**Constraints**: Offline-only. Table is part of main screen (not a
separate page). Balance at top, add buttons at bottom.

**Scale/Scope**: Single user. View-only — no edit/delete. No search
or filter.

## Constitution Check

*GATE: Must pass before Phase 0 research. Re-check after Phase 1 design.*

### Principle I — Test-Driven Development (Non-Negotiable)
- Widget tests MUST verify: correct row colours, tap opens detail
  form, empty state message, scrolling behaviour.
- **Status**: ✅ Compliant.

### Principle II — Technology Stack
- Flutter + Dart. `ListView.builder`, `Container` with colour.
- **Status**: ✅ Compliant.

### Principle III — Offline-First Architecture
- No network calls. All data local. No authentication.
- **Status**: ✅ Compliant.

### Principle IV — Minimal External Dependencies
- Zero external packages. Pure Flutter SDK.
- **Status**: ✅ Compliant.

### Principle V — Simplicity & Modern UX
- Clean layout: balance → table → buttons. Coloured rows for quick
  scanning. Tap for details — keeps table uncluttered.
- **Status**: ✅ Compliant.

## Project Structure

### Documentation (this feature)

```text
specs/005-view-transactions/
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
├── widgets/
│   ├── transactions_table.dart   # Scrollable table with coloured rows
│   └── transaction_detail.dart   # Floating detail form (bottom sheet)
└── pages/
    └── home_page.dart            # Main screen: balance → table → buttons

test/
├── widgets/
│   ├── transactions_table_test.dart
│   └── transaction_detail_test.dart
└── pages/
    └── home_page_test.dart
```

**Structure Decision**: Single Flutter project. Table and detail form
are new widgets. `home_page.dart` restructured from 001 to include the
table between the balance and buttons.

## Complexity Tracking

No violations — all gates pass without justification needed.
