# Research: Balance Overview

## Decisions

### Technology Stack
- **Decision**: Flutter with Dart, no external packages.
- **Rationale**: Constitution Principle II mandates Flutter + Dart.
  Principle IV requires minimal external dependencies. The balance
  view uses only built-in Flutter widgets (Text, ListView, Column,
  Row) — no third-party UI or state management packages needed.

### State Management
- **Decision**: `setState` with a shared in-memory repository.
- **Rationale**: This feature is view-only (no entry creation). A
  simple callback/stream pattern from the repository to the home
  page widget is sufficient. Future features can adopt a more
  robust pattern if justified.

### Balance Calculation
- **Decision**: Computed on each state change — sum all incomes,
  sum all expenses, subtract.
- **Rationale**: Trivially cheap for local data (tens/hundreds of
  entries). No caching or pre-computation needed.

### Layout Strategy
- **Decision**: `Column` with `Expanded` + `ListView`.
  Balance and breakdown are in the non-scrollable top section.
  Entries list uses a scrollable `ListView` beneath.
- **Rationale**: Keeps balance pinned at top while entries scroll.
  Standard Flutter pattern, no custom scroll physics needed.

### Colour/Negative Sign
- **Decision**: Neutral text colour always. Negative balance shown
  with a minus sign prefix. No red/green colouring.
- **Rationale**: User explicitly requested no colour changes. The
  minus sign is the universal indicator of a negative value.

## Alternatives Considered

| Alternative | Rejected Because |
|-------------|-----------------|
| External state management (Provider, Riverpod) | Adds dependency — `setState` suffices for current scope |
| CustomScrollView with slivers | Unnecessary complexity for a simple fixed-header layout |
| Conditional colouring (green/red) | Rejected by user requirement |
| Persistent storage for balance | Balance is computed — storing it would introduce sync bugs |
