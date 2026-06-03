import 'package:flutter/material.dart';
import 'package:money_tracker/models/entry.dart';
import 'package:money_tracker/services/entry_repository.dart';
import 'package:money_tracker/services/income_validator.dart';

Future<Entry?> showIncomeForm(
  BuildContext context, {
  required EntryRepository repository,
}) {
  return showModalBottomSheet<Entry>(
    context: context,
    isScrollControlled: true,
    builder: (context) => _IncomeForm(repository: repository),
  );
}

class _IncomeForm extends StatefulWidget {
  final EntryRepository repository;

  const _IncomeForm({required this.repository});

  @override
  State<_IncomeForm> createState() => _IncomeFormState();
}

class _IncomeFormState extends State<_IncomeForm> {
  String? _selectedType;
  final _amountController = TextEditingController();
  final _descriptionController = TextEditingController();
  String? _typeError;
  String? _amountError;
  String? _descriptionError;

  late final List<String> _types;

  @override
  void initState() {
    super.initState();
    _types = widget.repository.getIncomeTypes();
  }

  @override
  void dispose() {
    _amountController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  void _save() {
    final result = IncomeValidator.validateIncome(
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
      type: EntryType.income,
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
            'Add Income',
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
                .map((t) => DropdownMenuItem(value: t, child: Text(t)))
                .toList(),
            onChanged: (value) {
              setState(() {
                _selectedType = value;
                _typeError = null;
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
