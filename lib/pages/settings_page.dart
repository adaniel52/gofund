import 'package:flutter/material.dart';
import 'package:gofund/providers/theme.dart';
import 'package:gofund/widgets/base_tile.dart';
import 'package:gofund/widgets/custom_list_view.dart';
import 'package:gofund/widgets/settings/action_tile.dart';
import 'package:gofund/widgets/settings/picker_tile.dart';
import 'package:provider/provider.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    final children = [
      const Text('Account'),
      BaseTile(
        leading: const CircleAvatar(
          child: Icon(Icons.person),
        ),
        content: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text('Guest'),
            Text(
              'Sign up to save your progess',
              style: Theme.of(context).textTheme.labelMedium,
            ),
          ],
        ),
        onPressed: () {},
      ),
      const Divider(),
      const Text('Appearance'),
      PickerTile<ThemeMode>(
        icon: Icons.nights_stay,
        title: 'App Theme',
        label: mapThemeModeToString(themeProvider.theme),
        options: const {
          'System': ThemeMode.system,
          'Light': ThemeMode.light,
          'Dark': ThemeMode.dark,
        },
        onSelected: (value) => themeProvider.setTheme(value),
      ),
      const Divider(),
      const Text('More'),
      ActionTile(
        icon: Icons.feedback,
        title: 'Send Feedback',
        onPressed: () {},
      ),
      ActionTile(
        icon: Icons.public,
        title: 'Website',
        label: 'adaniel52.github.io/gofund',
        onPressed: () {},
      ),
      ActionTile(
        icon: Icons.info,
        title: 'About App',
        onPressed: () {
          showAboutDialog(
            context: context,
            applicationIcon: Image.asset(
              'assets/icon/transparent.png',
              width: 52,
            ),
            applicationVersion: 'v0.1.0',
          );
        },
      ),
    ];

    return DefaultTextStyle(
      style: Theme.of(context).textTheme.titleLarge!,
      child: CustomListView(
        children: children,
      ),
    );
  }
}
