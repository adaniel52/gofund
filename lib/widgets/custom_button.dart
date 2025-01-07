import 'package:flutter/material.dart';
import 'package:gofund/constants/theme.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final Function() onPressed;
  const CustomButton({
    super.key,
    required this.text,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return FilledButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        minimumSize: const Size(double.infinity, 50),
        shape: const RoundedRectangleBorder(
          borderRadius: AppRadius.mediumRadius,
        ),
      ),
      child: Text(
        text,
        style: AppTextStyles.button,
      ),
    );
  }
}
