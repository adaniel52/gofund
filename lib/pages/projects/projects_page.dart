import 'package:flutter/material.dart';
import 'package:gofund/constants/theme.dart';
import 'package:gofund/models/project.dart';
import 'package:gofund/services/database/project_service.dart';
import 'package:gofund/utils/dialogs/show_error_dialog.dart';
import 'package:gofund/widgets/custom_list_view.dart';
import 'package:gofund/widgets/projects/project_tile.dart';

class ProjectsPage extends StatefulWidget {
  const ProjectsPage({super.key});

  @override
  State<ProjectsPage> createState() => _ProjectsPageState();
}

class _ProjectsPageState extends State<ProjectsPage> {
  final projectService = ProjectService.instance;

  bool _loading = true;
  List<Project> _projects = [];
  List _ongoingProjects = [];
  List _finishedProjects = [];

  @override
  void initState() {
    super.initState();
    _fetchProjects();
  }

  Future<void> _fetchProjects() async {
    try {
      setState(() => _loading = true);
      final projects = await projectService.getProjects();
      setState(() {
        _loading = false;
        _projects = projects;
        _ongoingProjects = _projects.where((e) => !e.isFinished).toList();
        _finishedProjects = _projects.where((e) => e.isFinished).toList();
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

  void onPop(bool shouldUpdate) {
    print(shouldUpdate);
    if (!shouldUpdate) return;
    _fetchProjects();
  }

  @override
  Widget build(BuildContext context) {
    if (_loading) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    if (_projects.isEmpty) {
      return Center(
        child: Column(
          spacing: AppSpacing.small,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('No projects available.'),
            TextButton(
              onPressed: _fetchProjects,
              child: const Text('Refresh'),
            ),
          ],
        ),
      );
    }

    final children = [
      if (_ongoingProjects.isNotEmpty) const Text('Ongoing Projects'),
      ..._ongoingProjects.map(
        (e) => ProjectTile(
          project: e,
          onPop: onPop,
        ),
      ),
      if (_ongoingProjects.isNotEmpty && _finishedProjects.isNotEmpty)
        const Divider(),
      if (_finishedProjects.isNotEmpty) const Text('Finished Projects'),
      ..._finishedProjects.map(
        (e) => ProjectTile(
          project: e,
          onPop: onPop,
        ),
      ),
    ];

    return DefaultTextStyle(
      style: Theme.of(context).textTheme.titleLarge!,
      child: RefreshIndicator(
        onRefresh: _fetchProjects,
        child: CustomListView(
          padding: AppSpacing.largePadding,
          children: children,
        ),
      ),
    );
  }
}
