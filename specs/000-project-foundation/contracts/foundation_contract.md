# Contracts: Project Foundation

## ValidationResult Contract

```dart
class ValidationResult {
  final bool isValid;
  final String? typeError;
  final String? amountError;
  final String? descriptionError;
  final String? nameError;

  ValidationResult({
    this.typeError,
    this.amountError,
    this.descriptionError,
    this.nameError,
  }) : isValid = typeError == null
         && amountError == null
         && descriptionError == null
         && nameError == null;
}
```

### Contract Rules
- `isValid` is true ONLY when ALL error fields are null.
- Validators MUST NOT populate irrelevant fields (e.g., income validator
  leaves `nameError` null).

## AppTheme Contract

```dart
class AppTheme {
  static const Color primaryColor = Colors.indigo;

  static ThemeData get light => ThemeData(
    useMaterial3: true,
    colorSchemeSeed: primaryColor,
    // textTheme, buttonTheme, inputDecorationTheme
  );
}
```

### Contract Rules
- All screens MUST wrap in `MaterialApp(theme: AppTheme.light)`.
- Theme values MUST NOT change at runtime (no dark mode in this version).
- Individual widgets SHOULD use `Theme.of(context)` rather than hardcoded
  colours.

## analysis_options.yaml Contract

```yaml
include: package:flutter_lints/flutter.yaml

linter:
  rules:
    - prefer_const_constructors
    - avoid_print
    - type_init_formals
```

### Contract Rules
- All source files MUST pass `flutter analyze` with zero errors.
- Any violation of lint rules is a build failure (not a warning).

## Directory Structure Contract

```
lib/
├── main.dart
├── theme/
│   └── app_theme.dart
├── models/
│   └── validation_result.dart
├── services/
├── widgets/
└── pages/

test/
├── theme/
│   └── app_theme_test.dart
├── models/
│   └── validation_result_test.dart
├── services/
├── widgets/
└── pages/
```

### Contract Rules
- Every `lib/<category>/` directory MUST have a matching `test/<category>/`
  directory.
- New feature code MUST go into the appropriate existing directory (not
  create new top-level directories under `lib/` or `test/`).
