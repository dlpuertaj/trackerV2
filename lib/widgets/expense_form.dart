import 'package:flutter/material.dart';
import 'package:money_tracker/models/entry.dart';
import 'package:money_tracker/services/entry_repository.dart';
import 'package:money_tracker/services/expense_validator.dart';
import 'package:money_tracker/services/type_repository.dart';

Future<Entry?> showExpenseForm(
  BuildContext context, {
  required EntryRepository repository,
  required TypeRepository typeRepository,
}) {
  return showModalBottomSheet<Entry>(
    context: context,
    isScrollControlled: true,
    builder: (context) => _ExpenseForm(
      repository: repository,
      typeRepository: typeRepository,
    ),
  );
}

class _ExpenseForm extends StatefulWidget {
  final EntryRepository repository;
  final TypeRepository typeRepository;

  const _ExpenseForm({
    required this.repository,
    required this.typeRepository,
  });

  @override
  State<_ExpenseForm> createState() => _ExpenseFormState();
}

class _ExpenseFormState extends State<_ExpenseForm> {
  String? _selectedType;
  final _amountController = TextEditingController();
  final _descriptionController = TextEditingController();
  String? _typeError;
  String? _amountError;
  String? _descriptionError;

  late final List<_ExpenseTypeItem> _types;

  @override
  void initState() {
    super.initState();
    final defaults = widget.repository.getExpenseTypes()
        .map((t) => _ExpenseTypeItem(name: t.name, isFixed: t.isFixed, fixedAmount: t.fixedAmount));
    final userCreated = widget.typeRepository.getExpenseTypes()
        .map((t) => _ExpenseTypeItem(name: t.name, isFixed: t.isFixed, fixedAmount: t.fixedAmount));
    _types = [...defaults, ...userCreated];
  }

  @override
  void dispose() {
    _amountController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  void _save() {
    final result = ExpenseValidator.validateExpense(
      type: _selectedType,
      amountText: _amountController.text,
      description: _descriptionController.text,
    );

    if (!result.isValid) {
      setState(() {
        _typeError = result.typeError;
        _amountError = result.amountError;
        _descriptionError = result.descriptionError;
      });
      return;
    }

    final entry = Entry(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      amount: double.parse(_amountController.text.trim()),
      type: EntryType.expense,
      description: _descriptionController.text.trim().isEmpty
          ? null
          : _descriptionController.text.trim(),
      category: _selectedType,
    );

    widget.repository.addEntry(entry);
    Navigator.of(context).pop(entry);
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
            'Add Expense',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 16),
          DropdownButtonFormField<String>(
            initialValue: _selectedType,
            decoration: InputDecoration(
              labelText: 'Type',
              errorText: _typeError,
            ),
            items: _types
                .map((t) => DropdownMenuItem(
                    value: t.name,
                    child: Text(t.isFixed
                        ? '${t.name} (\$${t.fixedAmount!.toStringAsFixed(2)})'
                        : t.name)))
                .toList(),
            onChanged: (value) {
              setState(() {
                _selectedType = value;
                _typeError = null;
                final type = _types.firstWhere(
                  (t) => t.name == value,
                  orElse: () => _ExpenseTypeItem(
                    name: '', isFixed: false),
                );
                if (type.isFixed && type.fixedAmount != null) {
                  _amountController.text =
                      type.fixedAmount!.toStringAsFixed(2);
                } else {
                  _amountController.clear();
                }
              });
            },
          ),
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
                setState(() => _amountError = null);
              }
            },
          ),
          const SizedBox(height: 12),
          TextField(
            controller: _descriptionController,
            decoration: InputDecoration(
              labelText: 'Description (optional)',
              errorText: _descriptionError,
            ),
            maxLines: 2,
            onChanged: (_) {
              if (_descriptionError != null) {
                setState(() => _descriptionError = null);
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
                  onPressed: _save,
                  child: const Text('Save'),
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

class _ExpenseTypeItem {
  final String name;
  final bool isFixed;
  final double? fixedAmount;

  _ExpenseTypeItem({
    required this.name,
    required this.isFixed,
    this.fixedAmount,
  });
}
