import 'package:flutter/material.dart';
import 'package:gofund/constants/theme.dart';
import 'package:gofund/models/project.dart';
import 'package:gofund/screens/project_details_screen.dart';
import 'package:gofund/services/navigation_service.dart';
import 'package:gofund/widgets/clickable_card.dart';
import 'package:gofund/widgets/scaffold_body_wrapper.dart';

class ProjectsScreen extends StatelessWidget {
  const ProjectsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final String url1 =
        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRh7jSGB0d-5Pg5SqdFXNzwiuBedLi2f4mobg&s';
    final String url2 =
        'https://d1pjg4o0tbonat.cloudfront.net/content/dam/midea-aem/my/fan-air-cooler-purifier/ceiling-fan/5-blades-ceiling-fan-with-remote-mfc-140cjr/gallery1.jpg/jcr:content/renditions/cq5dam.web.5000.5000.jpeg';
    final String url3 =
        'https://i.pinimg.com/236x/9b/b8/e7/9bb8e75c7c5358fb35a437fc447f69b9.jpg';

    final List<Project> projects = [
      Project(
        imageUrl: url1,
        productName: 'Aircond',
        productAmount: 2,
        currentFund: 1000,
        targetFund: 4000,
      ),
      Project(
        imageUrl: url2,
        productName: 'Ceiling Fan',
        productAmount: 16,
        currentFund: 239.2948,
        targetFund: 10000,
      ),
      Project(
        imageUrl: url3,
        productName: 'Mihrab',
        productAmount: 1,
        currentFund: 5390.2840,
        targetFund: 5000,
      ),
      Project(
        imageUrl: url3,
        productName: 'Mihrab',
        productAmount: 2,
        currentFund: 7500,
        targetFund: 5000,
      ),
    ];

    final ongoingProjects = projects.where((e) => e.currentFund < e.targetFund);
    final finishedProjects =
        projects.where((e) => e.currentFund >= e.targetFund);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Projects'),
      ),
      body: ScaffoldBodyWrapper(
        children: [
          const Text(
            'Ongoing Projects',
            style: AppTextStyles.subtitle,
          ),
          ...ongoingProjects.map(
            (e) => ProjectCard(project: e),
          ),
          const Divider(),
          const Text(
            'Finished Projects',
            style: AppTextStyles.subtitle,
          ),
          ...finishedProjects.map(
            (e) => ProjectCard(project: e),
          ),
        ],
      ),
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
    final double value = project.currentFund / project.targetFund;
    final double percentage = value * 100;

    return ClickableCard(
      onPressed: () => NavigationService.instance.navigateTo(
        ProjectDetailsScreen(project: project),
      ),
      leading: Image(
        image: NetworkImage(project.imageUrl),
      ),
      title: Text(
        '${project.productName} x${project.productAmount}',
        style: const TextStyle(height: 0),
      ),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        // spacing: AppSpacing.small,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'RM ${project.currentFund.toStringAsFixed(2)} / ${project.targetFund.toStringAsFixed(2)}',
                style: const TextStyle(fontSize: 12),
              ),
              Text(
                '${percentage.toStringAsFixed(2)}%',
                style: const TextStyle(fontSize: 12),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.medium),
          LinearProgressIndicator(
            value: value,
            borderRadius: AppRadius.smallRadius,
          ),
        ],
      ),
    );
  }
}
