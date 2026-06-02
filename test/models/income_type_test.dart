import 'package:flutter_test/flutter_test.dart';
import 'package:money_tracker/models/income_type.dart';

void main() {
  group('IncomeType', () {
    test('creates income type with name', () {
      final type = IncomeType(name: 'Salary');

      expect(type.name, 'Salary');
    });
  });
}
