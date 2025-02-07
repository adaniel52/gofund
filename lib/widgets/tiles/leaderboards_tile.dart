import 'package:flutter/material.dart';
import 'package:gofund/models/database_user.dart';
import 'package:gofund/widgets/tiles/base_tile.dart';

class LeaderboardsTile extends StatelessWidget {
  final int number;
  final DatabaseUser databaseUser;
  const LeaderboardsTile({
    super.key,
    required this.number,
    required this.databaseUser,
  });

  @override
  Widget build(BuildContext context) {
    return BaseTile(
      leading: Text('$number.'),
      content: Text(databaseUser.name),
      label: databaseUser.totalDonatedText,
    );
  }
}
