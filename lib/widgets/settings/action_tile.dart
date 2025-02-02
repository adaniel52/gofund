import 'package:flutter/material.dart';
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
      leading: Icon(icon),
      content: Text(title),
      label: label,
      onPressed: onPressed,
    );
  }
}
