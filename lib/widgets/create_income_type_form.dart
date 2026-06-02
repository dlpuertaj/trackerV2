import 'package:flutter/material.dart';
import 'package:money_tracker/models/income_type.dart';
import 'package:money_tracker/services/type_repository.dart';
import 'package:money_tracker/services/type_validator.dart';

Future<IncomeType?> showCreateIncomeTypeForm(
  BuildContext context, {
  required TypeRepository repository,
}) {
  return showModalBottomSheet<IncomeType>(
    context: context,
    isScrollControlled: true,
    builder: (context) => _CreateIncomeTypeForm(repository: repository),
  );
}

class _CreateIncomeTypeForm extends StatefulWidget {
  final TypeRepository repository;

  const _CreateIncomeTypeForm({required this.repository});

  @override
  State<_CreateIncomeTypeForm> createState() => _CreateIncomeTypeFormState();
}

class _CreateIncomeTypeFormState extends State<_CreateIncomeTypeForm> {
  final _nameController = TextEditingController();
  String? _nameError;

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  void _create() {
    final result = TypeValidator.validateIncomeType(
      name: _nameController.text,
      existingTypes: widget.repository.getIncomeTypes(),
    );

    if (!result.isValid) {
      setState(() {
        _nameError = result.nameError;
      });
      return;
    }

    final type = IncomeType(name: _nameController.text.trim());
    widget.repository.addIncomeType(type);
    Navigator.of(context).pop(type);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
        left: 16,
        right: 16,
        top: 16,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            'Create Income Type',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 16),
          TextField(
            controller: _nameController,
            decoration: InputDecoration(
              labelText: 'Name',
              errorText: _nameError,
            ),
            onChanged: (_) {
              if (_nameError != null) {
                setState(() {
                  _nameError = null;
                });
              }
            },
          ),
          const SizedBox(height: 24),
          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text('Cancel'),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: ElevatedButton(
                  onPressed: _create,
                  child: const Text('Create'),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}
