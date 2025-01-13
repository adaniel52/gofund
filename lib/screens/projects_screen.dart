import 'package:flutter/material.dart';
import 'package:gofund/constants/theme.dart';
import 'package:gofund/models/project.dart';
import 'package:gofund/screens/project_details_screen.dart';
import 'package:gofund/services/navigation_service.dart';
import 'package:gofund/widgets/clickable_card.dart';

class ProjectsScreen extends StatelessWidget {
  const ProjectsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final String url1 =
        'https://static.wixstatic.com/media/95eccd_18b73ffa6fe349dcb1d2108e767741e5~mv2.jpg/v1/fill/w_210,h_210,al_c,q_80,usm_0.66_1.00_0.01,enc_avif,quality_auto/iphone%20se.jpg';
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
        currentFund: 200,
        targetFund: 10000,
      ),
      Project(
        imageUrl: url3,
        productName: 'Mihrab',
        productAmount: 1,
        currentFund: 5000,
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
      body: SingleChildScrollView(
        child: Padding(
          padding: AppSpacing.mediumPadding,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            spacing: AppSpacing.small,
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
        ),
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
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            '${project.productName} x${project.productAmount}',
            style: const TextStyle(height: 0),
          ),
          Text(
            'MYR ${project.currentFund} / ${project.targetFund} [$percentage%]',
            style: AppTextStyles.caption,
          ),
          const SizedBox(height: AppSpacing.small),
        ],
      ),
      subtitle: LinearProgressIndicator(
        value: value,
        borderRadius: AppRadius.smallRadius,
      ),
    );
  }
}
