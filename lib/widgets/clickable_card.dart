import 'package:flutter/material.dart';

class ClickableCard extends StatelessWidget {
  final Function() onPressed;
  final Widget child;

  const ClickableCard({
    super.key,
    required this.onPressed,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return FilledButton(
      style: FilledButton.styleFrom(
        padding: const EdgeInsets.all(0),
        backgroundColor: Theme.of(context).colorScheme.surfaceContainerHighest,
        overlayColor: Theme.of(context).colorScheme.onSurface,
      ),
      onPressed: onPressed,
      child: IconTheme(
        data: const IconThemeData(size: 24),
        child: child,
      ),
    );
  }
}
