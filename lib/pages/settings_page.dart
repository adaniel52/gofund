import 'package:flutter/material.dart';
import 'package:gofund/providers/theme.dart';
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
      const CircleAvatar(
        radius: 50,
        backgroundColor: Colors.amber,
        child: Icon(Icons.person),
      ),
      ActionTile(
        icon: Icons.person,
        title: 'Name',
        onPressed: () {},
      ),
      ActionTile(
        icon: Icons.email,
        title: 'Email',
        onPressed: () {},
      ),
      ActionTile(
        icon: Icons.password,
        title: 'Password',
        onPressed: () {},
      ),
      const Divider(),
      Text(
        'Appearance',
        style: Theme.of(context).textTheme.titleLarge,
      ),
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
      Text(
        'More',
        style: Theme.of(context).textTheme.titleLarge,
      ),
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

    return CustomListView(
      children: children,
    );
  }
}
