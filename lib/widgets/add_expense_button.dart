import 'package:flutter/material.dart';
import 'package:money_tracker/models/entry.dart';
import 'package:money_tracker/services/entry_repository.dart';
import 'package:money_tracker/services/type_repository.dart';
import 'package:money_tracker/widgets/create_expense_type_form.dart';
import 'package:money_tracker/widgets/expense_form.dart';
import 'package:money_tracker/widgets/success_popup.dart';

class AddExpenseButton extends StatelessWidget {
  final EntryRepository repository;
  final TypeRepository typeRepository;

  const AddExpenseButton({
    super.key,
    required this.repository,
    required this.typeRepository,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onLongPress: () => showCreateExpenseTypeForm(
        context,
        repository: typeRepository,
      ),
      child: ElevatedButton.icon(
        onPressed: () async {
          final entry = await showExpenseForm(
            context,
            repository: repository,
          );
          if (entry != null && context.mounted) {
            final entries = repository.getAllEntries();
            final balance = entries
                .where((e) => e.type == EntryType.income)
                .fold<double>(0.0, (sum, e) => sum + e.amount)
              - entries
                  .where((e) => e.type == EntryType.expense)
                  .fold<double>(0.0, (sum, e) => sum + e.amount);
            showSuccessPopup(
              context,
              title: 'Expense Added Successfully',
              updatedBalance: balance,
            );
          }
        },
        icon: const Icon(Icons.remove_circle_outline),
        label: const Text('Add Expense'),
      ),
    );
  }
}
