import 'package:flutter/material.dart';
import 'package:gofund/constants/theme.dart';
import 'package:gofund/widgets/tiles/base_tile.dart';

class PickerTile<T> extends StatelessWidget {
  final IconData icon;
  final String title;
  final String label;
  final Map<String, T> options;
  final Function(T) onSelected;

  const PickerTile({
    super.key,
    required this.icon,
    required this.title,
    required this.label,
    required this.options,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    final buttonKey = GlobalKey();

    void onPressed() {
      final button = buttonKey.currentContext!.findRenderObject() as RenderBox;
      final position = button.localToGlobal(Offset.zero);

      final List<PopupMenuEntry<T>> items = [];
      for (final e in options.entries.toList().asMap().entries) {
        items.addAll([
          PopupMenuItem<T>(
            height: 10,
            value: e.value.value,
            child: Text(e.value.key),
          ),
          if (e.key != options.length - 1) const PopupMenuDivider(),
        ]);
      }

      showMenu<T>(
        context: context,
        position: RelativeRect.fromLTRB(
          position.dx + button.size.width,
          position.dy - 20,
          position.dx + 20,
          position.dy,
        ),
        shape: const RoundedRectangleBorder(
          borderRadius: AppRadius.largeRadius,
        ),
        color: Theme.of(context).colorScheme.surfaceContainerHighest,
        items: items,
      ).then(
        (value) {
          if (value != null) onSelected(value);
        },
      );
    }

    return BaseTile(
      key: buttonKey,
      leading: Icon(icon),
      content: Text(title),
      label: label,
      onPressed: onPressed,
    );
  }
}
