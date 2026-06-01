# Quickstart: View Transactions

## Prerequisites

- 001-balance-overview implemented (Entry model, EntryRepository)
- 002-add-income-entry implemented (addEntry, AddIncomeButton)
- 004-add-expense-entry implemented (AddExpenseButton)
- Flutter SDK (latest stable)

## Setup

```bash
# Ensure existing code compiles
flutter analyze

# Run tests
flutter test
```

## Key Implementation Steps

1. **Create `TransactionsTable` widget** — scrollable ListView inside
   an Expanded widget. Each row is a coloured Container with amount,
   date, and name. Row colours differentiate income vs expense.

2. **Create `showTransactionDetail` function** — modal bottom sheet
   displaying all entry fields read-only.

3. **Restructure `HomePage`** — wrap form: BalanceDisplay at top,
   Expanded(TransactionsTable) in middle, ButtonRow at bottom.
   Listen to EntryRepository.onChange for real-time updates.

4. **Update `ButtonRow`** — ensure AddIncome and AddExpense buttons sit
   below the table (previously there was no table below balance).

## Test Commands

```bash
# Run all tests
flutter test

# Run transaction-specific tests
flutter test test/widgets/transactions_table_test.dart
flutter test test/widgets/transaction_detail_test.dart
flutter test test/pages/home_page_test.dart
```

## Verification

1. Open app — balance at top, transactions table in middle (empty
   state: "No transactions yet"), add buttons at bottom
2. Add an income entry (via Add Income button) — row appears in table
   with green tint, shows "+500", today's date, and the type name
3. Add an expense entry — row appears with red tint, shows "-200",
   date, and description
4. Table shows entries in reverse-chronological order (newest first)
5. Tap a row — bottom sheet opens with full details (amount, date,
   type, category, description)
6. Dismiss bottom sheet — table is visible again
7. Add 20+ entries — table scrolls smoothly
