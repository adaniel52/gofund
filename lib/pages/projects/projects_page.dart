import 'package:flutter/material.dart';
import 'package:gofund/models/project.dart';
import 'package:gofund/widgets/custom_list_view.dart';
import 'package:gofund/widgets/projects/project_tile.dart';

class ProjectsPage extends StatelessWidget {
  const ProjectsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final projects = [
      Project(
        name: 'Aircond 1',
        currentAmount: 600,
        targetAmount: 1000,
        imageUrl:
            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRh7jSGB0d-5Pg5SqdFXNzwiuBedLi2f4mobg&s',
      ),
      Project(
        name: 'Aircond 2',
        currentAmount: 1000,
        targetAmount: 1000,
        imageUrl:
            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRh7jSGB0d-5Pg5SqdFXNzwiuBedLi2f4mobg&s',
      ),
      Project(
        name: 'Aircond 3',
        currentAmount: 9999,
        targetAmount: 1000,
        imageUrl:
            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRh7jSGB0d-5Pg5SqdFXNzwiuBedLi2f4mobg&s',
      ),
    ];

    final ongoingProjects = projects.where(
      (e) => e.currentAmount < e.targetAmount,
    );

    final finishedProjects = projects.where(
      (e) => e.currentAmount >= e.targetAmount,
    );

    final children = [
      Text(
        'Ongoing Projects',
        style: Theme.of(context).textTheme.titleLarge,
      ),
      ...ongoingProjects.map((e) => ProjectTile(project: e)),
      const Divider(),
      Text(
        'Finished Projects',
        style: Theme.of(context).textTheme.titleLarge,
      ),
      ...finishedProjects.map((e) => ProjectTile(project: e)),
    ];

    return CustomListView(children: children);
  }
}
