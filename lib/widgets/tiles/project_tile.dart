import 'package:flutter/material.dart';
import 'package:gofund/constants/theme.dart';
import 'package:gofund/models/project.dart';
import 'package:gofund/pages/projects/project_details_page.dart';
import 'package:gofund/widgets/tiles/base_tile.dart';

class ProjectTile extends StatelessWidget {
  final Project project;
  final void Function(bool)? onPop;
  const ProjectTile({
    super.key,
    required this.project,
    this.onPop,
  });

  @override
  Widget build(BuildContext context) {
    Future<void> onPressed() async {
      final shouldUpdate = await Navigator.of(context).push(
            MaterialPageRoute<bool>(
              builder: (context) => ProjectDetailsPage(project: project),
            ),
          ) ??
          false;
      if (onPop != null) onPop!(shouldUpdate);
    }

    final leading = (project.imageUrl == null)
        ? null
        : Container(
            width: 52,
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: AppRadius.smallRadius,
            ),
            clipBehavior: Clip.hardEdge,
            child: Image(
              image: NetworkImage(project.imageUrl!),
            ),
          );

    final content = Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          project.name,
          style: const TextStyle(height: 0),
        ),
        Text(
          project.progressText,
          style: Theme.of(context).textTheme.labelMedium,
        ),
        const SizedBox(height: AppSpacing.small * 0.5),
        Padding(
          padding: const EdgeInsets.all(1),
          child: LinearProgressIndicator(
            backgroundColor: Theme.of(context).colorScheme.outlineVariant,
            borderRadius: AppRadius.smallRadius,
            value: project.completionRatio,
          ),
        ),
      ],
    );

    return BaseTile(
      leading: leading,
      content: content,
      onPressed: onPressed,
    );
  }
}
