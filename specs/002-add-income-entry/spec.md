# Feature Specification: Add Income Entry

**Feature Branch**: `002-add-income-entry`

**Created**: 2026-05-24

**Status**: Draft

**Input**: User description: "add an income amount with types and realtime balance update"

## User Scenarios & Testing *(mandatory)*

### User Story 1 - Add a New Income Entry (Priority: P1)

The user taps a button to add income, selects a type from a list of
options (e.g., salary, loan, investment), enters the amount, writes a
short description, and confirms. The new income is saved and the
balance updates immediately so the user sees the result right away.

**Why this priority**: Without the ability to add income, the app
cannot track money coming in. This is the second core feature after
viewing the balance.

**Independent Test**: Start with a balance of 0. Add an income entry
of 500 (type: Salary, description: "Monthly pay"). The balance MUST
immediately show 500 and the entry MUST appear in the recent entries
list.

**Acceptance Scenarios**:

1. **Given** the user is on the main screen, **When** they tap the
   "Add Income" button, **Then** a list of income types is displayed.
2. **Given** the income type list is shown, **When** the user selects
   a type (e.g., Salary), **Then** the input screen for amount and
   description appears.
3. **Given** the user is on the amount/description screen, **When**
   they enter a valid amount (e.g., 1500.00) and a description (e.g.,
   "Freelance project"), **Then** they can confirm and save the entry.
4. **Given** the user confirms a new income entry, **When** the entry
   is saved, **Then** the main screen balance updates immediately to
   reflect the new total.
5. **Given** a new income entry is saved, **When** the user views the
   recent entries list, **Then** the new entry appears at the top with
   its amount, type, and description.
6. **Given** the user is in the middle of adding income, **When** they
   tap a cancel/back button, **Then** no entry is saved and the user
   returns to the main screen.

---

### Edge Cases

- When the user enters an amount of 0 or a negative number, the app
  shows a validation error and prevents saving
- When the user enters a very large amount (e.g., 999999999.99), the
  app accepts and displays it without formatting issues
- When the user enters a description longer than the maximum allowed
  length, the app shows a character limit warning
- When the user enters an amount with more than 2 decimal places (e.g.,
  12.345), the app rounds or rejects with a validation message
- When the user leaves the description empty, the entry is still saved
  (description is optional)
- When the user taps the add button but then navigates away (app
  backgrounded, phone call), no partial data is persisted

## Requirements *(mandatory)*

### Functional Requirements

- **FR-001**: The main screen MUST have a clearly visible button to
  add a new income entry.
- **FR-002**: Tapping the add income button MUST display a list of
  income types for the user to choose from.
- **FR-003**: The app MUST support at least the following income types:
  Salary, Loan, Investment, Gift, Other.
- **FR-004**: After selecting an income type, the app MUST show an
  input form with fields for amount (required) and description
  (optional).
- **FR-005**: The amount field MUST accept positive decimal numbers
  with up to 2 decimal places.
- **FR-006**: The description field MUST accept plain text up to 200
  characters.
- **FR-007**: The user MUST be able to confirm and save the entry, or
  cancel and return to the main screen at any point.
- **FR-008**: After saving, the entry MUST be persisted locally so it
  survives app restarts.
- **FR-009**: After saving, the main screen balance MUST update
  immediately to reflect the new total.
- **FR-010**: After saving, the new entry MUST appear at the top of the
  recent entries list on the main screen.
- **FR-011**: The app MUST validate that the amount is a positive
  number before allowing save.
- **FR-012**: A zero or negative amount MUST show an error message and
  prevent saving.

### Key Entities *(include if feature involves data)*

- **Entry**: Extends the Entry entity from 001-balance-overview.
  An income entry has: type (one of the predefined income types),
  amount (positive decimal), description (text, optional), date
  (auto-recorded timestamp), and a unique identifier.
- **IncomeType**: A predefined set of categories (Salary, Loan,
  Investment, Gift, Other) that classifies the source of income.

## Success Criteria *(mandatory)*

### Measurable Outcomes

- **SC-001**: A user can complete the add-income flow (button tap
  through confirmation) in under 30 seconds on their first attempt.
- **SC-002**: After adding an income entry, the balance displayed on
  the main screen updates within 1 second (no manual refresh needed).
- **SC-003**: The new income entry appears in the recent entries list
  immediately after saving, without restarting the app.
- **SC-004**: Invalid inputs (zero, negative, non-numeric) are rejected
  with a clear error message 100% of the time.
- **SC-005**: All saved income entries persist correctly after the app
  is closed and reopened.

## Assumptions

- This feature builds on top of 001-balance-overview: the balance
  display and entries list already exist on the main screen.
- Currency handling follows the same locale-based approach as the
  balance feature.
- The user always has the latest version of 001-balance-overview
  installed (the entry data model is shared).
- Income types are fixed at development time (not user-customizable in
  this version). Custom types will be a future enhancement.
- The description field is optional — the user may leave it blank and
  still save the entry.
- The date of the entry is automatically set to the current date and
  time when saved (not user-selectable in this version).
