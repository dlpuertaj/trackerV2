# Contracts: Balance Overview

## Entry Model Contract

The Entry model is the shared data contract between all features.
Any feature that reads or writes entries MUST conform to this shape.

### Interface

```dart
enum EntryType { income, expense }

class Entry {
  final String id;
  final double amount;        // > 0, max 2 decimal places
  final EntryType type;       // income or expense
  final String? description;  // max 200 chars
  final String? category;
  final DateTime date;
}
```

### Balance Calculation

```dart
double calculateBalance(List<Entry> entries) {
  final income = entries
      .where((e) => e.type == EntryType.income)
      .fold(0.0, (sum, e) => sum + e.amount);
  final expense = entries
      .where((e) => e.type == EntryType.expense)
      .fold(0.0, (sum, e) => sum + e.amount);
  return income - expense;
}
```

## EntryRepository Contract

```dart
abstract class EntryRepository {
  List<Entry> getAllEntries();
  List<Entry> getEntriesByType(EntryType type);
  void addEntry(Entry entry);
  void removeEntry(String id);
  Stream<void> get onChange;  // Notifies UI of data changes
}
```

Future features (002, 004) will implement the `addEntry` method.
For this view-only feature, a mock/in-memory implementation is used.
