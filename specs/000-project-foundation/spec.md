# Feature Specification: Project Foundation

**Feature Branch**: `000-project-foundation`

**Created**: 2026-05-24

**Status**: Draft

**Input**: Foundational project setup — Flutter scaffold, directory structure, linting, theme, shared conventions, common widgets.

## User Scenarios & Testing *(mandatory)*

### User Story 1 - Project Scaffold & Build (Priority: P1)

The project is created with `flutter create`, compiles without errors,
and runs on both Android and iOS simulators.

**Independent Test**: `flutter create money_tracker` succeeds.
`flutter analyze` reports zero errors. `flutter test` passes (default
counter app test runs).

**Acceptance Scenarios**:

1. **Given** a clean environment, **When** `flutter create` runs,
   **Then** the project is created with Android and iOS platform
   directories.
2. **Given** the project exists, **When** `flutter analyze` runs,
   **Then** zero errors and warnings are reported.
3. **Given** the project exists, **When** `flutter test` runs,
   **Then** all scaffold tests pass.

---

### User Story 2 - Directory Structure & Conventions (Priority: P1)

The project follows a consistent `lib/` and `test/` directory layout
with naming conventions documented and enforced by `analysis_options.yaml`.

**Independent Test**: Run `flutter analyze` — no warnings. All source
files follow snake_case naming in `lib/models/`, `lib/services/`,
`lib/widgets/`, `lib/pages/`. Tests mirror the structure in `test/`.

**Acceptance Scenarios**:

1. **Given** the project root, **When** looking at `lib/`, **Then** it
   contains `models/`, `services/`, `widgets/`, `pages/` subdirectories.
2. **Given** the project root, **When** looking at `test/`, **Then** it
   contains `models/`, `services/`, `widgets/`, `pages/` subdirectories.
3. **Given** a source file, **When** named, **Then** it uses `snake_case`
   (e.g., `balance_display.dart`, `entry_repository.dart`).

---

### User Story 3 - Linting & Analysis Rules (Priority: P1)

`analysis_options.yaml` enforces code quality: snake_case files,
prefer `const` constructors, avoid `print()`, require type annotations.

**Independent Test**: A test file that violates rules (e.g., uses
`print()` or PascalCase file name) triggers analysis warnings.

**Acceptance Scenarios**:

1. **Given** the project, **When** `flutter analyze` runs, **Then** it
   catches `avoid_print`, `prefer_const_constructors`, `type_init_formals`.

---

### User Story 4 - Base Theme & Typography (Priority: P2)

A shared `ThemeData` establishes the app's colour palette, text styles,
and Material component defaults. All screens use this theme.

**Independent Test**: A test widget wrapped in `MaterialApp(theme: appTheme)`
renders with the correct primary colour, text styles, and button shapes.

**Acceptance Scenarios**:

1. **Given** the theme is defined, **When** a widget uses `Theme.of(context)`,
   **Then** it gets the correct primary colour, text theme, button theme.
2. **Given** the theme, **When** a `Text` widget uses `textTheme.headlineMedium`,
   **Then** it renders with the correct font size and weight.

---

### User Story 5 - Shared Validation Result Type (Priority: P2)

A `ValidationResult` class is defined in `lib/models/validation_result.dart`,
used by all form validators (002, 003, 004) to return field-level errors.

**Independent Test**: Create a `ValidationResult` with a type error.
Verify `isValid` is false, `typeError` is non-null, other errors are null.

**Acceptance Scenarios**:

1. **Given** a `ValidationResult` with one error, **When** checking
   `isValid`, **Then** it returns false.
2. **Given** a `ValidationResult` with no errors, **When** checking,
   **Then** `isValid` is true and all error fields are null.

---

### Edge Cases

- The existing default counter app test from `flutter create` is removed
  to avoid confusion (or kept and ignored in coverage)
- `analysis_options.yaml` starts with the Flutter recommended rules and
  adds only the project-specific overrides
- Theme colours are easy to change — defined as constants in one place

## Requirements *(mandatory)*

### Functional Requirements

- **FR-001**: The project MUST compile and pass `flutter analyze` with
  zero errors.
- **FR-002**: The `lib/` directory MUST use a standard Flutter layout with
  `models/`, `services/`, `widgets/`, `pages/` subdirectories.
- **FR-003**: The `test/` directory MUST mirror `lib/` structure.
- **FR-004**: `analysis_options.yaml` MUST enforce: snake_case files,
  `prefer_const_constructors`, `avoid_print`, `type_init_formals`.
- **FR-005**: A shared `ThemeData` MUST define: primary colour, text
  theme (headline, title, body), button theme, input decoration theme.
- **FR-006**: A `ValidationResult` model MUST be defined in
  `lib/models/validation_result.dart` — a simple class with `isValid`
  and nullable field-level error strings.
- **FR-007**: Theme colours, text styles, and validation result type
  MUST be importable by all features (001-005) without duplication.
- **FR-008**: The default Flutter counter test MUST be removed (clean
  slate for feature tests).

### Key Entities *(include if feature involves data)*

- **ValidationResult**: Reusable result type for form validation.
  Fields: `isValid` (bool), `typeError` (String?), `amountError` (String?),
  `descriptionError` (String?), `nameError` (String?).
- **AppTheme**: Static class or constant defining the app's `ThemeData`,
  colour palette, and text styles.

## Success Criteria *(mandatory)*

### Measurable Outcomes

- **SC-001**: `flutter analyze` passes with zero errors in under 30
  seconds on a clean project.
- **SC-002**: All 5 feature specs (001-005) can import and use
  `ValidationResult` and `AppTheme` without conflict.
- **SC-003**: A developer can add a new `lib/widgets/` file and its
  corresponding `test/widgets/` test without any configuration changes.

## Assumptions

- Default Flutter project uses `flutter create` with no extra flags.
- `analysis_options.yaml` extends `flutter` and `flutter_test` packages.
- Theme uses Material 3 (Material Design 3) by default.
- The project targets both Android and iOS (not web or desktop for now).
- The same `ValidationResult` shape is used by all feature validators;
  each validator only populates the error fields relevant to its form.
