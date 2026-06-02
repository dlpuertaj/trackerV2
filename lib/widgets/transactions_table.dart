import 'package:flutter/material.dart';
import 'package:money_tracker/models/entry.dart';

class TransactionsTable extends StatelessWidget {
  final List<Entry> entries;
  final void Function(Entry entry) onTapEntry;

  const TransactionsTable({
    super.key,
    required this.entries,
    required this.onTapEntry,
  });

  @override
  Widget build(BuildContext context) {
    if (entries.isEmpty) {
      return const Center(child: Text('No transactions yet'));
    }

    final sorted = List<Entry>.from(entries)
      ..sort((a, b) => b.date.compareTo(a.date));

    return ListView.builder(
      itemCount: sorted.length,
      itemBuilder: (context, index) {
        final entry = sorted[index];
        final color = entry.type == EntryType.income
            ? Colors.green.shade50
            : Colors.red.shade50;
        final sign = entry.type == EntryType.income ? '+' : '-';
        final formattedDate = _formatDate(entry.date);
        final name = entry.description ??
            entry.category ??
            'No description';

        return GestureDetector(
          onTap: () => onTapEntry(entry),
          child: Container(
            color: color,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Row(
              children: [
                Text(
                  '$sign\$${entry.amount.toStringAsFixed(2)}',
                  style: const TextStyle(fontWeight: FontWeight.w600),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Text(name),
                ),
                Text(
                  formattedDate,
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ],
            ),
          ),
        );
      },
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
