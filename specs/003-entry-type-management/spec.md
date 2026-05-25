# Feature Specification: Entry Type Management

**Feature Branch**: `003-entry-type-management`

**Created**: 2026-05-24

**Status**: Draft

**Input**: User description: "create expense types and income types with fixed and variable values"

## User Scenarios & Testing *(mandatory)*

### User Story 1 - Create a Fixed Expense Type (Priority: P1)

The user creates a new expense type that has a fixed amount (e.g.,
"Rent" at $1000). When adding this expense later, the amount is
already set and does not need to be entered each time.

**Why this priority**: Fixed expenses like rent, insurance, and
subscriptions are common recurring costs. Defining them once saves
time and ensures consistency.

**Independent Test**: Create a fixed expense type with name "Rent" and
amount 1000. The type MUST appear in the expense types list with both
name and amount visible, and it MUST be marked as a fixed type.

**Acceptance Scenarios**:

1. **Given** the user is on the types management screen, **When** they
   choose to create a new expense type and select "Fixed", **Then**
   they can enter a name and a fixed amount.
2. **Given** the user has entered a name and a fixed amount, **When**
   they confirm, **Then** the new fixed expense type is saved and
   appears in the expense types list.
3. **Given** a fixed expense type exists, **When** viewed in the types
   list, **Then** it shows the name, the fixed amount, and an
   indicator that it is a fixed type.

---

### User Story 2 - Create a Variable Expense Type (Priority: P1)

The user creates a new expense type where the amount changes each time
(e.g., "Groceries"). When adding this expense later, the user enters
a different amount each time.

**Why this priority**: Most expenses vary month to month. Variable
types cover the majority of spending categories.

**Independent Test**: Create a variable expense type with name
"Groceries". The type MUST appear in the expense types list with the
name visible and marked as a variable type (no fixed amount).

**Acceptance Scenarios**:

1. **Given** the user is on the types management screen, **When** they
   choose to create a new expense type and select "Variable", **Then**
   they can enter a name only (no fixed amount).
2. **Given** the user has entered a name for a variable expense type,
   **When** they confirm, **Then** the new variable expense type is
   saved and appears in the expense types list.
3. **Given** a variable expense type exists, **When** viewed in the
   types list, **Then** it shows the name and an indicator that the
   amount is entered per entry.

---

### User Story 3 - Create an Income Type (Priority: P2)

The user creates a new income type (e.g., "Freelance"). Income types
always have variable amounts — the user specifies the amount each time
they add an income entry.

**Why this priority**: Income sources vary per person. Custom types
let users track different income streams.

**Independent Test**: Create an income type with name "Freelance".
The type MUST appear in the income types list with the name visible.

**Acceptance Scenarios**:

1. **Given** the user is on the types management screen, **When** they
   choose to create a new income type, **Then** they can enter a name.
2. **Given** the user has entered a name for an income type, **When**
   they confirm, **Then** the new income type is saved and appears in
   the income types list.

---

### User Story 4 - Edit or Delete an Existing Type (Priority: P3)

The user can modify the name or fixed amount of an existing type, or
delete a type entirely if it is no longer needed.

**Why this priority**: Types may need correcting (typos, amount
changes) or removing when a category is no longer relevant.

**Independent Test**: Rename "Groceries" to "Supermarket" and verify
the name updates. Delete "Freelance" and verify it no longer appears
in the types list.

**Acceptance Scenarios**:

1. **Given** a type exists, **When** the user selects it and chooses
   edit, **Then** they can modify the name (and fixed amount if
   applicable) and save changes.
2. **Given** a type exists, **When** the user selects it and chooses
   delete, **Then** the type is removed permanently after a
   confirmation step.

---

### Edge Cases

- When the user tries to create two types with the same name, the app
  shows a duplicate name warning and prevents saving
- When the user deletes a type that has associated entries, the entries
  remain but show the type as "Deleted" or "Uncategorised"
- When the user enters a fixed amount of 0 or negative, the app shows
  a validation error
- When the user clears the name field and tries to save, the app shows
  a required-field error
- When the user cancels creation or editing mid-flow, no changes are
  persisted
- Fixed amount must accept up to 2 decimal places

## Requirements *(mandatory)*

### Functional Requirements

- **FR-001**: The app MUST provide a screen or section to manage entry
  types, accessible from the main screen.
- **FR-002**: Users MUST be able to create expense types with two
  variants: fixed (name + amount) and variable (name only).
- **FR-003**: Users MUST be able to create income types with a name
  (amount always variable).
- **FR-004**: A fixed expense type MUST have a non-empty name and a
  positive decimal amount.
- **FR-005**: A variable expense type MUST have a non-empty name and
  no fixed amount.
- **FR-006**: An income type MUST have a non-empty name and no fixed
  amount.
- **FR-007**: The types list MUST clearly distinguish between expense
  types (fixed vs variable) and income types.
- **FR-008**: Fixed expense types MUST display their fixed amount in
  the types list.
- **FR-009**: Users MUST be able to edit the name (any type) and fixed
  amount (fixed expense types only) of existing types.
- **FR-010**: Users MUST be able to delete a type after a confirmation
  prompt.
- **FR-011**: Deleting a type MUST keep existing entries unchanged
  (the type reference in those entries becomes orphaned or shows as
  "Deleted").
- **FR-012**: Duplicate type names within the same category (expense
  or income) MUST be rejected.
- **FR-013**: All types MUST be persisted locally and survive app
  restarts.
- **FR-014**: The types created here MUST be available for selection
  when adding entries in the add-income (002) and future add-expense
  features.

### Key Entities *(include if feature involves data)*

- **ExpenseType**: A category for expenses. Attributes: name (text),
  variant (fixed or variable), fixedAmount (decimal, only for fixed
  variant). Related to entries via type reference.
- **IncomeType**: A category for income. Attributes: name (text),
  always variable. Related to entries via type reference.

## Success Criteria *(mandatory)*

### Measurable Outcomes

- **SC-001**: A user can create a new expense type (fixed or variable)
  in under 20 seconds on their first attempt.
- **SC-002**: A user can create a new income type in under 15 seconds
  on their first attempt.
- **SC-003**: After creating a type, it appears in the appropriate
  list immediately without restarting the app.
- **SC-004**: Editing a type's name or fixed amount updates the type
  immediately without data loss.
- **SC-005**: Deleting a type removes it from the selection list but
  does not remove or alter any entries that used that type.
- **SC-006**: All created types persist correctly after the app is
  closed and reopened.
- **SC-007**: Duplicate type names within the same category are
  rejected 100% of the time.

## Assumptions

- This feature supersedes the hardcoded income types assumed in
  002-add-income-entry. After this feature, types come from user
  definitions rather than a predefined list.
- Types management is accessed via a dedicated section (e.g.,
  "Manage Types" or "Categories") separate from the main balance
  screen.
- Types can be deleted only if the user confirms their intent via a
  confirmation dialog.
- Deleted types on existing entries are shown as "Deleted" or
  "Uncategorised" — the entry's amount and other data remain intact.
- The user is responsible for creating at least one type before they
  can add entries; if no types exist, the add-entry flow prompts the
  user to create one first.
- No bulk operations (import, export, reorder) are needed in this
  version.
