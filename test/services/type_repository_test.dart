import 'package:flutter_test/flutter_test.dart';
import 'package:money_tracker/models/expense_type.dart';
import 'package:money_tracker/models/income_type.dart';
import 'package:money_tracker/services/type_repository.dart';

void main() {
  late TypeRepository repository;

  setUp(() {
    repository = TypeRepository();
  });

  group('TypeRepository', () {
    test('getExpenseTypes returns empty list initially', () {
      final types = repository.getExpenseTypes();
      expect(types, isEmpty);
    });

    test('getIncomeTypes returns empty list initially', () {
      final types = repository.getIncomeTypes();
      expect(types, isEmpty);
    });

    test('addExpenseType adds type to repository', () {
      final type = ExpenseType(name: 'Rent', isFixed: true, fixedAmount: 1000.0);
      repository.addExpenseType(type);

      final types = repository.getExpenseTypes();
      expect(types.length, 1);
      expect(types.first.name, 'Rent');
    });

    test('addIncomeType adds type to repository', () {
      final type = IncomeType(name: 'Salary');
      repository.addIncomeType(type);

      final types = repository.getIncomeTypes();
      expect(types.length, 1);
      expect(types.first.name, 'Salary');
    });

    test('rejects duplicate expense type name', () {
      repository.addExpenseType(ExpenseType(name: 'Rent', isFixed: true, fixedAmount: 1000.0));

      expect(
        () => repository.addExpenseType(ExpenseType(name: 'Rent', isFixed: false)),
        throwsA(isA<ArgumentError>()),
      );
    });

    test('rejects duplicate income type name', () {
      repository.addIncomeType(IncomeType(name: 'Salary'));

      expect(
        () => repository.addIncomeType(IncomeType(name: 'Salary')),
        throwsA(isA<ArgumentError>()),
      );
    });

    test('allows same name across expense and income types', () {
      repository.addExpenseType(ExpenseType(name: 'Rent', isFixed: true, fixedAmount: 1000.0));
      repository.addIncomeType(IncomeType(name: 'Rent'));

      expect(repository.getExpenseTypes().length, 1);
      expect(repository.getIncomeTypes().length, 1);
    });

    test('onChange notifies when expense type is added', () async {
      var notificationCount = 0;
      repository.onChange.listen((_) {
        notificationCount++;
      });

      repository.addExpenseType(ExpenseType(name: 'Rent', isFixed: true, fixedAmount: 1000.0));
      await Future.delayed(Duration.zero);

      expect(notificationCount, 1);
    });

    test('onChange notifies when income type is added', () async {
      var notificationCount = 0;
      repository.onChange.listen((_) {
        notificationCount++;
      });

      repository.addIncomeType(IncomeType(name: 'Salary'));
      await Future.delayed(Duration.zero);

      expect(notificationCount, 1);
    });
  });
}
