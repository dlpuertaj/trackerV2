import 'package:flutter/material.dart';

class BalanceDisplay extends StatelessWidget {
  final double balance;

  const BalanceDisplay({super.key, required this.balance});

  String get _formattedBalance {
    final abs = balance.abs();
    final parts = abs.toStringAsFixed(2).split('.');
    final intPart = parts[0];
    final decimalPart = parts[1];

    final buffer = StringBuffer();
    for (var i = 0; i < intPart.length; i++) {
      if (i > 0 && (intPart.length - i) % 3 == 0) {
        buffer.write(',');
      }
      buffer.write(intPart[i]);
    }

    final formatted = '\$${buffer.toString()}.$decimalPart';
    if (balance < 0) return '-$formatted';
    return formatted;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 24.0),
      child: Text(
        _formattedBalance,
        style: TextStyle(
          fontSize: 48.0,
          fontWeight: FontWeight.bold,
          color: Theme.of(context).colorScheme.onSurface,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
}
