import 'package:flutter/material.dart';
import 'package:gofund/constants/theme.dart';
import 'package:gofund/models/database_user.dart';
import 'package:gofund/models/donation.dart';
import 'package:gofund/models/project.dart';
import 'package:gofund/services/database/project_service.dart';
import 'package:gofund/services/database/user_service.dart';
import 'package:gofund/widgets/tiles/base_tile.dart';

class DonationTile extends StatefulWidget {
  final Donation donation;

  const DonationTile({
    super.key,
    required this.donation,
  });

  @override
  State<DonationTile> createState() => _DonationTileState();
}

class _DonationTileState extends State<DonationTile> {
  final userService = UserService.instance;
  final projectService = ProjectService.instance;

  bool _loading = true;
  DatabaseUser? _databaseUser;
  late Project _project;

  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  Future<void> _fetchData() async {
    setState(() => _loading = true);
    final user = await userService.getDatabaseUserById(widget.donation.userId);
    final project =
        await projectService.getProjectById(widget.donation.projectId);
    setState(() {
      _databaseUser = user;
      _project = project;
      _loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_loading) {
      return const LinearProgressIndicator(
        borderRadius: AppRadius.smallRadius,
      );
    }

    if (_databaseUser == null) return const Text('Error syncing data.');

    final amount = widget.donation.amountText;
    final projectName = _project.name;
    final date = widget.donation.createdAt.toLocal();

    return BaseTile(
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(_databaseUser!.name),
          Text(
            '$amount · $projectName · $date',
            style: Theme.of(context).textTheme.labelMedium,
          ),
        ],
      ),
    );
  }
}
