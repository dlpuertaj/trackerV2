# Research: Add Expense Entry

## Decisions

### Form Presentation
- **Decision**: Bottom sheet (`showModalBottomSheet`), same pattern
  as 002-add-income-entry.
- **Rationale**: Consistent UX across income and expense flows.
  Built-in Flutter widget — no external dependency.

### Fixed vs Variable Type Handling
- **Decision**: When user selects a type from the dropdown, check if
  it's fixed or variable. If fixed: pre-fill the amount field with
  the type's fixedAmount. If variable: leave amount field empty.
- **Rationale**: The type metadata (fixed/variable) is stored in the
  ExpenseType entity from 003-entry-type-management. The dropdown
  shows the type name and a "(Fixed)" or "(Variable)" label.

### Validation Strategy
- **Decision**: Validate on Save tap (not per keystroke). Same as 002.
- **Rationale**: Consistent UX with income flow.

### Success Popup
- **Decision**: Same `AlertDialog` pattern as 002 — "Expense Added
  Successfully" with updated balance and "OK" button.
- **Rationale**: Consistent UX.

### Persistence
- **Decision**: Use same `EntryRepository.addEntry()` as 002.
- **Rationale**: Single shared data layer. No duplication.

## Alternatives Considered

| Alternative | Rejected Because |
|-------------|-----------------|
| Locked amount for fixed types | User wants it editable (pre-filled, not locked) |
| Separate page for expense form | Breaks context — bottom sheet is better |
| Different popup from income | Should be consistent — same pattern, different text |
