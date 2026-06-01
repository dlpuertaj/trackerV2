# Research: Project Foundation

## Decisions

### Project Creation
- **Decision**: `flutter create money_tracker` with default settings.
- **Rationale**: Standard Flutter scaffold. No special flags needed.

### Directory Structure
- **Decision**: `lib/models/`, `lib/services/`, `lib/widgets/`, `lib/pages/`,
  `lib/theme/`. Tests mirror the structure under `test/`.
- **Rationale**: Standard feature-based Flutter layout. Flat enough for a
  single-developer project but organized enough to scale. `theme/` is a
  separate directory because it's cross-cutting.

### Linting
- **Decision**: Extend `package:flutter_lints/flutter.yaml`, add
  `prefer_const_constructors`, `avoid_print`, `type_init_formals`.
- **Rationale**: Flutter's recommended rules are a good baseline.
  Project-specific rules catch common issues.

### Theme Approach
- **Decision**: Static `AppTheme` class with a `static ThemeData get light`
  getter. Uses Material 3 (`useMaterial3: true`).
- **Rationale**: Simple, no state. Material 3 gives a modern look.
  A static class is testable and importable by all features.

### ValidationResult Shape
- **Decision**: Class with `isValid` and nullable `String?` fields for
  each form field (typeError, amountError, descriptionError, nameError).
- **Rationale**: Covers all form validators in 002, 003, 004. Each
  validator only populates the fields it uses.

### Counter App Removal
- **Decision**: Remove the default `flutter create` counter test and
  `main.dart` content. Replace with a clean `MaterialApp` that uses
  the app theme.
- **Rationale**: Avoid confusion with leftover scaffold code.

## Alternatives Considered

| Alternative | Rejected Because |
|-------------|------------------|
| `analysis_options.yaml` from scratch | Better to extend Flutter's recommended rules |
| Theme extension on ThemeData | Too complex for a simple app — static ThemeData suffices |
| Separate class per error type | One `ValidationResult` with nullable fields is simpler & covers all |
| Keep default counter app test | Would confuse feature tests — clean slate is better |
