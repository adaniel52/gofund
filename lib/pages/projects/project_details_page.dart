import 'package:flutter/material.dart';
import 'package:gofund/constants/theme.dart';
import 'package:gofund/models/project.dart';

class ProjectDetailsPage extends StatelessWidget {
  final Project project;
  const ProjectDetailsPage({
    super.key,
    required this.project,
  });

  @override
  Widget build(BuildContext context) {
    double padding = AppSpacing.medium;
    final width = MediaQuery.of(context).size.width;
    if (width > 400) {
      padding = (width - 400) / 2;
    }

    final progressValue = project.currentAmount / project.targetAmount;
    final currentAmount = project.currentAmount.toStringAsFixed(2);
    final targetAmount = project.targetAmount.toStringAsFixed(2);
    final percent = '${(progressValue * 100).toStringAsFixed(2)}%';
    final subtitle = 'RM $currentAmount / $targetAmount ($percent)';

    final children = [
      ClipRRect(
        borderRadius: AppRadius.largeRadius,
        child: Image(
          width: double.infinity,
          image: NetworkImage(project.imageUrl),
          fit: BoxFit.cover,
        ),
      ),
      Text(
        project.name,
        textAlign: TextAlign.center,
        style: Theme.of(context).textTheme.displayMedium,
      ),
      Text(
        subtitle,
        textAlign: TextAlign.center,
        style: Theme.of(context).textTheme.titleLarge,
      ),
      FractionallySizedBox(
        widthFactor: 0.75,
        child: LinearProgressIndicator(
          borderRadius: AppRadius.smallRadius,
          value: progressValue,
        ),
      ),
      const Divider(),
      Text(
        'Choose your preferred donation method:',
        textAlign: TextAlign.center,
        style: Theme.of(context).textTheme.labelLarge,
      ),
      Row(
        spacing: AppSpacing.small,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          FilledButton(
            onPressed: () {},
            child: const Text('Online Payment'),
          ),
          FilledButton.tonal(
            onPressed: () {},
            child: const Text('Manual Transfer'),
          ),
        ],
      )
    ];

    return Scaffold(
      appBar: AppBar(),
      body: ListView.separated(
        padding: EdgeInsets.symmetric(
          vertical: AppSpacing.medium,
          horizontal: padding,
        ),
        itemCount: children.length,
        itemBuilder: (context, index) {
          return children[index];
        },
        separatorBuilder: (context, index) {
          return const SizedBox(height: AppSpacing.small);
        },
      ),
    );
  }
}
