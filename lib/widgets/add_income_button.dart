import 'package:flutter/material.dart';
import 'package:money_tracker/services/type_repository.dart';
import 'package:money_tracker/widgets/create_income_type_form.dart';

class AddIncomeButton extends StatelessWidget {
  final TypeRepository typeRepository;
  final VoidCallback? onTap;

  const AddIncomeButton({
    super.key,
    required this.typeRepository,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      onLongPress: () => showCreateIncomeTypeForm(
        context,
        repository: typeRepository,
      ),
      child: ElevatedButton.icon(
        onPressed: onTap,
        icon: const Icon(Icons.add_circle_outline),
        label: const Text('Add Income'),
      ),
    );
  }
}
