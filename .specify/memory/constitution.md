<!--
  Sync Impact Report
  ==================
  Version change: (none) → 1.0.0
  Principles:
    - [PRINCIPLE_1_NAME]   → I. Test-Driven Development (Non-Negotiable)
    - [PRINCIPLE_2_NAME]   → II. Technology Stack
    - [PRINCIPLE_3_NAME]   → III. Offline-First Architecture
    - [PRINCIPLE_4_NAME]   → IV. Minimal External Dependencies
    - [PRINCIPLE_5_NAME]   → V. Simplicity & Modern UX
  Sections added:
    - Technical Constraints (was [SECTION_2_NAME])
    - Development Workflow (was [SECTION_3_NAME])
  Sections removed: none
  Templates requiring updates:
    - .specify/templates/plan-template.md        → ✅ reviewed (no changes needed)
    - .specify/templates/spec-template.md         → ✅ reviewed (no changes needed)
    - .specify/templates/tasks-template.md        → ⚠ pending — add TDD phase rules to match Principle I
    - .specify/templates/constitution-template.md → ✅ reviewed (template unchanged)
  Follow-up TODOs: none (all placeholders resolved)
-->

# Money Tracker Constitution

## Core Principles

### I. Test-Driven Development (Non-Negotiable)

All code MUST be developed using TDD: write a failing test first (Red),
then implement the minimum code to pass (Green), then refactor (Refactor).
Tests MUST be written before any implementation code. Every feature MUST
have unit tests covering all business logic. The test suite MUST be run
and pass before any commit. No implementation work may begin until its
failing test is approved.

### II. Technology Stack

The application MUST be built with Flutter and Dart. The UI MUST target
mobile platforms (Android and iOS). The codebase MUST follow idiomatic
Flutter patterns (widgets, state management, models) without straying
into non-standard architectural patterns unless justified.

### III. Offline-First Architecture

The app MUST function entirely offline with no network requirements.
No authentication or login flow of any kind MAY be introduced. All data
MUST be persisted locally (e.g., via `sqflite`, shared_preferences, or
in-memory storage). No external APIs, cloud services, or remote backends
MAY be required for core functionality.

### IV. Minimal External Dependencies

External packages SHOULD be avoided unless they provide essential
functionality that would be disproportionately expensive to implement
from scratch. Any external dependency MUST be justified in the spec or
plan. The default position is to write custom code for business logic,
UI components, and data persistence.

### V. Simplicity & Modern UX

The user interface MUST be clean, modern, and intuitive. The primary
screen MUST display the current balance prominently. Entries (expenses
and incomes) MUST be visually distinct and clearly categorized. The app
SHOULD minimize taps required for common operations. Visual complexity
MUST be avoided — flat design, clear typography, and consistent spacing
are expected.

## Technical Constraints

- **Language**: Dart (latest stable channel)
- **Framework**: Flutter (latest stable channel)
- **State Management**: Provider, setState, or inherited widgets only (no
  external state management libraries unless justified)
- **Storage**: Local persistence via sqflite or shared_preferences; no
  remote databases
- **Targets**: Android (min SDK 21+), iOS (12.0+)
- **Build Tools**: Flutter SDK built-in tools only (`flutter build`,
  `flutter test`)
- **Formatting**: Dart format with default settings (no external linter
  configs unless justified)

## Development Workflow

1. **TDD Cycle**: Before writing any implementation code, write a failing
   test. Get approval on the test. Then implement until the test passes.
   Then refactor while keeping tests green. Commit after Green.
2. **Feature Flow**: Spec → Plan → Tasks → Implement. Each phase must
   produce its artifact and be approved before moving to the next.
3. **Test Isolation**: Unit tests MUST NOT depend on the widget tree or
   platform channels unless they are widget or integration tests.
   Business logic tests MUST be pure Dart tests.
4. **Commit Hygiene**: Each commit MUST represent a logical unit of work
   with passing tests. Squash commits are allowed before pull requests.
5. **Review Gates**: Every merge MUST verify constitution compliance,
   test coverage adequacy, and minimal dependency footprint.

## Governance

This constitution defines the non-negotiable rules for the Money Tracker
project. Any amendment requires:
- A documented proposal explaining the rationale
- Approval from the project maintainer
- A migration plan for any affected existing practices

**Versioning Policy**: This constitution follows Semantic Versioning:
- MAJOR: Backward-incompatible principle removal/redefinition
- MINOR: New principle or materially expanded guidance
- PATCH: Clarifications, typo fixes, non-semantic refinements

**Compliance Review**: Every feature plan MUST include a Constitution
Check section verifying alignment with all principles. Violations MUST
be documented and justified in the Complexity Tracking table.

**Version**: 1.0.0 | **Ratified**: 2026-05-24 | **Last Amended**: 2026-05-24
