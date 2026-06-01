# Contracts: View Transactions

## TransactionsTable Contract

```dart
/// A scrollable table of transaction rows.
/// Positioned between BalanceDisplay and ButtonRow on the home page.
class TransactionsTable extends StatelessWidget {
  const TransactionsTable({
    super.key,
    required this.entries,
    required this.onTapEntry,
  });

  final List<Entry> entries;
  final void Function(Entry entry) onTapEntry;
}
```

### Contract Rules
- Rows MUST be sorted by `date` descending (most recent first).
- Income rows MUST use `Colors.green.shade50` background.
- Expense rows MUST use `Colors.red.shade50` background.
- Each row MUST display: amount (with sign), date (short format),
  and name (description, falling back to category, falling back to
  "No description").
- Row height MUST be compact (approximately 60px).
- When `entries` is empty, display "No transactions yet" centered.
- Tapping a row MUST call `onTapEntry` with that entry.

## TransactionDetail Contract

```dart
/// Shows a read-only detail view of a transaction in a bottom sheet.
Future<void> showTransactionDetail(BuildContext context, {
  required Entry entry,
});
```

### Contract Rules
- Opens `showModalBottomSheet` with the entry's full details.
- MUST display: amount (with sign), date, type (income/expense),
  category/type name, description.
- MUST include a close/dismiss action.
- Amount SHOULD be prominent (larger font).
- The bottom sheet SHOULD have a clear visual separation between
  fields.

## HomePage Layout Contract

```dart
Column(
  children: [
    BalanceDisplay(balance: ..., incomes: ..., expenses: ...),
    Expanded(
      child: TransactionsTable(
        entries: allEntries,
        onTapEntry: (entry) => showTransactionDetail(context, entry: entry),
      ),
    ),
    ButtonRow(/* AddIncome, AddExpense from 002/004 */),
  ],
)
```

### Contract Rules
- `BalanceDisplay` at top: pinned, non-scrollable.
- `TransactionsTable` in middle: takes remaining vertical space,
  scrollable.
- `ButtonRow` at bottom: pinned, non-scrollable.
- The entire layout is a single `Column` on the home page.
