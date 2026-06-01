# Feature Specification: View Transactions

**Feature Branch**: `005-view-transactions`

**Created**: 2026-05-24

**Status**: Draft

**Input**: User description: "view incomes and expenses in a scrollable table with search and filter"

## User Scenarios & Testing *(mandatory)*

### User Story 1 - View All Transactions in a Scrollable Table (Priority: P1)

The user sees all income and expense entries in a scrollable table
located between the balance at the top and the add buttons at the
bottom. Each row shows the amount, date, and name of the transaction.
Income rows and expense rows use different background colours so the
user can distinguish them at a glance.

**Why this priority**: The transaction table is the primary way users
review their financial history. The mini-list from 001 shows only
recent entries — this shows everything.

**Independent Test**: With 10 entries (4 incomes, 6 expenses), the
table MUST display all 10 rows in reverse-chronological order. Income
rows MUST have a different background colour than expense rows.

**Acceptance Scenarios**:

1. **Given** the main screen is displayed, **When** the user views
   it, **Then** the transactions table is positioned between the
   balance (001) at the top and the add buttons (002/004) at the
   bottom.
2. **Given** the table is displayed, **When** looking at a row,
   **Then** it shows: the amount, the date, and the transaction name
   (description).
3. **Given** an income entry exists, **When** displayed in the table,
   **Then** its row uses a distinct colour (e.g., green tint) to
   indicate it is income.
4. **Given** an expense entry exists, **When** displayed in the table,
   **Then** its row uses a distinct colour (e.g., red tint) to
   indicate it is expense.
5. **Given** the table has more entries than fit on screen, **When**
   the user scrolls, **Then** older entries become visible.
6. **Given** there are no entries, **When** the user views the table,
   **Then** a message "No transactions yet" is displayed.

---

### User Story 2 - Tap a Transaction to View Details (Priority: P2)

The user taps on any transaction row in the table. A floating form
appears showing the full details of that transaction: the amount, the
date, the type (income/expense), the category/type name, and the
description.

**Why this priority**: Tapping for details gives users quick access
to full transaction information without cluttering the table with
every field.

**Independent Test**: Tap an expense row for "Groceries" at $50 on
May 24. The floating form MUST show: amount $50, date May 24, type
Expense, category Groceries, and the description text.

**Acceptance Scenarios**:

1. **Given** the transactions table is displayed, **When** the user
   taps on a row, **Then** a floating form appears with the full
   transaction details.
2. **Given** the floating details form is open, **When** viewing it,
   **Then** it shows: amount (with sign), date, type (income or
   expense), category/type name, and description.
3. **Given** the floating details form is open, **When** the user taps
   a dismiss/close action, **Then** the form closes and the table is
   visible again.

---

### Edge Cases

- When the description is empty, the row shows "No description" or
  leaves the name field blank
- When the date is very old, it displays in a readable short format
  (e.g., "Jan 5, 2024")
- When there are many entries (100+), the table scrolls smoothly
- Very long transaction names are truncated with an ellipsis
- Tapping between rows quickly opens/closes the detail form without
  leaving stale data

## Requirements *(mandatory)*

### Functional Requirements

- **FR-001**: The main screen layout MUST have three vertical sections:
  balance (001) at top, transactions table in the middle, add buttons
  (002/004) at the bottom.
- **FR-002**: The transactions table MUST display all entries in
  reverse-chronological order (most recent first).
- **FR-003**: Each row MUST show: the amount (with sign for expenses),
  the date (short format), and the transaction name (description or
  type name as fallback).
- **FR-004**: Income rows MUST use a distinct background colour from
  expense rows, making them instantly distinguishable.
- **FR-005**: The table MUST be scrollable when entries exceed the
  available screen space.
- **FR-006**: Tapping a transaction row MUST open a floating form
  (modal or bottom sheet) showing the full details of that entry.
- **FR-007**: The detail form MUST display: amount (with positive or
  negative sign), date, type (income or expense), category/type name,
  and full description.
- **FR-008**: The detail form MUST have a dismiss action (close
  button, tap outside, or back gesture).
- **FR-009**: When no entries exist, a "No transactions yet" message
  MUST be displayed in place of the table.

### Key Entities *(include if feature involves data)*

- **Entry**: Reuses the shared Entry entity from 001-balance-overview.
  No new entities needed — this feature is a read-only view over
  existing data.

## Success Criteria *(mandatory)*

### Measurable Outcomes

- **SC-001**: A user can see all their transactions in the table
  immediately on opening the app (no extra navigation needed).
- **SC-002**: Income and expense rows are visually distinguishable at
  a glance (under 1 second).
- **SC-003**: A user can view full transaction details by tapping any
  row, with the details appearing within 500ms.
- **SC-004**: The table scrolls smoothly at 60 fps with 100+ entries.
- **SC-005**: The detail form displays all fields correctly for every
  entry tapped.

## Assumptions

- This feature integrates into the main screen layout between 001
  (balance) and 002/004 (add buttons) — no separate navigation needed.
- The table replaces the mini recent-entries list from 001 (or
  the mini-list becomes redundant).
- Income rows use a subtle green tint; expense rows use a subtle red
  tint. Tints are light enough to keep text readable.
- The floating detail form is a modal bottom sheet using
  `showModalBottomSheet` (same pattern as 002, 003, 004).
- No search, filter, or sorting controls are included in this version.
- No edit or delete via the detail form in this version.
