# Tasks: Project Foundation (000)

**Input**: Design documents from `specs/000-project-foundation/`

**Tests**: Per Constitution Principle I (TDD is Non-Negotiable), tests are MANDATORY.
Tests MUST be written first and MUST fail before any implementation code is written.

---

## Phase 1: Setup — Scaffold Flutter Project

- [ ] T001 Run `flutter create money_tracker` to scaffold the project
- [ ] T002 Create subdirectories: `lib/models/`, `lib/services/`, `lib/widgets/`, `lib/pages/`, `lib/theme/`, `test/models/`, `test/services/`, `test/widgets/`, `test/pages/`, `test/theme/`
- [ ] T003 Remove default counter test `test/widget_test.dart`

---

## Phase 2: Linting & Analysis

**Purpose**: Configure `analysis_options.yaml` with project-specific rules.

- [ ] T004 Write `analysis_options.yaml` — extend `package:flutter_lints/flutter.yaml`, add `prefer_const_constructors`, `avoid_print`, `type_init_formals`

**Checkpoint**: `flutter analyze` passes with zero errors on the clean scaffold (no app code yet)

---

## Phase 3: Shared ValidationResult Model

**Purpose**: Reusable `ValidationResult` class used by all form validators.

### Tests (write first, must fail)

- [ ] T005 Write unit test for `ValidationResult` in `test/models/validation_result_test.dart` — verify `isValid` is true when no errors, false when any error set, individual error fields are nullable

### Implementation

- [ ] T006 Implement `ValidationResult` in `lib/models/validation_result.dart` — class with `isValid` (computed) and nullable `typeError`, `amountError`, `descriptionError`, `nameError` fields

**Checkpoint**: `flutter test` passes for validation result tests

---

## Phase 4: App Theme (P2)

**Purpose**: Shared `ThemeData` with Material 3, primary colour, text styles, component defaults.

### Tests (write first, must fail)

- [ ] T007 Write widget test for `AppTheme` in `test/theme/app_theme_test.dart` — verify `light` theme is not null, primary colour is set, `useMaterial3` is true, text theme has headline/title/body styles, button theme exists

### Implementation

- [ ] T008 Implement `AppTheme` in `lib/theme/app_theme.dart` — static class with `primaryColor` constant and `ThemeData get light` using `useMaterial3: true` and `colorSchemeSeed`

**Checkpoint**: `flutter test` passes for theme tests

---

## Phase 5: Clean main.dart (P1)

**Purpose**: App entry point that uses the shared theme, clean of counter app code.

### Tests (write first, must fail)

- [ ] T009 Write widget test for `main.dart` in `test/main_test.dart` — verify `MaterialApp` is created with `AppTheme.light`, app renders without errors

### Implementation

- [ ] T010 Rewrite `lib/main.dart` — import and apply `AppTheme.light`, remove counter app code, return a clean `MaterialApp` with placeholder home (will be replaced by 001)

**Checkpoint**: `flutter test` passes for all foundation tests. `flutter analyze` passes.

---

## Phase 6: Polish

- [ ] T011 Run `flutter analyze` — zero errors and warnings
- [ ] T012 Run `flutter test` — all tests pass

---

## Dependencies & Execution Order

```
Phase 1                Phase 2   Phase 3          Phase 4          Phase 5          Phase 6
T001 ──→ T004 ──→ T005 ──→ T006 ──→ T007 ──→ T008 ──→ T009 ──→ T010 ──→ T011
T002                                                                    T012
T003
```

### Phase Dependencies
- **Phase 1**: No dependencies
- **Phase 2**: Depends on Phase 1
- **Phase 3**: Depends on Phases 1–2 (needs project scaffold)
- **Phase 4**: Depends on Phases 1–2 (independent of Phase 3)
- **Phase 5**: Depends on Phases 1–4 (needs theme)
- **Phase 6**: Depends on Phases 3–5

### Parallel Opportunities
- T002, T003: can be done in parallel
- Phase 3 and Phase 4: can proceed in parallel (different directories, no dependencies between ValidationResult and AppTheme)
- T011, T012: can run in parallel

---

## Parallel Example

```bash
# Phase 3 and Phase 4 in parallel:
Task: "Write ValidationResult test + impl in test/models/ and lib/models/"
Task: "Write AppTheme test + impl in test/theme/ and lib/theme/"
```

---

## Implementation Strategy

### Full Foundation (All in One Go)
Since foundation is small and all stories are P1/P2, implement in order:

1. Scaffold project (Phase 1)
2. Lint rules (Phase 2)
3. ValidationResult (Phase 3)
4. AppTheme (Phase 4)
5. Clean main.dart (Phase 5)
6. Validate (Phase 6)

After 000 is done, features 001–005 can start with a clean, consistent
project that shares lint rules, theme, and the `ValidationResult` type.
