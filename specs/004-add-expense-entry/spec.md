# Feature Specification: Add Expense Entry

**Feature Branch**: `004-add-expense-entry`

**Created**: 2026-05-24

**Status**: Draft

**Input**: User description: "add expense entries from created types with realtime balance update"

## User Scenarios & Testing *(mandatory)*

### User Story 1 - Add a Variable Expense Entry (Priority: P1)

The user taps a button to add an expense, selects a variable expense
type (one where the amount changes each time, e.g., "Groceries"),
enters the amount and a short description, and confirms. The expense
is saved and the balance decreases immediately.

**Why this priority**: Most day-to-day expenses have varying amounts.
This covers the most common spending scenario.

**Independent Test**: Start with a balance of 500. Add a variable
expense of 50 (type: Groceries, description: "Weekly shop"). The
balance MUST immediately show 450 and the entry MUST appear in the
recent entries list.

**Acceptance Scenarios**:

1. **Given** the user is on the main screen, **When** they tap the
   "Add Expense" button, **Then** a list of expense types (both fixed
   and variable) is displayed.
2. **Given** the expense type list is shown, **When** the user selects
   a variable expense type (e.g., Groceries), **Then** the input
   screen for amount and description appears.
3. **Given** the user is on the amount/description screen, **When**
   they enter a valid amount (e.g., 75.50) and a description (e.g.,
   "Dinner out"), **Then** they can confirm and save the entry.
4. **Given** the user confirms a new expense entry, **When** the entry
   is saved, **Then** the main screen balance decreases immediately to
   reflect the expense.
5. **Given** a new expense entry is saved, **When** the user views the
   recent entries list, **Then** the new entry appears at the top with
   its amount, type, and description, showing a negative indicator.

---

### User Story 2 - Add a Fixed Expense Entry (Priority: P2)

The user taps the add expense button, selects a fixed expense type
(one with a preset amount, e.g., "Rent" at $1000), enters a short
description, and confirms. The amount is pre-filled and does not need
to be typed.

**Why this priority**: Fixed expenses like rent and subscriptions are
common. Pre-filling the amount saves time and prevents entry errors.

**Independent Test**: Start with a balance of 1500. Add a fixed
expense of 1000 (type: Rent, description: "May rent"). The balance
MUST immediately show 500 — the user did NOT have to type the 1000.

**Acceptance Scenarios**:

1. **Given** the expense type list is shown, **When** the user selects
   a fixed expense type (e.g., Rent with amount 1000), **Then** the
   input screen appears with the amount pre-filled to 1000.
2. **Given** the amount is pre-filled for a fixed expense, **When**
   the user enters an optional description and confirms, **Then** the
   entry is saved with the pre-filled amount.
3. **Given** a fixed expense is saved, **When** the balance updates,
   **Then** it decreases by the fixed amount.

---

### User Story 3 - Cancel or Abort Adding an Expense (Priority: P3)

The user can cancel adding an expense at any point — from the type
selection screen or the amount/description screen — without saving any
data.

**Why this priority**: Users may change their mind or need to verify
information before committing an expense.

**Independent Test**: Start the add expense flow, select a type, enter
some data, then tap cancel. No entry is saved and the balance is
unchanged.

**Acceptance Scenarios**:

1. **Given** the user is on the type selection screen, **When** they
   tap a back/cancel button, **Then** they return to the main screen
   and no entry is created.
2. **Given** the user is on the amount/description screen, **When**
   they tap a back/cancel button, **Then** they return to the main
   screen and no entry is created.

---

### Edge Cases

- When no expense types have been created yet, the add expense flow
  shows a message prompting the user to create an expense type first
- When the user enters an amount of 0 or a negative number for a
  variable expense, the app shows a validation error and prevents
  saving
- When the user enters a very large amount (e.g., 999999999.99), the
  app accepts and displays it without formatting issues
- When the description exceeds the maximum length, the app shows a
  character limit warning
- When the description is left empty, the entry is still saved
- When the user is in the add flow and the app is backgrounded, no
  partial data is persisted

## Requirements *(mandatory)*

### Functional Requirements

- **FR-001**: The main screen MUST have a clearly visible button to
  add a new expense entry.
- **FR-002**: Tapping the add expense button MUST display a list of
  all created expense types, clearly showing which are fixed and which
  are variable.
- **FR-003**: Selecting a variable expense type MUST show an input
  form with fields for amount (required) and description (optional).
- **FR-004**: Selecting a fixed expense type MUST show an input form
  with the amount pre-filled to the type's fixed amount and a
  description field (optional).
- **FR-005**: The amount field for variable expenses MUST accept
  positive decimal numbers with up to 2 decimal places.
- **FR-006**: The pre-filled amount for fixed expenses MUST NOT be
  editable by the user (it is defined by the type).
- **FR-007**: The description field MUST accept plain text up to 200
  characters.
- **FR-008**: The user MUST be able to confirm and save, or cancel and
  return to the main screen at any point.
- **FR-009**: After saving, the entry MUST be persisted locally and
  survive app restarts.
- **FR-010**: After saving, the main screen balance MUST decrease
  immediately to reflect the expense.
- **FR-011**: After saving, the new entry MUST appear at the top of
  the recent entries list with a negative indicator on its amount.
- **FR-012**: The app MUST validate that the amount is a positive
  number before allowing save.
- **FR-013**: A zero or negative amount MUST show an error message and
  prevent saving.
- **FR-014**: If no expense types exist, the add expense flow MUST
  inform the user and direct them to create types first.

### Key Entities *(include if feature involves data)*

- **Entry**: Extends the Entry entity from 001-balance-overview.
  An expense entry has: type (reference to a user-created ExpenseType
  from 003), amount (positive decimal; pre-filled from type if fixed),
  description (text, optional), date (auto-recorded timestamp), and a
  unique identifier.

## Success Criteria *(mandatory)*

### Measurable Outcomes

- **SC-001**: A user can add a variable expense (button tap through
  confirmation) in under 30 seconds on their first attempt.
- **SC-002**: A user can add a fixed expense in under 20 seconds
  (amount is pre-filled, fewer steps).
- **SC-003**: After adding an expense, the displayed balance decreases
  within 1 second (no manual refresh needed).
- **SC-004**: The new expense appears in the recent entries list
  immediately after saving, with a negative amount indicator.
- **SC-005**: Invalid inputs (zero, negative, non-numeric) are
  rejected with a clear error message 100% of the time.
- **SC-006**: Fixed expense amounts are always correct (match the
  type's fixed amount) and cannot be accidentally changed by the user.
- **SC-007**: All saved expense entries persist correctly after the
  app is closed and reopened.

## Assumptions

- This feature builds on 001-balance-overview (balance display and
  entries list) and 003-entry-type-management (user-created expense
  types with fixed/variable distinction).
- If 003-entry-type-management is not yet implemented, this feature
  assumes at least one expense type exists (for testing/development).
- Fixed expense amounts are read-only at entry time — the user cannot
  override them. To change the amount, the user edits the type itself.
- The date of the entry is automatically set to the current date and
  time when saved (not user-selectable in this version).
- The add expense flow mirrors the add income flow (002) in structure
  but is a separate button/entry point.
