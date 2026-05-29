# Feature Specification: Add Expense Entry

**Feature Branch**: `004-add-expense-entry`

**Created**: 2026-05-24

**Status**: Draft

**Input**: User description: "add expense entries from created types with realtime balance update"

## User Scenarios & Testing *(mandatory)*

### User Story 1 - Add a Variable Expense Entry via Floating Form (Priority: P1)

The user taps an "Add Expense" button at the bottom of the
transactions table (005), next to the Add Income button. A floating
form appears with: a dropdown to select the expense type, a text
field for the amount, a text area for an optional description, a
Save button, and a Cancel button. Only the type and amount are
mandatory. On save, the app validates, stores the expense, updates
the balance, and shows a success popup.

**Why this priority**: Most day-to-day expenses have varying amounts.
This covers the most common spending scenario.

**Independent Test**: Start with a balance of 500. Tap "Add Expense"
at the bottom of the transactions table. Select a variable type (e.g.,
Groceries), enter amount 50, enter description "Weekly shop", tap
Save. Popup MUST show "Expense added successfully" with updated
balance (450). The entry MUST appear in the transactions table.

**Acceptance Scenarios**:

1. **Given** the user is viewing the transactions table (005),
   **When** they tap the "Add Expense" button at the bottom, **Then**
   a floating form appears with: type dropdown, amount field,
   description text area, Save button, and Cancel button.
2. **Given** the floating form is open with a variable type selected,
   **When** the user enters a valid amount and optional description,
   **Then** the description field is optional and can be left blank.
3. **Given** the floating form is open, **When** the user enters an
   amount of 0 or a negative number and taps Save, **Then** a
   validation error is shown and the entry is not saved.
4. **Given** the floating form is open, **When** the user does not
   select a type and taps Save, **Then** a validation error is shown.
5. **Given** the floating form has valid data, **When** the user taps
   Save, **Then** the expense is stored, the balance decreases, and
   the form closes.
6. **Given** the expense is saved successfully, **When** the form
   closes, **Then** a success popup appears showing "Expense added
   successfully" along with the updated balance.

---

### User Story 2 - Add a Fixed Expense Entry (Priority: P2)

The user selects a fixed expense type (e.g., "Rent" at $1000). The
amount field is automatically pre-filled with the type's fixed amount.
The user enters an optional description and taps Save.

**Why this priority**: Fixed expenses like rent and subscriptions are
common. Pre-filling the amount saves time and prevents entry errors.

**Independent Test**: Start with a balance of 1500. Add a fixed
expense (type: Rent, fixed amount: 1000). The amount field is
pre-filled to 1000. Tap Save. Balance shows 500. Success popup
appears.

**Acceptance Scenarios**:

1. **Given** the floating form is open, **When** the user selects a
   fixed expense type (e.g., Rent, amount 1000), **Then** the amount
   field is automatically filled with 1000.
2. **Given** the amount is pre-filled for a fixed expense, **When**
   the user enters an optional description and taps Save, **Then**
   the entry is saved with the pre-filled amount.
3. **Given** a fixed expense is saved, **When** the balance updates,
   **Then** it decreases by the fixed amount.

---

### User Story 3 - Cancel Adding an Expense (Priority: P3)

The user can cancel adding an expense at any point while the floating
form is open by tapping Cancel, without saving any data.

**Why this priority**: Users may change their mind mid-flow.

**Independent Test**: Open the form, select a type, enter some data,
then tap Cancel. No entry is saved. Balance is unchanged.

**Acceptance Scenarios**:

1. **Given** the floating form is open, **When** the user taps Cancel,
   **Then** the form closes and no entry is created.

---

### Edge Cases

- When no expense types exist, the form shows a message directing the
  user to create expense types first
- When the amount is 0 or negative, validation error prevents saving
- When the amount has more than 2 decimal places, app rounds or shows
  error
- When the description exceeds 200 characters, app shows a warning
- When the description is left empty, the entry is still saved
- When the app is backgrounded while the form is open, no partial data
  is persisted

## Requirements *(mandatory)*

### Functional Requirements

- **FR-001**: The transactions table view (005) MUST have an "Add
  Expense" button positioned at the bottom, next to the "Add Income"
  button.
- **FR-002**: Tapping "Add Expense" MUST open a floating form (modal
  or bottom sheet) with: expense type dropdown, amount field,
  description text area, Save button, and Cancel button.
- **FR-003**: The type dropdown MUST display all expense types
  created by the user (from 003-entry-type-management), clearly
  showing which are fixed and which are variable.
- **FR-004**: Selecting a variable expense type leaves amount and
  description fields empty for the user to fill.
- **FR-005**: Selecting a fixed expense type MUST automatically fill
  the amount field with the type's fixed amount.
- **FR-006**: The amount field for fixed expenses MAY be editable
  (pre-filled but not locked).
- **FR-007**: The amount field MUST accept positive decimal numbers
  with up to 2 decimal places.
- **FR-008**: The description text area MUST accept plain text up to
  200 characters and MUST be optional.
- **FR-009**: The type and amount MUST be mandatory — Save MUST show
  validation errors if either is missing or invalid.
- **FR-010**: Tapping Save with valid data MUST persist the entry
  locally and update the UI (balance + transactions table).
- **FR-011**: After successful save, a success popup MUST appear
  showing "Expense added successfully" along with the updated balance.
- **FR-012**: The success popup MUST have a dismiss action (e.g.,
  "OK" button) closing it and returning to the transactions table.
- **FR-013**: Tapping Cancel MUST close the floating form without
  saving any data.
- **FR-014**: The app MUST validate that the amount is a positive
  number before saving.
- **FR-015**: A zero or negative amount MUST show an error message
  and prevent saving.
- **FR-016**: If no expense types exist, the form MUST show a message
  directing the user to create types first.

### Key Entities *(include if feature involves data)*

- **Entry**: Reuses the shared Entry entity from 001-balance-overview.
  An expense entry has: type (reference to an ExpenseType from
  003-entry-type-management), amount (positive decimal; pre-filled
  from type if fixed), description (text, optional), date
  (auto-recorded timestamp), and a unique identifier.

## Success Criteria *(mandatory)*

### Measurable Outcomes

- **SC-001**: A user can add a variable expense (button tap through
  completion popup) in under 30 seconds.
- **SC-002**: A user can add a fixed expense in under 20 seconds
  (amount pre-filled).
- **SC-003**: The success popup appears within 1 second of tapping
  Save.
- **SC-004**: The balance displayed in the success popup matches the
  updated balance in the main view.
- **SC-005**: The new expense entry appears in the transactions table
  immediately after dismissing the success popup.
- **SC-006**: Invalid inputs (zero, negative, non-numeric, no type)
  are rejected with a clear error message 100% of the time.
- **SC-007**: All saved expense entries persist correctly after the
  app is closed and reopened.

## Assumptions

- This feature builds on: 001-balance-overview (balance, shared Entry
  model), 003-entry-type-management (user-created expense types with
  fixed/variable distinction), and 005-view-transactions (transactions
  table with Add Expense button at bottom).
- The floating form is a modal bottom sheet that appears over the
  transactions table.
- The success popup is a simple dialog with an "OK" dismiss button.
- Fixed expense amounts are pre-filled but editable (the user may
  override them at entry time).
- If 003-entry-type-management is not yet implemented, at least one
  hardcoded expense type exists for development/testing.
- The date of the entry is automatically set to the current date and
  time (not user-selectable).
