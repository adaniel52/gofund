import 'package:flutter/material.dart';
import 'package:gofund/constants/theme.dart';
import 'package:gofund/providers/theme.dart';
import 'package:gofund/widgets/clickable_card.dart';
import 'package:gofund/widgets/custom_list_view.dart';
import 'package:provider/provider.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final buttonKey = GlobalKey();
    final children = [
      Text(
        'Appearance',
        style: Theme.of(context).textTheme.titleLarge,
      ),
      ClickableCard(
        key: buttonKey,
        onPressed: () {
          final button =
              buttonKey.currentContext!.findRenderObject() as RenderBox;
          final position = button.localToGlobal(Offset.zero);

          showMenu<ThemeMode>(
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
            items: [
              const PopupMenuItem(
                height: 10,
                value: ThemeMode.system,
                child: Text('System'),
              ),
              const PopupMenuDivider(),
              const PopupMenuItem(
                height: 10,
                value: ThemeMode.light,
                child: Text('Light'),
              ),
              const PopupMenuDivider(),
              const PopupMenuItem(
                height: 10,
                value: ThemeMode.dark,
                child: Text('Dark'),
              ),
            ],
          ).then(
            (value) {
              themeProvider.setTheme(value!);
            },
          );
        },
        child: ListTile(
          visualDensity: VisualDensity.compact,
          contentPadding:
              const EdgeInsets.symmetric(horizontal: AppSpacing.medium),
          leading: const Icon(Icons.nights_stay),
          title: Text(
            'App Theme',
            style: Theme.of(context).textTheme.labelLarge,
          ),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                mapThemeModeToString(themeProvider.theme),
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
      ),
      const Divider(),
      Text(
        'More',
        style: Theme.of(context).textTheme.titleLarge,
      ),
    ];

    return CustomListView(
      children: children,
    );
  }
}
