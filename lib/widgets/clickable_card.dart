import 'package:flutter/material.dart';
import 'package:gofund/constants/theme.dart';

class ClickableCard extends StatelessWidget {
  final Function() onPressed;
  final bool hasImage;
  final Widget? leading;
  final Widget? title;
  final Widget? subtitle;
  final Widget? trailing;

  const ClickableCard({
    super.key,
    required this.onPressed,
    this.hasImage = false,
    this.leading,
    this.title,
    this.subtitle,
    this.trailing,
  });

  @override
  Widget build(BuildContext context) {
    return FilledButton(
      onPressed: onPressed,
      style: FilledButton.styleFrom(
        padding: const EdgeInsets.all(0),
        backgroundColor: Theme.of(context).colorScheme.surfaceContainerHighest,
        overlayColor: Theme.of(context).colorScheme.onSurface,
        shape: const RoundedRectangleBorder(
          borderRadius: AppRadius.mediumRadius,
        ),
      ),
      child: IconTheme(
        data: const IconThemeData(size: 25),
        child: ListTile(
          contentPadding: hasImage
              ? const EdgeInsets.symmetric(
                  horizontal: AppSpacing.medium,
                  vertical: AppSpacing.small,
                )
              : null,
          leading: hasImage
              ? ClipRRect(
                  borderRadius: AppRadius.smallRadius,
                  child: AspectRatio(
                    aspectRatio: 1,
                    child: leading,
                  ),
                )
              : leading,
          title: title,
          subtitle: subtitle,
          trailing: trailing ??
              const Icon(
                Icons.chevron_right_rounded,
                size: 30,
              ),
        ),
      ),
    );
  }
}
