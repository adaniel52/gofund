import 'package:flutter/material.dart';
import 'package:gofund/constants/theme.dart';
import 'package:gofund/models/project.dart';
import 'package:gofund/pages/projects/project_details_page.dart';

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
            'https://static.wixstatic.com/media/95eccd_18b73ffa6fe349dcb1d2108e767741e5~mv2.jpg/v1/fill/w_306,h_306,al_c,q_80,usm_0.66_1.00_0.01,enc_avif,quality_auto/iphone%20se.jpg',
      ),
      Project(
        name: 'Aircond 2',
        currentAmount: 1000,
        targetAmount: 1000,
        imageUrl:
            'https://static.wixstatic.com/media/95eccd_18b73ffa6fe349dcb1d2108e767741e5~mv2.jpg/v1/fill/w_306,h_306,al_c,q_80,usm_0.66_1.00_0.01,enc_avif,quality_auto/iphone%20se.jpg',
      ),
      Project(
        name: 'Aircond 3',
        currentAmount: 9999,
        targetAmount: 1000,
        imageUrl:
            'https://static.wixstatic.com/media/95eccd_18b73ffa6fe349dcb1d2108e767741e5~mv2.jpg/v1/fill/w_306,h_306,al_c,q_80,usm_0.66_1.00_0.01,enc_avif,quality_auto/iphone%20se.jpg',
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
      ...ongoingProjects.map((e) => ProjectCard(project: e)),
      const Divider(),
      Text(
        'Finished Projects',
        style: Theme.of(context).textTheme.titleLarge,
      ),
      ...finishedProjects.map((e) => ProjectCard(project: e)),
    ];

    return ListView.separated(
      padding: AppSpacing.mediumPadding,
      itemCount: children.length,
      itemBuilder: (context, index) {
        return children[index];
      },
      separatorBuilder: (context, index) {
        return const SizedBox(height: AppSpacing.small);
      },
    );
  }
}

class ProjectCard extends StatelessWidget {
  final Project project;
  const ProjectCard({
    super.key,
    required this.project,
  });

  @override
  Widget build(BuildContext context) {
    final progressValue = project.currentAmount / project.targetAmount;
    final currentAmount = project.currentAmount.toStringAsFixed(2);
    final targetAmount = project.targetAmount.toStringAsFixed(2);
    final percent = '${(progressValue * 100).toStringAsFixed(2)}%';
    final subtitle = 'RM $currentAmount / $targetAmount ($percent)';

    void onPressed() {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => ProjectDetailsPage(project: project),
        ),
      );
    }

    return FilledButton(
      style: FilledButton.styleFrom(
        padding: const EdgeInsets.all(0),
        shape: const RoundedRectangleBorder(
          borderRadius: AppRadius.largeRadius,
        ),
        backgroundColor: Theme.of(context).colorScheme.surfaceContainerHighest,
        overlayColor: Theme.of(context).colorScheme.onSurface,
      ),
      onPressed: onPressed,
      child: ListTile(
        contentPadding: const EdgeInsets.fromLTRB(
          AppSpacing.medium,
          AppSpacing.medium,
          AppSpacing.small / 2,
          AppSpacing.medium,
        ),
        leading: AspectRatio(
          aspectRatio: 1,
          child: ClipRRect(
            borderRadius: AppRadius.mediumRadius,
            child: Image(
              image: NetworkImage(project.imageUrl),
            ),
          ),
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              project.name,
              style: Theme.of(context).textTheme.labelLarge!.copyWith(
                    height: 0,
                  ),
            ),
            Text(
              subtitle,
              style: Theme.of(context).textTheme.labelMedium,
            ),
            const SizedBox(height: AppSpacing.small),
            LinearProgressIndicator(
              borderRadius: AppRadius.smallRadius,
              value: progressValue,
            ),
          ],
        ),
        trailing: const Icon(
          Icons.chevron_right_rounded,
          size: 28,
        ),
      ),
    );
  }
}
