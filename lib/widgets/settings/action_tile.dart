import 'package:flutter/material.dart';
import 'package:gofund/constants/theme.dart';
import 'package:gofund/widgets/base_tile.dart';

class ActionTile<T> extends StatelessWidget {
  final IconData icon;
  final String title;
  final String? label;
  final Function() onPressed;

  const ActionTile({
    super.key,
    required this.icon,
    required this.title,
    this.label,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return BaseTile(
      onPressed: onPressed,
      child: ListTile(
        visualDensity: VisualDensity.compact,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.medium,
        ),
        leading: Icon(icon),
        title: Text(
          title,
          style: Theme.of(context).textTheme.labelLarge,
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (label != null)
              Text(
                label!,
                style: Theme.of(context).textTheme.labelLarge!.copyWith(
                      color: Colors.grey,
                    ),
              ),
            const Icon(
              Icons.chevron_right_rounded,
              color: Colors.grey,
            ),
          ],
        ),
      ),
    );
  }
}
