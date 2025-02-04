import 'package:flutter/material.dart';
import 'package:gofund/constants/theme.dart';
import 'package:gofund/services/project_service.dart';
import 'package:gofund/widgets/custom_list_view.dart';
import 'package:gofund/widgets/projects/project_tile.dart';

class ProjectsPage extends StatelessWidget {
  const ProjectsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: ProjectService().getProjects(),
      builder: (context, snapshot) {
        if (snapshot.connectionState != ConnectionState.done) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        if (snapshot.hasError) {
          return Center(
            child: Text('Error: ${snapshot.error}'),
          );
        }

        final projects = snapshot.data ?? [];

        if (projects.isEmpty) {
          return const Center(
            child: Text('No projects available.'),
          );
        }

        final ongoingProjects = projects.where((e) => !e.isFinished);
        final finishedProjects = projects.where((e) => e.isFinished);

        final children = [
          if (ongoingProjects.isNotEmpty) const Text('Ongoing Projects'),
          ...ongoingProjects.map((e) => ProjectTile(project: e)),
          if (ongoingProjects.isNotEmpty && finishedProjects.isNotEmpty)
            const Divider(),
          if (finishedProjects.isNotEmpty) const Text('Finished Projects'),
          ...finishedProjects.map((e) => ProjectTile(project: e)),
        ];

        return DefaultTextStyle(
          style: Theme.of(context).textTheme.titleLarge!,
          child: CustomListView(
            padding: AppSpacing.largePadding,
            children: children,
          ),
        );
      },
    );
  }
}
