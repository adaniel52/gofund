import 'package:flutter/material.dart';
import 'package:gofund/constants/theme.dart';
import 'package:gofund/models/project.dart';
import 'package:gofund/widgets/custom_list_view.dart';

class ProjectDetailsPage extends StatelessWidget {
  final Project project;
  const ProjectDetailsPage({
    super.key,
    required this.project,
  });

  @override
  Widget build(BuildContext context) {
    double padding = AppSpacing.large;
    final width = MediaQuery.of(context).size.width;
    if (width > 400 + AppSpacing.large) padding = (width - 400) / 2;

    final progressValue = project.currentAmount / project.targetAmount;
    final currentAmount = project.currentAmount.toStringAsFixed(2);
    final targetAmount = project.targetAmount.toStringAsFixed(2);
    final percent = '${(progressValue * 100).toStringAsFixed(2)}%';
    final subtitle = 'RM $currentAmount / $targetAmount ($percent)';

    final children = [
      AspectRatio(
        aspectRatio: 1,
        child: ClipRRect(
          borderRadius: AppRadius.largeRadius,
          child: Image(
            width: double.infinity,
            image: NetworkImage(project.imageUrl),
            fit: BoxFit.cover,
          ),
        ),
      ),
      Text(
        project.name,
        textAlign: TextAlign.center,
        style: Theme.of(context).textTheme.displaySmall,
      ),
      Text(
        subtitle,
        textAlign: TextAlign.center,
        style: Theme.of(context).textTheme.titleMedium,
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
      body: CustomListView(
        padding: EdgeInsets.symmetric(
          vertical: AppSpacing.large,
          horizontal: padding,
        ),
        children: children,
      ),
    );
  }
}
