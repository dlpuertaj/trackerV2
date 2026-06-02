import 'package:flutter/material.dart';
import 'package:money_tracker/services/type_repository.dart';
import 'package:money_tracker/widgets/create_expense_type_form.dart';

class AddExpenseButton extends StatelessWidget {
  final TypeRepository typeRepository;
  final VoidCallback? onTap;

  const AddExpenseButton({
    super.key,
    required this.typeRepository,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      onLongPress: () => showCreateExpenseTypeForm(
        context,
        repository: typeRepository,
      ),
      child: ElevatedButton.icon(
        onPressed: onTap,
        icon: const Icon(Icons.remove_circle_outline),
        label: const Text('Add Expense'),
      ),
    );
  }
}
