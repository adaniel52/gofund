import 'package:flutter/material.dart';
import 'package:gofund/constants/theme.dart';
import 'package:gofund/widgets/clickable_card.dart';
import 'package:gofund/widgets/scaffold_body_wrapper.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool darkTheme = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: ScaffoldBodyWrapper(
        children: [
          const Text(
            'Appearance',
            style: AppTextStyles.subtitle,
          ),
          ClickableCard(
            onPressed: () {
              setState(() => darkTheme = !darkTheme);
            },
            leading: const Icon(Icons.dark_mode),
            title: const Text('Dark Theme'),
            trailing: Switch(
              value: darkTheme,
              onChanged: (value) {
                setState(() => darkTheme = !darkTheme);
              },
              // padding: const EdgeInsets.all(0),
            ),
          ),
          const Divider(),
          const Text(
            'More',
            style: AppTextStyles.subtitle,
          ),
          ClickableCard(
            leading: const Icon(Icons.mail),
            title: const Text('Send Feedback'),
            onPressed: () {},
          ),
          ClickableCard(
            leading: const Icon(Icons.info),
            title: const Text('About App'),
            onPressed: () => showAboutDialog(
              context: context,
            ),
          )
        ],
      ),
    );
  }
}
