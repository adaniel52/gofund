import 'package:flutter/material.dart';
import 'package:gofund/constants/theme.dart';

class ClickableCard extends StatelessWidget {
  final Function() onPressed;
  final Widget? leading;
  final Widget? title;
  final Widget? subtitle;
  const ClickableCard({
    super.key,
    required this.onPressed,
    this.leading,
    this.title,
    this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return FilledButton(
      onPressed: onPressed,
      style: FilledButton.styleFrom(
        padding: const EdgeInsets.all(0),
        backgroundColor: Theme.of(context).colorScheme.surfaceBright,
        overlayColor: Colors.grey,
        shape: const RoundedRectangleBorder(
          borderRadius: AppRadius.mediumRadius,
        ),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.small,
          // vertical: 2,
        ),
        leading: ClipRRect(
          borderRadius: AppRadius.smallRadius,
          child: AspectRatio(
            aspectRatio: 1,
            child: leading,
          ),
        ),
        title: title,
        subtitle: subtitle,
        trailing: const Icon(Icons.chevron_right),
      ),
    );
  }
}
