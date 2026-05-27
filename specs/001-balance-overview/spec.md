# Feature Specification: Balance Overview

**Feature Branch**: `001-balance-overview`

**Created**: 2026-05-24

**Status**: Draft

**Input**: User description: "the user should be able to see at first sight the balance of the total money it has"

## User Scenarios & Testing *(mandatory)*

### User Story 1 - View Total Balance at a Glance (Priority: P1)

The user opens the money tracker app and immediately sees their total
financial balance displayed prominently. The balance is calculated as
total income minus total expenses from all recorded entries.

**Why this priority**: This is the core purpose of the app — knowing
your financial position instantly. Every other feature builds on this.

**Independent Test**: Open the app with a set of pre-recorded entries
(3 incomes totalling 500, 2 expenses totalling 200). The balance shown
MUST be 300.

**Acceptance Scenarios**:

1. **Given** the app has no entries, **When** the user opens the app,
   **Then** the displayed balance is 0.
2. **Given** there are income entries summing to X and expense entries
   summing to Y, **When** the user opens the app, **Then** the displayed
   balance is X - Y.
3. **Given** the user views the main screen, **When** entries exist,
   **Then** the balance text is always visible at the top of the screen,
   above the entries list, without needing to scroll.
4. **Given** the user adds a new income or expense entry (from features
   002 or 004), **When** the entry is saved, **Then** the balance updates
   immediately (within 1 second) without manual refresh.
5. **Given** the balance is displayed, **When** its value changes, **Then**
   the text colour remains neutral (no green for positive, no red for
   negative) — only the minus sign indicates a negative balance.

---

### User Story 2 - View Income vs Expense Breakdown (Priority: P2)

The user sees not only the net balance but also the total income and
total expense subtotals, so they understand what drives the balance.

**Why this priority**: The net balance alone doesn't tell the full
story. Seeing the income/expense split gives immediate insight into
spending patterns.

**Independent Test**: With entries that sum to 500 income and 200
expense, the screen MUST display both subtotals (500 and 200) in
addition to the net balance (300).

**Acceptance Scenarios**:

1. **Given** there are multiple income entries, **When** the user views
   the main screen, **Then** a total income amount is displayed.
2. **Given** there are multiple expense entries, **When** the user views
   the main screen, **Then** a total expense amount is displayed.
3. **Given** the user sees the main screen, **Then** income and expense
   totals MUST be visually distinct from each other and from the net
   balance.

---

### User Story 3 - View Recent Entries List (Priority: P3)

The user sees a chronological list of their most recent entries
(expenses and incomes) below the balance overview, so they can
quickly verify what contributes to the current balance.

**Why this priority**: Provides transparency and trust — users can
confirm the balance is correct by scanning recent transactions.

**Independent Test**: With 5 entries recorded (3 most recent visible),
the list MUST display the 3 most recent entries with amount, type
(income/expense), and description.

**Acceptance Scenarios**:

1. **Given** there are entries recorded, **When** the user scrolls the
   main screen, **Then** the most recent entries are visible in
   reverse-chronological order.
2. **Given** an entry is an expense, **When** displayed in the list,
   **Then** its amount appears with a negative indicator.
3. **Given** an entry is an income, **When** displayed in the list,
   **Then** its amount appears with a positive indicator.
4. **Given** there are more entries than fit on screen, **When** the
   user scrolls, **Then** older entries become visible.

---

### Edge Cases

- When the balance is exactly 0, display "0.00" with neutral styling
- When the balance goes from positive to negative (or vice versa) after
  adding an entry, the text colour remains neutral — only the minus
  sign changes
- When entries have very large amounts (e.g., millions), the display
  handles formatting without overflow or truncation
- When entries have decimal amounts (e.g., 12.34), the display shows up
  to 2 decimal places
- When many entries exist, the balance remains pinned at the top while
  the entries list scrolls beneath it

## Requirements *(mandatory)*

### Functional Requirements

- **FR-001**: The app MUST display the net balance (total income minus
  total expenses) on the main screen.
- **FR-002**: The net balance MUST be positioned at the top of the main
  screen, above the income/expense breakdown and entries list, and
  MUST remain visible without scrolling.
- **FR-003**: The app MUST calculate the balance dynamically from all
  stored entries.
- **FR-004**: A negative balance MUST show a minus sign before the
  amount, but MUST NOT use colour changes (red/green) to indicate
  sign — the text colour MUST remain neutral at all times.
- **FR-005**: The app MUST display total income and total expense
  subtotals separately from the net balance.
- **FR-006**: Income and expense subtotals MUST be visually distinct
  from each other.
- **FR-007**: The app MUST display a scrollable list of recent entries
  in reverse-chronological order.
- **FR-008**: Each entry in the list MUST show: amount, type (income or
  expense), and description.
- **FR-009**: Expense amounts in the list MUST display with a negative
  indicator; income amounts with a positive indicator.
- **FR-010**: Entry data MUST be persisted locally on the device so the
  balance and entries are preserved across app restarts.
- **FR-011**: The balance MUST update in real-time (within 1 second)
  whenever a new income or expense entry is added, without requiring
  the user to refresh or restart the app.
- **FR-012**: The balance text MUST use a clean, easy-to-read font with
  appropriate size and spacing, making it pleasant to view regardless
  of the value displayed.

### Key Entities *(include if feature involves data)*

- **Entry**: A single financial record representing either an income or
  an expense. Key attributes: amount (positive decimal), type (income or
  expense), description (free text), category (e.g., Food, Salary,
  Transport), date (when the entry occurred), and a unique identifier.
- **Balance**: A computed value (not stored) derived by summing all
  income entry amounts and subtracting all expense entry amounts.

## Success Criteria *(mandatory)*

### Measurable Outcomes

- **SC-001**: The user can determine their net balance within 1 second
  of opening the app, without scrolling or tapping — balance is always
  visible at the top.
- **SC-002**: The displayed balance is always mathematically correct:
  total income minus total expenses, for any combination of entries.
- **SC-003**: The user can identify at least 3 individual entries that
  contributed to the balance, without leaving the main screen.
- **SC-004**: The user can distinguish income from expense totals at a
  glance (under 1 second).
- **SC-005**: The balance updates within 1 second after adding a new
  income or expense entry (no manual refresh, no restart needed).
- **SC-006**: The balance text colour is always neutral regardless of
  whether the value is positive or negative.
- **SC-007**: The balance and its breakdown remain accurate after the
  app is closed and reopened (persistence verified).

## Assumptions

   - The app will have a pre-populated set of entries for development and
   testing purposes; entry creation (adding, editing, deleting) is out of
   scope for this feature and will be delivered separately, but the
   balance MUST update in real-time when entries are added by other
   features (002, 004).
- The app targets individual personal finance tracking (single user, no
  multi-account or shared finances).
- The default currency is the user's locale-based currency (e.g., USD,
  EUR). Currency symbol formatting follows system locale.
- Entry descriptions are plain text, not exceeding 200 characters.
- The app runs on mobile devices (phone/tablet) with portrait
  orientation as the primary layout.
- All data is stored locally on the device; no network or cloud
  synchronization is required.
