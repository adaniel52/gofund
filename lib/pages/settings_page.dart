import 'package:flutter/material.dart';
import 'package:gofund/providers/theme.dart';
import 'package:gofund/widgets/custom_list_view.dart';
import 'package:gofund/widgets/settings/picker_tile.dart';
import 'package:provider/provider.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    final children = [
      Text(
        'Appearance',
        style: Theme.of(context).textTheme.titleLarge,
      ),
      PickerTile<ThemeMode>(
        icon: Icons.nights_stay,
        title: 'App Theme',
        options: const {
          'System': ThemeMode.system,
          'Light': ThemeMode.light,
          'Dark': ThemeMode.dark,
        },
        selectedLabel: mapThemeModeToString(themeProvider.theme),
        onSelected: (value) => themeProvider.setTheme(value),
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
