# Quickstart: Balance Overview

## Prerequisites

- Flutter SDK (latest stable)
- Dart (included with Flutter)
- No external packages required

## Setup

```bash
# Create Flutter project (if not exists)
flutter create money_tracker

# Run tests
flutter test

# Run app
flutter run
```

## Project Structure

```
lib/
├── main.dart
├── models/entry.dart
├── services/entry_repository.dart
├── widgets/
│   ├── balance_display.dart
│   ├── breakdown_section.dart
│   └── entry_list.dart
└── pages/home_page.dart
```

## Verification

1. Open the app — balance of 0.00 is displayed at the top
2. Add sample entries via code:
   - Income: 500 (Salary)
   - Expense: 200 (Groceries)
3. Balance shows 300
4. Balance text colour is neutral (no green/red)
5. Entries list shows both entries in reverse-chronological order

## Test Commands

```bash
# Run all tests
flutter test

# Run specific test file
flutter test test/widgets/balance_display_test.dart

# Run with coverage
flutter test --coverage
```
