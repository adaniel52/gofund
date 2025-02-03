import 'package:flutter/material.dart';
import 'package:gofund/constants/theme.dart';

class BaseTile extends StatelessWidget {
  final Widget? leading;
  final Widget content;
  final String? label;
  final Function()? onPressed;

  const BaseTile({
    super.key,
    this.leading,
    required this.content,
    this.label,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return FilledButton(
      style: FilledButton.styleFrom(
        padding: const EdgeInsets.all(0),
        backgroundColor: Theme.of(context).colorScheme.surfaceContainerHighest,
        disabledBackgroundColor:
            Theme.of(context).colorScheme.surfaceContainerHighest,
        overlayColor: Theme.of(context).colorScheme.onSurface,
      ),
      onPressed: onPressed,
      child: DefaultTextStyle(
        style: Theme.of(context).textTheme.labelLarge!,
        child: IconTheme(
          data: IconThemeData(
            color: Theme.of(context).colorScheme.onSurfaceVariant,
          ),
          child: Padding(
            padding: AppSpacing.mediumPadding,
            child: Row(
              spacing: AppSpacing.medium,
              children: [
                if (leading != null) leading!,
                Expanded(child: content),
                if (label != null)
                  Expanded(
                    child: Text(
                      label!,
                      style: const TextStyle(color: Colors.grey),
                      textAlign: TextAlign.end,
                    ),
                  ),
                if (onPressed != null)
                  const Icon(
                    Icons.chevron_right_rounded,
                    color: Colors.grey,
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
