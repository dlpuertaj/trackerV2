# Research: Entry Type Management

## Decisions

### Tap-Hold Detection
- **Decision**: `GestureDetector` with `onLongPress` callback for
  tap-hold, `onTap` for short-tap.
- **Rationale**: Built-in Flutter gesture handling. No external
  packages needed. `onLongPress` fires after ~500ms hold, which is
  standard mobile UX. Short-tap fires immediately on release.

### Form Presentation
- **Decision**: Modal bottom sheet (`showModalBottomSheet`),
  consistent with 002 and 004.
- **Rationale**: Same UI pattern across all floating forms in the
  app. User familiarity.

### Fixed/Variable Toggle
- **Decision**: `Switch` widget. When off: amount field hidden or
  disabled. When on: amount field becomes visible and enabled.
- **Rationale**: `Switch` is the standard Flutter toggle. Hiding the
  field when not needed reduces visual clutter.

### Type Storage
- **Decision**: New `TypeRepository` separate from `EntryRepository`.
  In-memory with `List<ExpenseType>` and `List<IncomeType>`.
- **Rationale**: Types are a separate concern from entries. Keeping
  them in their own repository avoids coupling. Can be backed by
  local persistence later.

### Type Availability
- **Decision**: `TypeRepository` exposes a `Stream` that forms in
  002 and 004 subscribe to. When a new type is added, the dropdown
  rebuilds automatically.
- **Rationale**: Reactive pattern — no manual refresh needed. Same
  approach as `EntryRepository.onChange`.

## Alternatives Considered

| Alternative | Rejected Because |
|-------------|-----------------|
| Dedicated types management screen (separate page) | User wants on-the-fly creation via tap-hold, not a separate screen |
| `InkWell` with custom timer for tap-hold | `GestureDetector.onLongPress` is simpler and built-in |
| Radio buttons for fixed/variable | `Switch` is more intuitive for a single on/off choice |
| Storing types in EntryRepository | Separate `TypeRepository` is cleaner separation of concerns |
