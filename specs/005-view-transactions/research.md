# Research: View Transactions

## Decisions

### Layout Strategy
- **Decision**: Integrate transactions table between balance (001)
  and add buttons (002/004) as a single scrollable Column with
  Expanded.
- **Rationale**: The user's main screen is now: balance (pinned top)
  → transactions table (scrollable middle, takes remaining space) →
  add buttons (pinned bottom). The previous mini entry list from 001
  becomes redundant — the full table replaces it.

### Row Colours
- **Decision**: Subtle green tint for income, subtle red tint for
  expense. Text colour remains neutral (dark on light theme).
- **Rationale**: User wants instant visual distinction between income
  and expense rows. Tints (light background) keep text readable while
  providing the colour cue. This does not violate the "neutral balance"
  constraint since the balance itself remains neutral — only table
  rows use colour.

### Table Widget
- **Decision**: `Column` with `Expanded` and `ListView.builder`.
- **Rationale**: `ListView.builder` is efficient for large lists
  (builds only visible rows). Inside an `Expanded` widget, it takes
  remaining space between the pinned top (balance) and pinned bottom
  (add buttons). Standard Flutter pattern.

### Detail Form
- **Decision**: `showModalBottomSheet` for transaction details.
- **Rationale**: Consistent with 002, 003, 004 form patterns. Opens
  on tap, dismisses via tap outside or close button. Shows all
  fields read-only.

### Row Content
- **Decision**: Each row shows: amount (with sign for expenses), date
  (short format), and name (description or type name as fallback).
- **Rationale**: These three fields give the user enough context to
  identify a transaction at a glance. Full details are one tap away.

## Alternatives Considered

| Alternative | Rejected Because |
|-------------|------------------|
| Separate screen for transactions | User wants table inline on main screen — no navigation |
| CustomScrollView with slivers | Unnecessary — standard Column + Expanded suffices |
| DataTable widget | Too heavy — not designed for partial-screen embedded lists |
| Card-style rows | Adds visual noise — simple coloured ListTile is cleaner |
| Multiple colours per type (by category) | Overcomplicates — binary income/expense distinction suffices |
| Swipe actions (edit/delete) | Out of scope per spec — view-only in this version |
