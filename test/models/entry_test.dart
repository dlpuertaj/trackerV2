import 'package:flutter_test/flutter_test.dart';
import 'package:money_tracker/models/entry.dart';
void main() {
  group('EntryType', () {
    test('has income value', () {
      expect(EntryType.values, contains(EntryType.income));
    });

    test('has expense value', () {
      expect(EntryType.values, contains(EntryType.expense));
    });
  });

  group('Entry', () {
    test('creates entry with all fields', () {
      final now = DateTime(2026, 5, 24);
      final entry = Entry(
        id: 'test-id',
        amount: 100.0,
        type: EntryType.income,
        description: 'Salary',
        category: 'Work',
        date: now,
      );

      expect(entry.id, 'test-id');
      expect(entry.amount, 100.0);
      expect(entry.type, EntryType.income);
      expect(entry.description, 'Salary');
      expect(entry.category, 'Work');
      expect(entry.date, now);
    });

    test('creates entry without optional fields', () {
      final entry = Entry(
        id: 'test-id',
        amount: 50.0,
        type: EntryType.expense,
      );

      expect(entry.description, isNull);
      expect(entry.category, isNull);
    });

    test('date defaults to now when not provided', () {
      final before = DateTime.now();
      final entry = Entry(
        id: 'test-id',
        amount: 50.0,
        type: EntryType.expense,
      );
      final after = DateTime.now();

      expect(entry.date.isAfter(before.subtract(const Duration(seconds: 1))),
          isTrue);
      expect(entry.date.isBefore(after.add(const Duration(seconds: 1))),
          isTrue);
    });

    group('validate', () {
      test('returns valid result for valid entry fields', () {
        final result = Entry.validate(
          amount: 100.0,
          type: EntryType.income,
        );
        expect(result.isValid, isTrue);
      });

      test('returns invalid when amount is zero', () {
        final result = Entry.validate(
          amount: 0.0,
          type: EntryType.income,
        );
        expect(result.isValid, isFalse);
        expect(result.amountError, isNotNull);
      });

      test('returns invalid when amount is negative', () {
        final result = Entry.validate(
          amount: -50.0,
          type: EntryType.income,
        );
        expect(result.isValid, isFalse);
        expect(result.amountError, isNotNull);
      });

      test('returns valid when description is null', () {
        final result = Entry.validate(
          amount: 100.0,
          type: EntryType.income,
          description: null,
        );
        expect(result.isValid, isTrue);
      });

      test('returns valid when description is empty', () {
        final result = Entry.validate(
          amount: 100.0,
          type: EntryType.income,
          description: '',
        );
        expect(result.isValid, isTrue);
      });

      test('returns invalid when description exceeds 200 characters', () {
        final longDescription = 'a' * 201;
        final result = Entry.validate(
          amount: 100.0,
          type: EntryType.income,
          description: longDescription,
        );
        expect(result.isValid, isFalse);
        expect(result.descriptionError, isNotNull);
      });

      test('returns valid when description is exactly 200 characters', () {
        final exactDescription = 'a' * 200;
        final result = Entry.validate(
          amount: 100.0,
          type: EntryType.income,
          description: exactDescription,
        );
        expect(result.isValid, isTrue);
      });

      test('returns invalid when amount is not provided', () {
        final result = Entry.validate(
          type: EntryType.income,
        );
        expect(result.isValid, isFalse);
        expect(result.amountError, isNotNull);
      });

      test('returns invalid when type is not provided', () {
        final result = Entry.validate(
          amount: 100.0,
        );
        expect(result.isValid, isFalse);
        expect(result.typeError, isNotNull);
      });
    });
  });
}
