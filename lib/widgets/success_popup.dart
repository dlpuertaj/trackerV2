import 'package:flutter/material.dart';

Future<void> showSuccessPopup(
  BuildContext context, {
  required double updatedBalance,
}) {
  final formattedBalance = updatedBalance < 0
      ? '-\$${(-updatedBalance).toStringAsFixed(2)}'
      : '\$${updatedBalance.toStringAsFixed(2)}';

  return showDialog<void>(
    context: context,
    builder: (context) => AlertDialog(
      title: const Text('Income Added Successfully'),
      content: Text('Your new balance is $formattedBalance'),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('OK'),
        ),
      ],
    ),
  );
}
