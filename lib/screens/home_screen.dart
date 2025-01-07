import 'package:flutter/material.dart';
import 'package:gofund/constants/theme.dart';
import 'package:gofund/screens/donate_screen.dart';
import 'package:gofund/screens/projects_screen.dart';
import 'package:gofund/services/navigation_service.dart';
import 'package:gofund/widgets/custom_button.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('GoFund'),
      ),
      body: Padding(
        padding: AppSpacing.mediumPadding,
        child: Column(
          spacing: AppSpacing.small,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Welcome User!',
              style: AppTextStyles.subtitle,
            ),
            CustomButton(
              text: 'Donate',
              onPressed: () => NavigationService.instance.navigateTo(
                const DonateScreen(),
              ),
            ),
            CustomButton(
              text: 'View Progress',
              onPressed: () => NavigationService.instance.navigateTo(
                const ProjectsScreen(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
