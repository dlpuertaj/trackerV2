import 'package:flutter/material.dart';
import 'package:money_tracker/models/entry.dart';

class EntryList extends StatelessWidget {
  final List<Entry> entries;

  const EntryList({super.key, required this.entries});

  String _formatAmount(double amount) {
    final parts = amount.toStringAsFixed(2).split('.');
    final intPart = parts[0];
    final decimalPart = parts[1];
    final buffer = StringBuffer();
    for (var i = 0; i < intPart.length; i++) {
      if (i > 0 && (intPart.length - i) % 3 == 0) {
        buffer.write(',');
      }
      buffer.write(intPart[i]);
    }
    return '\$${buffer.toString()}.$decimalPart';
  }

  @override
  Widget build(BuildContext context) {
    if (entries.isEmpty) {
      return const Center(
        child: Padding(
          padding: EdgeInsets.all(32.0),
          child: Text(
            'No entries yet',
            style: TextStyle(fontSize: 16.0, color: Colors.grey),
          ),
        ),
      );
    }

    return ListView.builder(
      itemCount: entries.length,
      itemBuilder: (context, index) {
        final entry = entries[index];
        final sign = entry.type == EntryType.income ? '+' : '-';
        final label = entry.type == EntryType.income ? 'Income' : 'Expense';

        return ListTile(
          leading: CircleAvatar(
            backgroundColor: entry.type == EntryType.income
                ? Colors.green.shade100
                : Colors.red.shade100,
            child: Text(
              label[0],
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: entry.type == EntryType.income
                    ? Colors.green.shade800
                    : Colors.red.shade800,
              ),
            ),
          ),
          title: Text(
            '$sign${_formatAmount(entry.amount)}',
            style: TextStyle(
              fontWeight: FontWeight.w600,
              color: entry.type == EntryType.income
                  ? Colors.green.shade800
                  : Colors.red.shade800,
            ),
          ),
          subtitle: entry.description != null && entry.description!.isNotEmpty
              ? Text(entry.description!)
              : null,
          trailing: Text(
            label,
            style: TextStyle(
              fontSize: 12.0,
              color: Colors.grey.shade600,
            ),
          ),
        );
      },
    );
  }
}
