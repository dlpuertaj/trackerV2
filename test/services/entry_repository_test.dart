import 'package:flutter_test/flutter_test.dart';
import 'package:money_tracker/models/entry.dart';
import 'package:money_tracker/services/entry_repository.dart';

void main() {
  late EntryRepository repository;

  setUp(() {
    repository = EntryRepository();
  });

  group('EntryRepository', () {
    test('getAllEntries returns empty list initially', () {
      final entries = repository.getAllEntries();
      expect(entries, isEmpty);
    });

    test('addEntry adds entry to repository', () {
      final entry = Entry(id: '1', amount: 100.0, type: EntryType.income);
      repository.addEntry(entry);

      final entries = repository.getAllEntries();
      expect(entries.length, 1);
      expect(entries.first.id, '1');
    });

    test('getAllEntries returns all added entries', () {
      final entry1 = Entry(id: '1', amount: 100.0, type: EntryType.income);
      final entry2 = Entry(id: '2', amount: 50.0, type: EntryType.expense);
      final entry3 = Entry(id: '3', amount: 200.0, type: EntryType.income);

      repository.addEntry(entry1);
      repository.addEntry(entry2);
      repository.addEntry(entry3);

      final entries = repository.getAllEntries();
      expect(entries.length, 3);
    });

    test('getEntriesByType returns only income entries', () {
      repository
        ..addEntry(Entry(id: '1', amount: 100.0, type: EntryType.income))
        ..addEntry(Entry(id: '2', amount: 50.0, type: EntryType.expense))
        ..addEntry(Entry(id: '3', amount: 200.0, type: EntryType.income));

      final incomes = repository.getEntriesByType(EntryType.income);
      expect(incomes.length, 2);
      expect(incomes.every((e) => e.type == EntryType.income), isTrue);
    });

    test('getEntriesByType returns only expense entries', () {
      repository
        ..addEntry(Entry(id: '1', amount: 100.0, type: EntryType.income))
        ..addEntry(Entry(id: '2', amount: 50.0, type: EntryType.expense))
        ..addEntry(Entry(id: '3', amount: 200.0, type: EntryType.income));

      final expenses = repository.getEntriesByType(EntryType.expense);
      expect(expenses.length, 1);
      expect(expenses.every((e) => e.type == EntryType.expense), isTrue);
    });

    test('removeEntry removes entry by id', () {
      repository.addEntry(Entry(id: '1', amount: 100.0, type: EntryType.income));
      repository.addEntry(Entry(id: '2', amount: 50.0, type: EntryType.expense));

      repository.removeEntry('1');

      final entries = repository.getAllEntries();
      expect(entries.length, 1);
      expect(entries.first.id, '2');
    });

    test('removeEntry does nothing when id not found', () {
      repository.addEntry(Entry(id: '1', amount: 100.0, type: EntryType.income));

      repository.removeEntry('non-existent');

      final entries = repository.getAllEntries();
      expect(entries.length, 1);
    });

    test('onChange notifies when entry is added', () async {
      var notificationCount = 0;
      repository.onChange.listen((_) {
        notificationCount++;
      });

      repository.addEntry(Entry(id: '1', amount: 100.0, type: EntryType.income));
      await Future.delayed(Duration.zero);

      expect(notificationCount, 1);
    });

    test('onChange notifies when entry is removed', () async {
      repository.addEntry(Entry(id: '1', amount: 100.0, type: EntryType.income));

      var notificationCount = 0;
      repository.onChange.listen((_) {
        notificationCount++;
      });

      repository.removeEntry('1');
      await Future.delayed(Duration.zero);

      expect(notificationCount, 1);
    });

    test('getIncomeTypes returns hardcoded fallback list', () {
      final types = repository.getIncomeTypes();

      expect(types, ['Salary', 'Loan', 'Investment', 'Gift', 'Other']);
    });

    test('getAllEntries returns entries in reverse-chronological order', () {
      final now = DateTime.now();
      final entry1 = Entry(
        id: '1',
        amount: 100.0,
        type: EntryType.income,
        date: now.subtract(const Duration(days: 2)),
      );
      final entry2 = Entry(
        id: '2',
        amount: 50.0,
        type: EntryType.expense,
        date: now.subtract(const Duration(days: 1)),
      );
      final entry3 = Entry(
        id: '3',
        amount: 200.0,
        type: EntryType.income,
        date: now,
      );

      repository
        ..addEntry(entry1)
        ..addEntry(entry2)
        ..addEntry(entry3);

      final entries = repository.getAllEntries();
      expect(entries[0].id, '3');
      expect(entries[1].id, '2');
      expect(entries[2].id, '1');
    });
  });
}
