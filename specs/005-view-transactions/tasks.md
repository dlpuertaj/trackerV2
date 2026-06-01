# Tasks: View Transactions — MVP

**Input**: Design documents from `specs/005-view-transactions/`

**Tests**: Per Constitution Principle I (TDD is Non-Negotiable), tests are MANDATORY.
Tests MUST be written first and MUST fail before any implementation code is written.

**MVP Scope**: User Story 1 only — the `TransactionsTable` widget. The detail form (US2) and full HomePage integration are future work.

---

## Phase 1: Verify Project

- [ ] T001 Run `flutter analyze` to confirm project compiles
- [ ] T002 Run `flutter test` to confirm existing tests pass

---

## Phase 2: Write Tests (TDD — Must Fail First)

- [ ] T003 [P] Write widget test for empty state in `test/widgets/transactions_table_test.dart` — verify "No transactions yet" message when entries list is empty
- [ ] T004 [P] Write widget test for row rendering in `test/widgets/transactions_table_test.dart` — verify each row shows amount (with sign), date (short format), and name
- [ ] T005 [P] Write widget test for row colours in `test/widgets/transactions_table_test.dart` — verify income rows have green tint, expense rows have red tint
- [ ] T006 [P] Write widget test for reverse-chronological order in `test/widgets/transactions_table_test.dart` — verify most recent entry appears first
- [ ] T007 [P] Write widget test for scrolling in `test/widgets/transactions_table_test.dart` — verify table scrolls when entries exceed screen

**Verify**: Run `flutter test` — all 5 tests MUST fail (no widget exists yet)

---

## Phase 3: Implement

- [ ] T008 Implement `TransactionsTable` widget in `lib/widgets/transactions_table.dart` — StatelessWidget with `entries` and `onTapEntry` props, uses `ListView.builder`, renders colour-coded rows with amount/date/name, empty state message

**Verify**: Run `flutter test` — all 5 tests now pass

---

## Phase 4: Validate

- [ ] T009 Run `flutter analyze` — zero errors and warnings
- [ ] T010 Run `flutter test` — all tests pass (new + existing)

---

## Implementation Order

```
Phase 1                  Phase 2 (parallel)           Phase 3          Phase 4
T001 ──┐                 T003 ──┐
        ├── T002 ──→     T004 ──┤
T001 ──┘                 T005 ──┤──→ T008 ──→ T009 ──→ T010
                         T006 ──┤
                         T007 ──┘
```

---

## Future (Post-MVP)

These are out of MVP scope but planned for follow-up:

| Phase | Tasks | Description |
|-------|-------|-------------|
| US2 Detail Form | 2 tests + 1 impl | Tap row → bottom sheet with full transaction details |
| HomePage Integration | 2 tasks | Restructure HomePage: balance → table → buttons |
