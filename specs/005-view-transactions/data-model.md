# Data Model: View Transactions

## Entity: Entry (Reused)

No new entities needed. This feature consumes the existing `Entry`
model from 001-balance-overview.

| Field         | Type      | Required | Notes                                      |
|---------------|-----------|----------|--------------------------------------------|
| `id`          | String    | Yes      | Unique identifier (UUID)                   |
| `amount`      | double    | Yes      | Positive decimal, up to 2 decimal places   |
| `type`        | EntryType | Yes      | Enum: income or expense                    |
| `description` | String    | No       | Plain text, max 200 chars                  |
| `category`    | String    | No       | Category/type name (e.g., "Food", "Salary")|
| `date`        | DateTime  | Yes      | When the entry occurred                    |

### Display Notes
- Income amounts display as `+$amount` (positive sign)
- Expense amounts display as `-$amount` (negative sign)
- Date displays in short format: `MMM d, yyyy` (e.g., "May 24, 2026")
- If `description` is null/empty, fall back to the `category` name
- If both are null/empty, show "No description"

## Computed View: Transactions Table

No stored state. Read from `EntryRepository.getAllEntries()` sorted
by `date` descending (most recent first).

## Data Flow

```
EntryRepository (shared from 001)
  │
  ├── getAllEntries() → List<Entry>
  └── onChange → Stream (rebuild table on data change)

HomePage (restructured)
  ├── BalanceDisplay (top, pinned)
  ├── Expanded → TransactionsTable (middle, scrollable)
  │     └── onTap → showTransactionDetail() → BottomSheet
  └── ButtonRow (bottom, pinned: AddIncome + AddExpense)
```
