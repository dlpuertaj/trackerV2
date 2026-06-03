import 'package:flutter/material.dart';
import 'package:money_tracker/models/entry.dart';
import 'package:money_tracker/services/entry_repository.dart';
import 'package:money_tracker/widgets/income_form.dart';
import 'package:money_tracker/widgets/success_popup.dart';

class AddIncomeButton extends StatelessWidget {
  final EntryRepository repository;

  const AddIncomeButton({
    super.key,
    required this.repository,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: () async {
        final entry = await showIncomeForm(
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
            updatedBalance: balance,
          );
        }
      },
      icon: const Icon(Icons.add_circle_outline),
      label: const Text('Add Income'),
    );
  }
}
