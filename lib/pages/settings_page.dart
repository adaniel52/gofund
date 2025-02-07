import 'package:flutter/material.dart';
import 'package:gofund/constants/theme.dart';
import 'package:gofund/providers/theme.dart';
import 'package:gofund/services/auth_service.dart';
import 'package:gofund/utils/dialogs/show_confirmation_dialog.dart';
import 'package:gofund/widgets/custom_list_view.dart';
import 'package:gofund/widgets/tiles/account_tile.dart';
import 'package:gofund/widgets/tiles/action_tile.dart';
import 'package:gofund/widgets/tiles/picker_tile.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final authService = AuthService.instance;
    final user = authService.getUser();

    final url = 'https://adaniel52.github.io/gofund';

    Future<void> openUrl(String url) async {
      final shouldOpenUrl = await showConfirmationDialog(
        context,
        message: 'Are you sure you want to open $url?',
      );
      if (!shouldOpenUrl) return;
      final uri = Uri.parse(url);
      await launchUrl(uri);
    }

    final children = [
      Text(
        'Account',
        style: Theme.of(context).textTheme.titleLarge,
      ),
      if (user != null) AccountTile(user: user),
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
        icon: Icons.help,
        title: 'User Guide',
        onPressed: () => openUrl('$url/links/guide'),
      ),
      ActionTile(
        icon: Icons.feedback,
        title: 'Send Feedback',
        onPressed: () => openUrl('$url/links/feedback'),
      ),
      ActionTile(
        icon: Icons.public,
        title: 'Website',
        label: 'adaniel52.github.io/gofund',
        onPressed: () => openUrl(url),
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
              children: [
                const Text(
                  'An app that connects schools with donors for transparent and efficient fundraising.',
                )
              ]);
        },
      ),
    ];

    return CustomListView(
      padding: AppSpacing.largePadding,
      children: children,
    );
  }
}
