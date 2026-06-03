import 'package:flutter/material.dart';
import 'package:money_tracker/models/entry.dart';

Future<void> showTransactionDetail(
  BuildContext context, {
  required Entry entry,
}) {
  return showModalBottomSheet(
    context: context,
    builder: (context) => _TransactionDetail(entry: entry),
  );
}

class _TransactionDetail extends StatelessWidget {
  final Entry entry;

  const _TransactionDetail({required this.entry});

  @override
  Widget build(BuildContext context) {
    final sign = entry.type == EntryType.income ? '+' : '-';
    final typeLabel = entry.type == EntryType.income ? 'Income' : 'Expense';
    final formattedDate = _formatDate(entry.date);

    return Padding(
      padding: const EdgeInsets.all(24),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
            const SizedBox(height: 24),
            Center(
              child: Text(
                '$sign\$${entry.amount.toStringAsFixed(2)}',
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
            ),
            const SizedBox(height: 24),
            _buildField(context, 'Type', typeLabel),
            const Divider(),
            _buildField(context, 'Date', formattedDate),
            if (entry.category != null) ...[
              const Divider(),
              _buildField(context, 'Category', entry.category!),
            ],
            if (entry.description != null && entry.description!.isNotEmpty) ...[
              const Divider(),
              _buildField(context, 'Description', entry.description!),
            ],
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text('Close'),
              ),
            ),
            const SizedBox(height: 8),
          ],
        ),
      ),
    );
  }

  Widget _buildField(BuildContext context, String label, String value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 100,
          child: Text(
            label,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: Colors.grey.shade600,
                ),
          ),
        ),
        Expanded(
          child: Text(value, style: Theme.of(context).textTheme.bodyLarge),
        ),
      ],
    );
  }
}

String _formatDate(DateTime date) {
  const months = [
    'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
    'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec',
  ];
  return '${months[date.month - 1]} ${date.day}, ${date.year}';
}
