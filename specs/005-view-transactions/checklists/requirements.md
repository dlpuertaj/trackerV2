# Requirements Checklist: View Transactions

## Functional Requirements

- [ ] FR-001: Main screen layout: balance (top), table (middle), buttons (bottom)
- [ ] FR-002: Table in reverse-chronological order (most recent first)
- [ ] FR-003: Each row shows amount (with sign), date (short format), name
- [ ] FR-004: Income and expense rows have distinct background colours
- [ ] FR-005: Table scrolls when entries exceed available space
- [ ] FR-006: Tap opens floating detail form
- [ ] FR-007: Detail form shows: amount, date, type, category, description
- [ ] FR-008: Detail form has dismiss action
- [ ] FR-009: Empty state shows "No transactions yet"

## Success Criteria

- [ ] SC-001: Table visible immediately on app open (no extra navigation)
- [ ] SC-002: Income/expense distinguishable at a glance (<1s)
- [ ] SC-003: Detail form opens within 500ms of tap
- [ ] SC-004: Table scrolls at 60fps with 100+ entries
- [ ] SC-005: Detail form displays all fields correctly for every entry
