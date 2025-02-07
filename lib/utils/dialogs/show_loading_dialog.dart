import 'package:flutter/material.dart';

Future<void> showLoadingDialog(BuildContext context) async {
  return showDialog(
    context: context,
    builder: (context) {
      final width = MediaQuery.of(context).size.width;

      return PopScope(
        canPop: false,
        child: Dialog(
          insetPadding: EdgeInsets.symmetric(
            horizontal: (width - 100) / 2,
          ),
          child: const AspectRatio(
            aspectRatio: 1,
            child: Padding(
              padding: EdgeInsets.all(25),
              child: CircularProgressIndicator(),
            ),
          ),
        ),
      );
    },
  );
}
