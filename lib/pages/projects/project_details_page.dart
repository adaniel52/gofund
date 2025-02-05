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
    double horizontalPadding = AppSpacing.large;
    final width = MediaQuery.of(context).size.width;
    if (width > 400 + AppSpacing.large) horizontalPadding = (width - 400) / 2;

    final progressValue = project.collectedAmount / project.goalAmount;
    final currentAmount = project.collectedAmount.toStringAsFixed(2);
    final targetAmount = project.goalAmount.toStringAsFixed(2);
    final percent = '${(progressValue * 100).toStringAsFixed(2)}%';
    final subtitle = 'RM $currentAmount / $targetAmount ($percent)';

    final children = [
      if (project.imageUrl != null) ...[
        Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: AppRadius.largeRadius,
          ),
          clipBehavior: Clip.hardEdge,
          child: Image(
            fit: BoxFit.cover,
            image: NetworkImage(project.imageUrl!),
          ),
        ),
        const Divider(),
      ],
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
          backgroundColor: Theme.of(context).colorScheme.outlineVariant,
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
          horizontal: horizontalPadding,
        ),
        children: children,
      ),
    );
  }
}
