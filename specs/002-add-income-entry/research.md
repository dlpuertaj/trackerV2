# Research: Add Income Entry

## Decisions

### Form Presentation
- **Decision**: Bottom sheet (`showModalBottomSheet`) for the floating
  form.
- **Rationale**: Standard mobile pattern for forms that don't warrant
  a full page. Keeps the transactions table visible behind the sheet.
  Built into Flutter SDK — no external dependency.

### Validation Strategy
- **Decision**: Validate on Save button tap (not on each keystroke).
  Show inline error messages below each invalid field.
- **Rationale**: Standard UX pattern — users prefer to fill all fields
  before seeing errors. Inline messages are clearer than dialogs.

### Type Dropdown Source
- **Decision**: Read from `EntryRepository.getIncomeTypes()`.
- **Rationale**: Types may come from 003-entry-type-management or a
  hardcoded fallback. The repository abstracts the source.

### Success Popup
- **Decision**: Simple `AlertDialog` with title "Income Added
  Successfully", body showing the updated balance, and an "OK" button.
- **Rationale**: Simplest built-in Flutter dialog. No custom overlay
  needed.

### Persistence
- **Decision**: Extend `EntryRepository` with `addEntry()` method.
  In-memory list for development; can be swapped for sqflite later.
- **Rationale**: The existing repo from 001 was read-only. Adding
  write capability is the minimal change.

## Alternatives Considered

| Alternative | Rejected Because |
|-------------|-----------------|
| Full-page form | Breaks context — user can't see transactions while adding |
| Real-time validation (per keystroke) | Annoying UX — shows errors before user finishes typing |
| Custom dialog overlay | `showModalBottomSheet` is standard, simpler, built-in |
