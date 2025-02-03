import 'package:flutter/material.dart';
import 'package:gofund/widgets/custom_column.dart';

Future<void> showErrorDialog(
  BuildContext context, {
  String message = 'An unexpected error occured.',
  String? statusCode,
  String? errorCode,
}) async {
  return await showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        icon: const Icon(Icons.error),
        title: const Text('Error'),
        content: CustomColumn(
          children: [
            Text(message),
            if (statusCode != null) Text('Status code: $statusCode'),
            if (errorCode != null) Text('Error code: $errorCode'),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('OK'),
          ),
        ],
      );
    },
  );
}
