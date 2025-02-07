import 'package:flutter/material.dart';
import 'package:gofund/constants/theme.dart';
import 'package:gofund/services/auth_service.dart';
import 'package:gofund/widgets/custom_list_view.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final authService = AuthService.instance;
    final userName = authService.getUser()!.name;
    final children = [
      Text('Welcome back, $userName'),
      const Divider(),
      const Text('Your Stats'),
      const Divider(),
      const Text('Leaderboards'),
    ];

    return DefaultTextStyle(
      style: Theme.of(context).textTheme.titleLarge!,
      child: CustomListView(
        padding: AppSpacing.largePadding,
        children: children,
      ),
    );
  }
}
