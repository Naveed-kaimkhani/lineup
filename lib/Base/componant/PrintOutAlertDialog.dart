import 'package:flutter/material.dart';

class PrintOutAlertDialog extends StatelessWidget {
  const PrintOutAlertDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Print Lineup'),
      content: const Text('Would you like to print the current lineup?'),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: () => Navigator.of(context).pop(true),
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF2B4582),
          ),
          child: const Text('Print'),
        ),
      ],
    );
  }
}