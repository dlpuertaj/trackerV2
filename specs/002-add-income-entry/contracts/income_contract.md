# Contracts: Add Income Entry

## EntryRepository Contract (Extended)

Extends the contract from 001 with write capability.

```dart
abstract class EntryRepository {
  // Read operations
  List<Entry> getAllEntries();
  List<Entry> getEntriesByType(EntryType type);
  Stream<void> get onChange;

  // Type lookup
  List<String> getIncomeTypes();

  // Write operation (added for 002)
  void addEntry(Entry entry);
}
```

### Contract Rules
- `addEntry` MUST generate a unique `id` if not provided.
- `addEntry` MUST set `date` to current time if not provided.
- `addEntry` MUST fire the `onChange` stream after persisting.
- The repository MUST NOT reject a valid Entry (validation is the
  caller's responsibility).

## Income Form Contract

```dart
class IncomeFormData {
  final String? type;        // Selected income type
  final double? amount;      // Parsed amount
  final String? description; // Optional description text
}

// Returns the form data if saved, or null if cancelled
Future<IncomeFormData?> showIncomeForm(BuildContext context);

// Returns true if valid, false with error messages otherwise
ValidationResult validate(IncomeFormData data);

class ValidationResult {
  final bool isValid;
  final String? typeError;
  final String? amountError;
  final String? descriptionError;
}
```

## Success Popup Contract

```dart
/// Shows success dialog with updated balance.
/// Returns when user dismisses the popup.
Future<void> showSuccessPopup(BuildContext context, {
  required double updatedBalance,
});
```
