import 'package:flutter/material.dart';
import 'package:gofund/constants/theme.dart';
import 'package:gofund/models/database_user.dart';
import 'package:gofund/models/donation.dart';
import 'package:gofund/models/project.dart';
import 'package:gofund/services/auth_service.dart';
import 'package:gofund/services/database/donation_service.dart';
import 'package:gofund/services/database/project_service.dart';
import 'package:gofund/services/database/user_service.dart';
import 'package:gofund/utils/dialogs/show_error_dialog.dart';
import 'package:gofund/widgets/custom_list_view.dart';
import 'package:gofund/widgets/tiles/action_tile.dart';
import 'package:gofund/widgets/tiles/donation_tile.dart';
import 'package:gofund/widgets/tiles/leaderboards_tile.dart';
import 'package:gofund/widgets/tiles/project_tile.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final authService = AuthService.instance;
  final projectService = ProjectService.instance;
  final donationService = DonationService.instance;
  final userService = UserService.instance;

  bool _loading = true;
  late Project _randomProject;
  List<DatabaseUser> _topDatabaseUsers = [];
  List<Donation> _recentDonations = [];
  DatabaseUser? _databaseUser;

  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  Future<void> _fetchData() async {
    try {
      setState(() => _loading = true);
      final project = await projectService.getRandomProject();
      final donations = await donationService.getRecentDonations();
      final topDatabaseUsers = await userService.getTopDatabaseUsers();
      final databaseUser = await userService.getDatabaseUser();
      setState(() {
        _randomProject = project;
        _recentDonations = donations;
        _topDatabaseUsers = topDatabaseUsers;
        _databaseUser = databaseUser;
        _loading = false;
      });
    } catch (e) {
      if (!mounted) return;
      setState(() => _loading = false);
      showErrorDialog(
        context,
        message: e.toString(),
      );
    }
  }

  Future<void> onPop(bool shouldUpdate) async {
    if (!shouldUpdate) return;
    await _fetchData();
  }

  @override
  Widget build(BuildContext context) {
    String userName = authService.getUser()!.name;

    if (_loading) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    if (_databaseUser == null) {
      return Center(
        child: Column(
          spacing: AppSpacing.small,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Error syncing data.'),
            TextButton(
              onPressed: _fetchData,
              child: const Text('Retry'),
            ),
          ],
        ),
      );
    }

    final children = [
      Text(
        'Welcome back, $userName!',
        style: Theme.of(context).textTheme.titleMedium,
      ),
      const Divider(),

      //stats
      Text(
        'Your Stats',
        style: Theme.of(context).textTheme.titleLarge,
      ),
      ActionTile(
        icon: Icons.volunteer_activism,
        title: 'Total Donated',
        label: _databaseUser!.totalDonatedText,
      ),
      const Divider(),

      //featured
      Text(
        'Featured Project',
        style: Theme.of(context).textTheme.titleLarge,
      ),
      ProjectTile(
        project: _randomProject,
        onPop: onPop,
      ),
      const Divider(),

      //leaderboard
      Text(
        'Leaderboards',
        style: Theme.of(context).textTheme.titleLarge,
      ),
      if (_topDatabaseUsers.isNotEmpty)
        ..._topDatabaseUsers.map(
          (e) {
            final number = _topDatabaseUsers.indexOf(e) + 1;
            return LeaderboardsTile(number: number, databaseUser: e);
          },
        ),
      if (_topDatabaseUsers.isEmpty) const Text('No users.'),
      const Divider(),

      //recent
      Text(
        'Recent Donations',
        style: Theme.of(context).textTheme.titleLarge,
      ),
      if (_recentDonations.isNotEmpty)
        ..._recentDonations.map((e) => DonationTile(donation: e)),
      if (_recentDonations.isEmpty) const Text('No recent donations.'),
    ];

    return RefreshIndicator(
      onRefresh: _fetchData,
      child: CustomListView(
        padding: AppSpacing.largePadding,
        children: children,
      ),
    );
  }
}
