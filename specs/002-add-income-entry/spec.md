# Feature Specification: Add Income Entry

**Feature Branch**: `002-add-income-entry`

**Created**: 2026-05-24

**Status**: Draft

**Input**: User description: "add an income amount with types and realtime balance update"

## User Scenarios & Testing *(mandatory)*

### User Story 1 - Add a New Income Entry via Floating Form (Priority: P1)

The user taps an "Add Income" button at the bottom of the transactions
table (005). A floating form appears with: a dropdown to select the
income type, a text field for the amount, a text area for an optional
description, a Save button, and a Cancel button. Only the type and
amount are mandatory. On save, the app validates the amount, stores
the income, updates the balance, and shows a success popup.

**Why this priority**: Without the ability to add income, the app
cannot track money coming in. This is the second core feature after
viewing the balance.

**Independent Test**: Start with a balance of 0. Tap the Add Income
button at the bottom of the transactions table. Select type "Salary",
enter amount 500, enter description "Monthly pay", tap Save. A popup
MUST show "Income added successfully" with the updated balance (500)
and updated transactions list.

**Acceptance Scenarios**:

1. **Given** the user is viewing the transactions table (005),
   **When** they tap the "Add Income" button at the bottom, **Then**
   a floating form appears with: type dropdown, amount field,
   description text area, Save button, and Cancel button.
2. **Given** the floating form is open, **When** the user selects a
   type and enters a valid amount, **Then** the description field is
   optional and can be left blank.
3. **Given** the floating form is open, **When** the user enters an
   amount of 0 or a negative number and taps Save, **Then** a
   validation error is shown and the entry is not saved.
4. **Given** the floating form is open, **When** the user does not
   select a type and taps Save, **Then** a validation error is shown
   and the entry is not saved.
5. **Given** the floating form has valid data, **When** the user taps
   Save, **Then** the income is stored, the balance updates, and the
   form closes.
6. **Given** the income is saved successfully, **When** the form
   closes, **Then** a success popup appears showing "Income added
   successfully" along with the updated balance.
7. **Given** the floating form is open, **When** the user taps Cancel,
   **Then** the form closes and no entry is saved.

---

### Edge Cases

- When the user enters an amount with more than 2 decimal places, the
  app rounds or shows a validation error
- When the user enters a very large amount (e.g., 999999999.99), the
  app accepts and displays it without formatting issues
- When the description exceeds the maximum length, the app shows a
  character limit warning
- When the user taps Add Income but there are no income types created
  yet, the app prompts the user to create an income type first
- When the app is backgrounded while the floating form is open, no
  partial data is persisted

## Requirements *(mandatory)*

### Functional Requirements

- **FR-001**: The transactions table view (005) MUST have an "Add
  Income" button positioned at the bottom, next to the "Add Expense"
  button.
- **FR-002**: Tapping "Add Income" MUST open a floating form (modal or
  overlay) above the current view.
- **FR-003**: The floating form MUST contain: a dropdown to select an
  income type, a text field for the amount, a text area for the
  description (optional), a Save button, and a Cancel button.
- **FR-004**: The type dropdown MUST display all income types created
  by the user (from 003-entry-type-management).
- **FR-005**: The amount field MUST accept positive decimal numbers
  with up to 2 decimal places.
- **FR-006**: The description text area MUST accept plain text up to
  200 characters, and MUST be optional.
- **FR-007**: The type and amount MUST be mandatory — the Save button
  MUST be disabled or show validation errors if either is missing or
  invalid.
- **FR-008**: Tapping Save with valid data MUST persist the entry
  locally and update the UI (balance + transactions table).
- **FR-009**: After successful save, a success popup/dialog MUST
  appear showing "Income added successfully" along with the updated
  balance.
- **FR-010**: The success popup MUST have a dismiss action (e.g.,
  "OK" button) that closes it and returns to the transactions table
  showing the new entry.
- **FR-011**: Tapping Cancel MUST close the floating form without
  saving any data.
- **FR-012**: The app MUST validate that the amount is a positive
  number before allowing save.
- **FR-013**: A zero or negative amount MUST show an error message and
  prevent saving.
- **FR-014**: If no income types exist, the form MUST show a message
  directing the user to create types first.

### Key Entities *(include if feature involves data)*

- **Entry**: Reuses the shared Entry entity from 001-balance-overview.
  An income entry has: type (reference to an IncomeType from
  003-entry-type-management), amount (positive decimal), description
  (text, optional), date (auto-recorded timestamp), and a unique
  identifier.

## Success Criteria *(mandatory)*

### Measurable Outcomes

- **SC-001**: A user can complete the add-income flow (button tap
  through completion popup) in under 30 seconds on their first attempt.
- **SC-002**: The success popup appears within 1 second of tapping
  Save.
- **SC-003**: The balance displayed in the success popup matches the
  updated balance in the main view.
- **SC-004**: The new income entry appears in the transactions table
  immediately after dismissing the success popup.
- **SC-005**: Invalid inputs (zero, negative, non-numeric, no type)
  are rejected with a clear error message 100% of the time.
- **SC-006**: All saved income entries persist correctly after the app
  is closed and reopened.

## Assumptions

- This feature builds on: 001-balance-overview (balance, shared Entry
  model), 003-entry-type-management (user-created income types), and
  005-view-transactions (transactions table with Add Income button at
  bottom).
- The floating form is a modal dialog or bottom sheet that appears
  over the transactions table.
- The success popup is a simple dialog with an "OK" dismiss button.
- If 003-entry-type-management is not yet implemented, income types
  are hardcoded as: Salary, Loan, Investment, Gift, Other.
- The date of the entry is automatically set to the current date and
  time (not user-selectable).
