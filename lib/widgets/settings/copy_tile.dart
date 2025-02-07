import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gofund/constants/theme.dart';
import 'package:gofund/widgets/base_tile.dart';

class CopyTile extends StatelessWidget {
  const CopyTile({
    super.key,
    this.trailing,
    required this.title,
    required this.label,
  });

  final Widget? trailing;
  final String title;
  final String label;

  @override
  Widget build(BuildContext context) {
    return BaseTile(
      textStyle: Theme.of(context).textTheme.labelSmall,
      content: Text(title),
      label: label,
      trailing: Row(
        spacing: AppSpacing.medium,
        children: [
          if (trailing != null) trailing!,
          const Icon(
            Icons.copy,
            size: 12,
          ),
        ],
      ),
      onPressed: () {
        ScaffoldMessenger.of(context).hideCurrentSnackBar();
        Clipboard.setData(ClipboardData(text: label));
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            shape: RoundedRectangleBorder(
              borderRadius: AppRadius.largeRadius,
            ),
            behavior: SnackBarBehavior.floating,
            content: Text('Copied to clipboard!'),
          ),
        );
      },
    );
  }
}
