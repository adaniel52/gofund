import 'package:flutter/material.dart';
import 'package:gofund/constants/theme.dart';

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

    return Scaffold(
      appBar: AppBar(
        title: const Text('Projects'),
      ),
      body: Padding(
        padding: AppSpacing.mediumPadding,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          spacing: AppSpacing.small,
          children: [
            const Text(
              'Ongoing Projects',
              style: AppTextStyles.subtitle,
            ),
            ProjectCard(
              imageUrl: url1,
              productName: 'Aircond',
              productAmount: 2,
              currentFund: 1000,
              targetFund: 4000,
            ),
            ProjectCard(
              imageUrl: url2,
              productName: 'Ceiling Fan',
              productAmount: 16,
              currentFund: 200,
              targetFund: 10000,
            ),
            const Divider(),
            const Text(
              'Finished Projects',
              style: AppTextStyles.subtitle,
            ),
            ProjectCard(
              imageUrl: url3,
              productName: 'Mihrab',
              productAmount: 1,
              currentFund: 5000,
              targetFund: 5000,
            ),
          ],
        ),
      ),
    );
  }
}

class ProjectCard extends StatelessWidget {
  final String imageUrl;
  final String productName;
  final int productAmount;
  final double currentFund;
  final double targetFund;

  const ProjectCard({
    super.key,
    required this.imageUrl,
    required this.productName,
    required this.productAmount,
    required this.currentFund,
    required this.targetFund,
  });

  @override
  Widget build(BuildContext context) {
    final double value = currentFund / targetFund;
    final double percentage = value * 100;

    return FilledButton.tonal(
      style: FilledButton.styleFrom(
        padding: const EdgeInsets.all(0),
        shape: const RoundedRectangleBorder(
          borderRadius: AppRadius.mediumRadius,
        ),
      ),
      onPressed: () {},
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.small,
        ),
        leading: ClipRRect(
          borderRadius: AppRadius.smallRadius,
          child: Image(
            image: NetworkImage(imageUrl),
          ),
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('$productName x$productAmount'),
            Text(
              'MYR $currentFund / $targetFund [$percentage%]',
              style: AppTextStyles.caption,
            ),
          ],
        ),
        subtitle: LinearProgressIndicator(
          value: value,
          borderRadius: AppRadius.smallRadius,
        ),
        trailing: const Icon(Icons.chevron_right),
      ),
    );
  }
}
