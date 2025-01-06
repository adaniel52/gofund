import 'package:flutter/material.dart';
import 'package:gofund/screens/donate_screen.dart';
import 'package:gofund/screens/progress_screen.dart';
import 'package:gofund/services/navigation_service.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('GoFund'),
      ),
      body: Column(
        children: [
          const Text('Welcome User!'),
          ElevatedButton(
            onPressed: () => NavigationService.instance.navigateTo(
              const DonateScreen(),
            ),
            child: const Text('Donate'),
          ),
          ElevatedButton(
            onPressed: () => NavigationService.instance.navigateTo(
              const ProgressScreen(),
            ),
            child: const Text('View Progress'),
          ),
        ],
      ),
    );
  }
}
