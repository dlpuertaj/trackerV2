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
3. **Given** the balance is a positive number, **When** the user views
   the main screen, **Then** the balance is visually emphasised (larger
   font, distinct styling) so it is the first thing noticed.
4. **Given** the balance is a negative number, **When** the user views
   the main screen, **Then** the balance is shown with a negative
   indicator (e.g., minus sign, red colour) to clearly convey debt.

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

- When the balance is exactly 0, display clearly "0.00" with neutral
  styling (neither positive nor negative)
- When only expenses exist (no income), the balance is negative and
  shows as such
- When only income exists (no expenses), the balance is positive
- When entries have very large amounts (e.g., millions), the display
  handles formatting without overflow or truncation
- When entries have decimal amounts (e.g., 12.34), the display shows up
  to 2 decimal places

## Requirements *(mandatory)*

### Functional Requirements

- **FR-001**: The app MUST display the net balance (total income minus
  total expenses) on the main screen.
- **FR-002**: The net balance MUST be the most visually prominent
  element on the main screen.
- **FR-003**: The app MUST calculate the balance dynamically from all
  stored entries.
- **FR-004**: A negative balance MUST be visually distinct from a
  positive balance (colour, sign, or both).
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

### Key Entities *(include if feature involves data)*

- **Entry**: A single financial record representing either an income or
  an expense. Key attributes: amount (positive decimal), type (income or
  expense), description (free text), category (e.g., Food, Salary,
  Transport), date (when the entry occurred), and a unique identifier.
- **Balance**: A computed value (not stored) derived by summing all
  income entry amounts and subtracting all expense entry amounts.

## Success Criteria *(mandatory)*

### Measurable Outcomes

- **SC-001**: The user can determine their net balance within 2 seconds
  of opening the app, without scrolling or tapping.
- **SC-002**: The displayed balance is always mathematically correct:
  total income minus total expenses, for any combination of entries.
- **SC-003**: The user can identify at least 3 individual entries that
  contributed to the balance, without leaving the main screen.
- **SC-004**: The user can distinguish income from expense totals at a
  glance (under 1 second).
- **SC-005**: The balance and its breakdown remain accurate after the
  app is closed and reopened (persistence verified).

## Assumptions

- The app will have a pre-populated set of entries for development and
  testing purposes; entry creation (adding, editing, deleting) is out of
  scope for this feature and will be delivered separately.
- The app targets individual personal finance tracking (single user, no
  multi-account or shared finances).
- The default currency is the user's locale-based currency (e.g., USD,
  EUR). Currency symbol formatting follows system locale.
- Entry descriptions are plain text, not exceeding 200 characters.
- The app runs on mobile devices (phone/tablet) with portrait
  orientation as the primary layout.
- All data is stored locally on the device; no network or cloud
  synchronization is required.
