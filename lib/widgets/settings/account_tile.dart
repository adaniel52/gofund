import 'package:flutter/material.dart';
import 'package:gofund/models/app_user.dart';
import 'package:gofund/pages/auth/account_page.dart';
import 'package:gofund/widgets/base_tile.dart';

class AccountTile extends StatelessWidget {
  final AppUser user;

  const AccountTile({
    super.key,
    required this.user,
  });

  @override
  Widget build(BuildContext context) {
    return BaseTile(
      leading: const CircleAvatar(
        child: Icon(Icons.person),
      ),
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            user.name,
          ),
          Text(
            'View your account information',
            style: Theme.of(context).textTheme.labelMedium,
          ),
        ],
      ),
      onPressed: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => AccountPage(user: user),
          ),
        );
      },
    );
  }
}
