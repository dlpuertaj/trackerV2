import 'package:flutter/material.dart';

class BreakdownSection extends StatelessWidget {
  final double incomeTotal;
  final double expenseTotal;

  const BreakdownSection({
    super.key,
    required this.incomeTotal,
    required this.expenseTotal,
  });

  String _format(double amount) {
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
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Row(
        children: [
          Expanded(
            child: _buildCard(
              label: 'Income',
              amount: incomeTotal,
              labelColor: Colors.green.shade700,
              amountColor: Colors.green.shade900,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: _buildCard(
              label: 'Expenses',
              amount: expenseTotal,
              labelColor: Colors.red.shade700,
              amountColor: Colors.red.shade900,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCard({
    required String label,
    required double amount,
    required Color labelColor,
    required Color amountColor,
  }) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: TextStyle(
                fontSize: 14.0,
                color: labelColor,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              _format(amount),
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
                color: amountColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
