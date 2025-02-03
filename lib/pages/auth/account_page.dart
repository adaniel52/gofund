import 'package:flutter/material.dart';
import 'package:gofund/constants/theme.dart';
import 'package:gofund/models/app_user.dart';
import 'package:gofund/pages/auth/auth_gate.dart';
import 'package:gofund/services/auth_service.dart';
import 'package:gofund/utils/dialogs/show_confirmation_dialog.dart';
import 'package:gofund/widgets/custom_list_view.dart';
import 'package:gofund/widgets/settings/action_tile.dart';

class AccountPage extends StatelessWidget {
  final AppUser user;

  AccountPage({
    super.key,
    required this.user,
  });

  final authService = AuthService();

  @override
  Widget build(BuildContext context) {
    Future<void> logOut() async {
      final shouldLogout = await showConfirmationDialog(
        context,
        message: 'Are you sure you want to log out?',
      );
      if (!shouldLogout) return;
      await authService.logOut();
      if (!context.mounted) return;
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(
          builder: (context) => const AuthGate(),
        ),
        (route) => false,
      );
    }

    final children = [
      const CircleAvatar(
        radius: 52,
        child: Icon(Icons.person),
      ),
      ActionTile(
        icon: Icons.person,
        title: 'Name',
        label: user.name,
      ),
      ActionTile(
        icon: Icons.email,
        title: 'Email',
        label: user.email,
      ),
      const Divider(),
      ActionTile(
        icon: Icons.logout,
        title: 'Log Out',
        onPressed: logOut,
      ),
    ];

    return Scaffold(
      appBar: AppBar(),
      body: CustomListView(
        padding: AppSpacing.largePadding,
        children: children,
      ),
    );
  }
}
