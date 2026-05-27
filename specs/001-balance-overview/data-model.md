# Data Model: Balance Overview

## Entity: Entry

A single financial record representing either income or an expense.

| Field         | Type      | Required | Notes                                      |
|---------------|-----------|----------|--------------------------------------------|
| `id`          | String    | Yes      | Unique identifier (UUID)                   |
| `amount`      | double    | Yes      | Positive decimal, up to 2 decimal places   |
| `type`        | EntryType | Yes      | Enum: income or expense                    |
| `description` | String    | No       | Plain text, max 200 chars                  |
| `category`    | String    | No       | Category name (e.g., "Food", "Salary")     |
| `date`        | DateTime  | Yes      | When the entry occurred                    |

### Validation Rules
- `amount` > 0 (zero and negative rejected)
- `description` ≤ 200 characters if provided
- `date` defaults to current DateTime if not specified

## Computed Value: Balance

Not stored — calculated on demand:
```
balance = sum(income entries) - sum(expense entries)
```

## Data Flow

```
EntryRepository (in-memory)
  │
  ├── getAllEntries() → List<Entry>
  ├── getIncomes() → List<Entry>       (filter by type == income)
  ├── getExpenses() → List<Entry>      (filter by type == expense)
  └── onEntriesChanged → Stream/notify (for real-time updates)

HomePage
  ├── Listens to EntryRepository changes
  ├── Calculates balance, incomeTotal, expenseTotal
  ├── Renders BalanceDisplay (pinned top)
  ├── Renders BreakdownSection (income/expense subtotals)
  └── Renders EntryList (scrollable, recent first)
```
