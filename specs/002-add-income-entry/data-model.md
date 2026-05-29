# Data Model: Add Income Entry

## Entity: Entry (Extended)

Reuses the shared Entry from 001-balance-overview. No new fields.

| Field         | Type      | Required | Source                             |
|---------------|-----------|----------|------------------------------------|
| `id`          | String    | Yes      | Auto-generated UUID                |
| `amount`      | double    | Yes      | User input (validated > 0)         |
| `type`        | EntryType | Yes      | Always `income` for this feature   |
| `description` | String    | No       | User input (optional, max 200)     |
| `category`    | String    | No       | Selected income type name          |
| `date`        | DateTime  | Yes      | Auto-set to current time           |

## Income Type Selection

The type dropdown reads from `EntryRepository.getIncomeTypes()`.
Source priority:
1. User-created types from 003-entry-type-management
2. Fallback hardcoded set: Salary, Loan, Investment, Gift, Other

## Validation Rules

| Field     | Rule                                    | Error Message               |
|-----------|-----------------------------------------|-----------------------------|
| type      | Must select a type (not empty)          | "Please select a type"      |
| amount    | Must be a positive number > 0           | "Amount must be positive"   |
| amount    | Must have at most 2 decimal places      | "Invalid amount format"     |
| amount    | Must be a valid number (not text)       | "Enter a valid number"      |
| amount    | Must not exceed 999999999.99            | "Amount too large"          |
| desc      | Must not exceed 200 characters          | "Description too long"      |

## Repository Extension

```dart
abstract class EntryRepository {
  // Existing (from 001)
  List<Entry> getAllEntries();
  List<Entry> getEntriesByType(EntryType type);
  Stream<void> get onChange;
  List<String> getIncomeTypes();

  // Added for 002
  void addEntry(Entry entry);
}
```

## Data Flow

```
User taps "Add Income" button
  → Bottom sheet opens with income form
  → User selects type, enters amount, optional description
  → User taps Save
  → Validator checks type + amount
  → If invalid: show inline errors
  → If valid: repository.addEntry(entry)
  → Repository notifies onChange stream
  → Balance updates (001 listens to onChange)
  → Transactions table updates (005 listens to onChange)
  → Success popup shows with updated balance
```
