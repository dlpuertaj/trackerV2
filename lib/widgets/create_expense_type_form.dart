import 'package:flutter/material.dart';
import 'package:money_tracker/models/expense_type.dart';
import 'package:money_tracker/services/type_repository.dart';
import 'package:money_tracker/services/type_validator.dart';

Future<ExpenseType?> showCreateExpenseTypeForm(
  BuildContext context, {
  required TypeRepository repository,
}) {
  return showModalBottomSheet<ExpenseType>(
    context: context,
    isScrollControlled: true,
    builder: (context) => _CreateExpenseTypeForm(repository: repository),
  );
}

class _CreateExpenseTypeForm extends StatefulWidget {
  final TypeRepository repository;

  const _CreateExpenseTypeForm({required this.repository});

  @override
  State<_CreateExpenseTypeForm> createState() => _CreateExpenseTypeFormState();
}

class _CreateExpenseTypeFormState extends State<_CreateExpenseTypeForm> {
  final _nameController = TextEditingController();
  final _amountController = TextEditingController();
  bool _isFixed = false;
  String? _nameError;
  String? _amountError;

  @override
  void dispose() {
    _nameController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  void _create() {
    final amount = _isFixed
        ? double.tryParse(_amountController.text)
        : null;

    final result = TypeValidator.validateExpenseType(
      name: _nameController.text,
      isFixed: _isFixed,
      fixedAmount: amount,
      existingTypes: widget.repository.getExpenseTypes(),
    );

    if (!result.isValid) {
      setState(() {
        _nameError = result.nameError;
        _amountError = result.amountError;
      });
      return;
    }

    final type = ExpenseType(
      name: _nameController.text.trim(),
      isFixed: _isFixed,
      fixedAmount: amount,
    );
    widget.repository.addExpenseType(type);
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
            'Create Expense Type',
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
          const SizedBox(height: 12),
          SwitchListTile(
            title: const Text('Fixed amount'),
            value: _isFixed,
            onChanged: (value) {
              setState(() {
                _isFixed = value;
              });
            },
          ),
          if (_isFixed) ...[
            const SizedBox(height: 12),
            TextField(
              controller: _amountController,
              decoration: InputDecoration(
                labelText: 'Amount',
                errorText: _amountError,
                prefixText: '\$',
              ),
              keyboardType: TextInputType.number,
              onChanged: (_) {
                if (_amountError != null) {
                  setState(() {
                    _amountError = null;
                  });
                }
              },
            ),
          ],
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
