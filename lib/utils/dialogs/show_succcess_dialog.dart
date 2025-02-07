import 'package:flutter/material.dart';

Future<void> showSuccessDialog(
  BuildContext context, {
  String? message,
}) {
  return showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        icon: const Icon(Icons.check),
        title: const Text('Success'),
        content: (message == null) ? null : Text(message),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('OK'),
          ),
        ],
      );
    },
  );
}
