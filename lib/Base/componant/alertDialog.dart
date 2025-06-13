import 'package:flutter/material.dart';

void showCustomDialog({
  required BuildContext context,
  required String title,
  required String description,
  required VoidCallback onOk,
  VoidCallback? onCancel,
}) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(title),
        content: Text(description),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(); // Close the dialog
              if (onCancel != null) onCancel();
            },
            child: const Text("Cancel"),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop(); // Close the dialog
              onOk();
            },
            child: const Text("OK"),
          ),
        ],
      );
    },
  );
}


