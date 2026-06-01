# Quickstart: Project Foundation

## Prerequisites

- Flutter SDK (latest stable)
- Dart (included with Flutter)

## Setup

```bash
# 1. Create the Flutter project
flutter create money_tracker

# 2. Navigate into the project
cd money_tracker

# 3. Run analysis
flutter analyze

# 4. Run scaffold tests
flutter test
```

## Project Structure Setup

```bash
# Create subdirectories
mkdir -p lib/models lib/services lib/widgets lib/pages lib/theme
mkdir -p test/models test/services test/widgets test/pages test/theme

# Remove default counter test
rm test/widget_test.dart
```

## File Creation Order

1. `analysis_options.yaml` — lint rules
2. `lib/theme/app_theme.dart` — shared ThemeData
3. `lib/models/validation_result.dart` — shared validation type
4. `lib/main.dart` — clean app entry point with theme
5. `test/theme/app_theme_test.dart` — theme tests
6. `test/models/validation_result_test.dart` — validation tests

## Verification

```bash
flutter analyze          # zero errors
flutter test             # all tests pass
```

## Test Commands

```bash
# Run all tests
flutter test

# Run theme tests
flutter test test/theme/app_theme_test.dart

# Run validation result tests
flutter test test/models/validation_result_test.dart

# Run analysis
flutter analyze
```
