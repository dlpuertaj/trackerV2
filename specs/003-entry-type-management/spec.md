# Feature Specification: Entry Type Management

**Feature Branch**: `003-entry-type-management`

**Created**: 2026-05-24

**Status**: Draft

**Input**: User description: "create expense types and income types with fixed and variable values"

## User Scenarios & Testing *(mandatory)*

### User Story 1 - Create an Expense Type via Tap-Hold (Priority: P1)

The user tap-holds the "Add Expense" button (from 004) to create a
new expense type instead of adding an entry. A floating form appears
with: a text field for the type name, a toggle for "Fixed value", a
value field (enabled only when Fixed is toggled on), a Create button,
and a Cancel button. After creation, the new type is immediately
available in the expense type dropdown when adding the next expense.

**Why this priority**: Custom types are essential — users need to
define their own expense categories before they can add expenses.

**Independent Test**: Tap-hold the "Add Expense" button. Enter name
"Rent", toggle Fixed on, enter amount 1000, tap Create. The new type
appears in the expense dropdown when tapping Add Expense again.

**Acceptance Scenarios**:

1. **Given** the user is on the transactions table (005), **When**
   they tap-hold the "Add Expense" button, **Then** a floating form
   appears for creating a new expense type (not adding an entry).
2. **Given** the expense type form is open, **When** the Fixed toggle
   is off, **Then** the value field is hidden or disabled.
3. **Given** the expense type form is open, **When** the Fixed toggle
   is on, **Then** the value field becomes enabled for input.
4. **Given** the expense type form is open, **When** the user enters
   a name and taps Create, **Then** the type is saved and immediately
   available in the expense type dropdown.
5. **Given** the expense type form is open, **When** the user taps
   Cancel, **Then** the form closes and no type is created.

---

### User Story 2 - Create an Income Type via Tap-Hold (Priority: P2)

The user tap-holds the "Add Income" button (from 002) to create a new
income type. A floating form appears with: a text field for the type
name, a Create button, and a Cancel button. Income types always have
variable amounts, so no fixed toggle or value field is needed.

**Why this priority**: Custom income types let users track different
income streams.

**Independent Test**: Tap-hold the "Add Income" button. Enter name
"Freelance", tap Create. The new type appears in the income dropdown
when tapping Add Income again.

**Acceptance Scenarios**:

1. **Given** the user is on the transactions table (005), **When**
   they tap-hold the "Add Income" button, **Then** a floating form
   appears for creating a new income type with just a name field.
2. **Given** the income type form is open, **When** the user enters
   a name and taps Create, **Then** the type is saved and immediately
   available in the income type dropdown.
3. **Given** the income type form is open, **When** the user taps
   Cancel, **Then** the form closes and no type is created.

---

### Edge Cases

- When the user enters a blank name and taps Create, validation error
  shows "Name is required"
- When the user enters a duplicate name (same category), validation
  error shows "A type with this name already exists"
- When the user enters a fixed amount of 0 or negative, validation
  error shows "Amount must be positive"
- When the user enters a fixed amount with more than 2 decimal places,
  the app rounds or shows a validation error
- Tapping Cancel at any point discards the form and returns to the
  transactions table

## Requirements *(mandatory)*

### Functional Requirements

- **FR-001**: Tap-holding the "Add Expense" button (from 004) MUST
  open a floating form to create a new expense type (instead of adding
  an expense entry).
- **FR-002**: Tap-holding the "Add Income" button (from 002) MUST open
  a floating form to create a new income type.
- **FR-003**: Short-tapping these buttons MUST still open the
  respective add-entry forms (002, 004) — tap-hold is the only way to
  create types.
- **FR-004**: The expense type form MUST contain: a name text field,
  a "Fixed value" toggle, a value field (enabled only when toggle is
  on), a Create button, and a Cancel button.
- **FR-005**: The income type form MUST contain: a name text field, a
  Create button, and a Cancel button (no toggle, no value field).
- **FR-006**: A fixed expense type MUST have a non-empty name and a
  positive decimal amount.
- **FR-007**: A variable expense type MUST have a non-empty name and
  no fixed amount value.
- **FR-008**: An income type MUST have a non-empty name (always
  variable).
- **FR-009**: Duplicate type names within the same category (expense
  or income) MUST be rejected with an error message.
- **FR-010**: After creation, the new type MUST be immediately
  available in the respective type dropdown without restarting the
  app.
- **FR-011**: All types MUST be persisted locally and survive app
  restarts.
- **FR-012**: Tapping Cancel MUST close the form without saving.

### Key Entities *(include if feature involves data)*

- **ExpenseType**: A category for expenses. Attributes: name (text),
  isFixed (boolean), fixedAmount (decimal, only relevant if isFixed).
  Related to expense entries via type reference.
- **IncomeType**: A category for income. Attributes: name (text),
  always variable. Related to income entries via type reference.

## Success Criteria *(mandatory)*

### Measurable Outcomes

- **SC-001**: A user can create a new expense type (fixed or variable)
  via tap-hold in under 20 seconds.
- **SC-002**: A user can create a new income type via tap-hold in
  under 15 seconds.
- **SC-003**: After creating a type, it appears in the dropdown
  immediately without restarting the app.
- **SC-004**: The new type is usable in the next add-entry flow
  without any additional steps.
- **SC-005**: Duplicate names within the same category are rejected
  100% of the time.
- **SC-006**: All created types persist correctly after the app is
  closed and reopened.

## Assumptions

- This feature integrates with 002-add-income-entry and
  004-add-expense-entry — the Add Income and Add Expense buttons
  support both short-tap (add entry) and tap-hold (create type).
- No dedicated types management screen exists — types are created
  on-the-fly via tap-hold on the respective buttons.
- Edit and delete of existing types is not included in this version
  (may be added later via a dedicated management screen).
- The floating form is a modal bottom sheet using
  `showModalBottomSheet` (same pattern as 002 and 004).
- New types are stored in a shared `TypeRepository` that both the
  income and expense forms can access.
