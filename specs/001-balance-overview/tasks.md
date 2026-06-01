# Tasks: Balance Overview (001)

**Input**: Design documents from `specs/001-balance-overview/`

**Tests**: Per Constitution Principle I (TDD is Non-Negotiable), tests are MANDATORY.
Tests MUST be written first and MUST fail before any implementation code is written.

---

## Phase 1: Setup

- [ ] T001 Run `flutter create money_tracker` to scaffold the Flutter project

---

## Phase 2: Foundational (Entry Model + Repository)

**Purpose**: Data layer shared by all three user stories.

### Tests (write first, must fail)

- [ ] T002 [P] Write unit test for `Entry` model in `test/models/entry_test.dart` — verify fields, validation (>0 amount, ≤200 desc, default date)
- [ ] T003 [P] Write unit test for `EntryRepository` in `test/services/entry_repository_test.dart` — verify `getAllEntries`, `getEntriesByType`, `addEntry`, `removeEntry`, `onChange` stream

### Implementation

- [ ] T004 Implement `Entry` model in `lib/models/entry.dart` — `EntryType` enum + `Entry` class with `id`, `amount`, `type`, `description`, `category`, `date`
- [ ] T005 Implement `EntryRepository` in `lib/services/entry_repository.dart` — in-memory store with `getAllEntries()`, `getEntriesByType()`, `addEntry()`, `removeEntry()`, `onChange` stream

**Checkpoint**: `flutter test` passes for all model + repository tests

---

## Phase 3: User Story 1 — View Total Balance at a Glance (P1) 🎯 MVP

**Goal**: Net balance displayed prominently at top of screen, pinned, neutral colour, real-time updates.

**Independent Test**: With 3 incomes (500 total) and 2 expenses (200 total), balance shows 300. On empty entries, balance shows 0.00. Colour is neutral at all times.

### Tests (write first, must fail)

- [ ] T006 [P] [US1] Write widget test for `BalanceDisplay` in `test/widgets/balance_display_test.dart` — verify balance text renders, neutral colour, minus sign for negative
- [ ] T007 [P] [US1] Write widget test for `HomePage` in `test/pages/home_page_test.dart` — verify balance is pinned at top, visible without scrolling, updates on repo change

### Implementation

- [ ] T008 [US1] Implement `BalanceDisplay` in `lib/widgets/balance_display.dart` — takes `balance` prop, renders large-formatted amount, neutral colour, minus sign when negative
- [ ] T009 [US1] Implement `HomePage` in `lib/pages/home_page.dart` — `StatefulWidget` listening to `EntryRepository.onChange`, calculates balance, renders `BalanceDisplay` at top
- [ ] T010 [US1] Implement `main.dart` — `MaterialApp` with `EntryRepository` shared via constructor, renders `HomePage`

**Checkpoint**: `flutter test` passes. `flutter run` shows balance at top, updates on entry changes.

---

## Phase 4: User Story 2 — Income vs Expense Breakdown (P2)

**Goal**: Income and expense subtotals displayed below balance, visually distinct from each other.

**Independent Test**: With 500 income and 200 expense, screen shows subtotals 500 and 200 alongside net balance 300.

### Tests (write first, must fail)

- [ ] T011 [P] [US2] Write widget test for `BreakdownSection` in `test/widgets/breakdown_section_test.dart` — verify income total, expense total, visual distinction between them

### Implementation

- [ ] T012 [US2] Implement `BreakdownSection` in `lib/widgets/breakdown_section.dart` — takes `incomeTotal` and `expenseTotal`, renders both with distinct labels
- [ ] T013 [US2] Integrate `BreakdownSection` into `HomePage` below `BalanceDisplay`

**Checkpoint**: `flutter test` passes. Screen shows balance + income/expense subtotals.

---

## Phase 5: User Story 3 — Recent Entries List (P3)

**Goal**: Scrollable list of recent entries (reverse-chronological) below breakdown, showing amount, type, description with sign indicators.

**Independent Test**: With 5 entries (3 most recent visible), list shows 3 most recent in reverse-chronological order. Expense amounts show negative sign, income shows positive sign.

### Tests (write first, must fail)

- [ ] T014 [P] [US3] Write widget test for `EntryList` in `test/widgets/entry_list_test.dart` — verify reverse-chronological order, amount sign, description display, scrolling

### Implementation

- [ ] T015 [US3] Implement `EntryList` in `lib/widgets/entry_list.dart` — `ListView.builder` inside `Expanded`, renders amount (with sign), type, description per entry
- [ ] T016 [US3] Integrate `EntryList` into `HomePage` below `BreakdownSection`

**Checkpoint**: `flutter test` passes. Screen shows balance → breakdown → scrollable entries.

---

## Phase 6: Polish

- [ ] T017 Run `flutter analyze` — zero errors and warnings
- [ ] T018 Run `flutter test` — all 10+ tests pass
- [ ] T019 Run quickstart verification steps

---

## Dependencies & Execution Order

```
Phase 1         Phase 2                Phase 3        Phase 4       Phase 5       Phase 6
T001 ──→ T002 ──→ T003 ──→ T004 ──→ T006 ──→ T008 ──→ T011 ──→ T012 ──→ T014 ──→ T017
          (parallel)  (parallel)  T007     T009     (parallel)  (parallel)  T015     T018
          T003 ──→ T004          T006     T008                 T013       T016     T019
          T003 ──→ T005          T007     T009
                                   T010
```

### Phase Dependencies
- **Phase 1**: No dependencies
- **Phase 2**: Depends on Phase 1 — blocks all stories
- **Phase 3 (US1)**: Depends on Phases 1–2
- **Phase 4 (US2)**: Depends on Phases 1–2 (can run after Phase 2, no dependency on US1)
- **Phase 5 (US3)**: Depends on Phases 1–2 (can run after Phase 2, no dependency on US1/US2)
- **Phase 6**: Depends on Phases 3–5

### Parallel Opportunities
- T002 + T003: tests can be written in parallel
- T004 + T005: implementation can be done in parallel (different files)
- T006 + T007: US1 tests in parallel
- T011: US2 test in parallel with any US1/US3 work
- T014: US3 test in parallel with any US1/US2 work
- Phases 3, 4, 5 can proceed sequentially or US2/US3 can start in parallel after Phase 2

---

## Implementation Strategy

### MVP (User Story 1 Only)
1. Phase 1: `flutter create`
2. Phase 2: Entry model + repository
3. Phase 3: BalanceDisplay + HomePage + main.dart
4. **STOP and VALIDATE**: Balance shows at top, correct calculation, neutral colour

### Incremental Delivery
1. MVP: Balance display (US1)
2. Add breakdown (US2)
3. Add entries list (US3)
4. Each increment adds value without breaking previous stories
