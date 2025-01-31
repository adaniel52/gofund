import 'package:flutter/material.dart';
import 'package:gofund/constants/theme.dart';
import 'package:gofund/models/project.dart';
import 'package:gofund/pages/projects/project_details_page.dart';
import 'package:gofund/widgets/clickable_tile.dart';

class ProjectTile extends StatelessWidget {
  final Project project;
  const ProjectTile({
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

    final leading = AspectRatio(
      aspectRatio: 1,
      child: ClipRRect(
        borderRadius: AppRadius.smallRadius,
        child: Image(
          image: NetworkImage(project.imageUrl),
        ),
      ),
    );

    final content = Column(
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
        const SizedBox(height: AppSpacing.small * 0.5),
        LinearProgressIndicator(
          borderRadius: AppRadius.smallRadius,
          value: progressValue,
        ),
      ],
    );

    final trailing = const Icon(
      Icons.chevron_right_rounded,
      color: Colors.grey,
    );

    return ClickableTile(
      onPressed: onPressed,
      child: ListTile(
        contentPadding: AppSpacing.mediumPadding,
        leading: leading,
        title: content,
        trailing: trailing,
      ),
    );
  }
}
