# Implementation Plan: Balance Overview

**Branch**: `001-balance-overview` | **Date**: 2026-05-24 | **Spec**: [spec.md](spec.md)

**Input**: Feature specification from `specs/001-balance-overview/spec.md`

**Note**: This template is filled in by the `/speckit.plan` command. See `.specify/templates/plan-template.md` for the execution workflow.

## Summary

Display the user's net financial balance (total income minus total
expenses) prominently at the top of the main screen, with income and
expense subtotals, a scrollable recent entries list, and real-time
updates when entries are added. The balance text uses neutral colour
(no green/red), is always visible without scrolling, and persists
across app restarts via local storage.

## Technical Context

**Language/Version**: Dart (latest stable channel)

**Primary Dependencies**: Flutter SDK only — no external packages.
State management via `setState` or `InheritedWidget`.

**Storage**: No persistent storage needed for this view-only feature;
entry data for the balance calculation comes from the shared data
layer (implemented in future features). For development/testing,
an in-memory repository suffices.

**Testing**: `flutter_test` for widget tests, `test` for pure Dart
unit tests. TDD cycle mandatory per Constitution Principle I.

**Target Platform**: Android (min SDK 21+), iOS (12.0+)

**Project Type**: mobile-app (Flutter)

**Performance Goals**: Balance updates within 100ms of state change;
list scrolls at 60 fps on mid-range devices.

**Constraints**: Offline-only, no network calls, no login/auth,
no external dependencies. Balance always visible at top of screen.
Neutral text colour at all times (no green/red).

**Scale/Scope**: Single user, personal finance tracking.

## Constitution Check

*GATE: Must pass before Phase 0 research. Re-check after Phase 1 design.*

### Principle I — Test-Driven Development (Non-Negotiable)
- All business logic (balance calculation, entry sorting, filtering)
  MUST have unit tests written first.
- Widget tests MUST verify balance visibility, layout, and real-time
  update behaviour.
- No implementation code without a preceding failing test.
- **Status**: ✅ Compliant — test plan defined in tasks.

### Principle II — Technology Stack
- Flutter + Dart only. No native platform channels required for this
  feature (all logic is pure Dart/widgets).
- **Status**: ✅ Compliant.

### Principle III — Offline-First Architecture
- No network calls. All data is local (in-memory for this feature).
- No authentication. No external APIs.
- **Status**: ✅ Compliant.

### Principle IV — Minimal External Dependencies
- Zero external packages. Flutter SDK built-in widgets only.
- **Status**: ✅ Compliant.

### Principle V — Simplicity & Modern UX
- Balance is the most prominent element, pinned at the top.
- Clean flat design, neutral colours, clear typography.
- Entries list scrolls beneath the fixed balance header.
- **Status**: ✅ Compliant.

## Project Structure

### Documentation (this feature)

```text
specs/001-balance-overview/
├── plan.md              # This file (/speckit.plan command output)
├── research.md          # Phase 0 output (/speckit.plan command)
├── data-model.md        # Phase 1 output (/speckit.plan command)
├── quickstart.md        # Phase 1 output (/speckit.plan command)
├── contracts/           # Phase 1 output (/speckit.plan command)
└── tasks.md             # Phase 2 output (/speckit.tasks command)
```

### Source Code (repository root)

```text
lib/
├── models/
│   └── entry.dart            # Entry data model
├── services/
│   └── entry_repository.dart # In-memory entry store
├── widgets/
│   ├── balance_display.dart  # Balance text widget (top, pinned)
│   ├── breakdown_section.dart# Income/expense subtotals
│   └── entry_list.dart       # Scrollable recent entries list
├── pages/
│   └── home_page.dart        # Main screen (assembles all widgets)
└── main.dart                 # App entry point

test/
├── models/
│   └── entry_test.dart
├── services/
│   └── entry_repository_test.dart
├── widgets/
│   ├── balance_display_test.dart
│   ├── breakdown_section_test.dart
│   └── entry_list_test.dart
└── pages/
    └── home_page_test.dart
```

**Structure Decision**: Single Flutter project with standard
feature-based layout. Models, services, widgets, and pages under
`lib/`. Tests mirror the `lib/` structure.

## Complexity Tracking

> **Fill ONLY if Constitution Check has violations that must be justified**

No violations — all gates pass without justification needed.
