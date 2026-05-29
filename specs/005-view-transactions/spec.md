# Feature Specification: View Transactions

**Feature Branch**: `005-view-transactions`

**Created**: 2026-05-24

**Status**: Draft

**Input**: User description: "view incomes and expenses in a scrollable table with search and filter"

## User Scenarios & Testing *(mandatory)*

### User Story 1 - View All Transactions in a Scrollable Table (Priority: P1)

The user opens a dedicated transactions view that lists all income and
expense entries in a scrollable table, separate from the balance
display. Income rows and expense rows use different colours so the
user can distinguish them at a glance.

**Why this priority**: A full transaction table is the primary tool
for reviewing financial history. The mini-list on the main screen
(001) shows only recent entries — this gives complete visibility.

**Independent Test**: With 10 entries (4 incomes, 6 expenses), the
table MUST display all 10 rows. Income rows MUST have a different
background colour than expense rows.

**Acceptance Scenarios**:

1. **Given** the user navigates to the transactions view, **When**
   the view loads, **Then** all entries (both incomes and expenses)
   are displayed in a scrollable table.
2. **Given** the table is displayed, **When** looking at a row,
   **Then** it shows: type indicator, amount, description, category,
   and date.
3. **Given** an income entry exists, **When** displayed in the table,
   **Then** its row uses a distinct colour (e.g., green tint) to
   indicate it is income.
4. **Given** an expense entry exists, **When** displayed in the table,
   **Then** its row uses a distinct colour (e.g., red tint) to
   indicate it is expense.
5. **Given** the table has more entries than fit on screen, **When**
   the user scrolls, **Then** older entries become visible.
6. **Given** there are no entries, **When** the user opens the
   transactions view, **Then** a message "No transactions yet" is
   displayed instead of an empty table.

---

### User Story 2 - Search Transactions by Description (Priority: P2)

The user types text into a search field and the table filters to show
only entries whose description contains the typed text.

**Why this priority**: Finding a specific transaction by description
is the most common search pattern (e.g., "find that grocery trip").

**Independent Test**: With entries containing "Groceries", "Rent", and
"Salary", searching for "gro" MUST show only the "Groceries" entry.
Search is case-insensitive.

**Acceptance Scenarios**:

1. **Given** the transactions view is open, **When** the user types
   text into the search field, **Then** the table filters to show
   only entries whose description contains the search text.
2. **Given** the search field has text, **When** the search matches
   no entries, **Then** a "No matching transactions" message is shown.
3. **Given** the search field has text, **When** the user clears it,
   **Then** the table returns to showing all entries.
4. **Given** the user searches for a description, **When** the search
   is active, **Then** it is case-insensitive (e.g., "groceries"
   matches "Groceries").

---

### User Story 3 - Filter Transactions by Amount (Priority: P3)

The user filters the table to show only entries with amounts greater
than or less than a specific value. The user selects a comparison
operator (greater than or less than) and enters a value.

**Why this priority**: Amount-based filtering helps find large
transactions (e.g., "show all expenses > $500") or small ones.

**Independent Test**: With entries of 10, 50, 100, and 500, filter
"greater than 50" MUST show 100 and 500. Filter "less than 100" MUST
show 10 and 50.

**Acceptance Scenarios**:

1. **Given** the transactions view is open, **When** the user selects
   "Greater than" and enters a value (e.g., 200), **Then** only
   entries with amount > 200 are shown.
2. **Given** the transactions view is open, **When** the user selects
   "Less than" and enters a value (e.g., 50), **Then** only entries
   with amount < 50 are shown.
3. **Given** an amount filter is active, **When** the user changes
   the comparison operator or value, **Then** the table updates
   immediately.
4. **Given** an amount filter is active, **When** the user clears it,
   **Then** the table returns to showing all entries.
5. **Given** the amount filter is combined with a text search,
   **When** both are active, **Then** entries matching BOTH
   conditions are shown.

---

### Edge Cases

- When the user enters a non-numeric value in the amount filter, the
  app shows a validation error and does not apply the filter
- When the amount filter value is 0, "greater than 0" shows all
  positive entries; "less than 0" shows no entries (all amounts are
  positive)
- When the user types very quickly in the search field, the filter
  updates without delay or missed keystrokes
- The table handles very long descriptions (200 chars) without layout
  breakage — text is truncated with an ellipsis if needed
- Income and expense colours respect the user's earlier requirement
  for the balance itself (001) to have neutral colour — the table rows
  use subtle tints, not the balance text colour

## Requirements *(mandatory)*

### Functional Requirements

- **FR-001**: The app MUST provide a dedicated transactions view
  accessible from the main screen (e.g., via a tab or navigation
  button).
- **FR-002**: The transactions view MUST display all entries in a
  scrollable list/table, separate from the balance display.
- **FR-003**: The table MUST show for each entry: amount, type
  (income/expense), description, category (if set), and date.
- **FR-004**: Income rows MUST use a different background colour than
  expense rows, making them instantly distinguishable.
- **FR-005**: The table MUST be sorted in reverse-chronological order
  (most recent first) by default.
- **FR-006**: The user MUST be able to search entries by description
  text — table filters as the user types.
- **FR-007**: The text search MUST be case-insensitive.
- **FR-008**: The user MUST be able to filter entries by amount using
  a comparison operator: "Greater than" or "Less than".
- **FR-009**: The amount filter MUST accept a numeric value and show
  only entries where the amount matches the comparison.
- **FR-010**: The text search and amount filter MUST work together
  (AND logic — both conditions must match).
- **FR-011**: When no entries match the current filter, a clear
  "No matching transactions" message MUST be shown.
- **FR-012**: When the filter returns results, the count of matching
  results MAY be displayed.
- **FR-013**: Clearing the search field or amount filter MUST restore
  the full entries list immediately.

### Key Entities *(include if feature involves data)*

- **Entry**: Reuses the same Entry entity from 001-balance-overview.
  No new entities needed — this feature is a read-only view over
  existing data.

## Success Criteria *(mandatory)*

### Measurable Outcomes

- **SC-001**: A user can view all their transactions in a colour-coded
  scrollable table within 1 second of navigating to the view.
- **SC-002**: A user can find a specific transaction by typing 3+
  characters of its description in under 5 seconds.
- **SC-003**: A user can filter transactions above or below an amount
  threshold in under 10 seconds.
- **SC-004**: Search and filter results update within 500ms of the
  user changing a filter value.
- **SC-005**: Income and expense rows are visually distinguishable at
  a glance (under 1 second) without reading the amount or type label.

## Assumptions

- This feature builds on the shared Entry data model and
  EntryRepository from 001-balance-overview.
- The transactions view is a separate screen/page, not an expansion
  of the main screen's mini-list.
- Income rows use a subtle green tint; expense rows use a subtle red
  tint. Tints are light enough to keep text readable.
- The amount filter supports one comparison at a time (either greater
  than OR less than), not a range (between X and Y).
- No sorting options are needed in this version (always reverse-
  chronological).
- The table does not support editing or deleting entries in this
  version — that will be a future feature.
