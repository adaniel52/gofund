import 'package:flutter/material.dart';
import 'package:gofund/constants/theme.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('GoFund'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: AppSpacing.mediumPadding,
          child: Column(
            spacing: AppSpacing.small,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text(
                'Welcome User!',
                style: AppTextStyles.subtitle,
              ),
              Container(
                color: Colors.grey,
                width: double.infinity,
                height: 300,
                child: const Center(
                  child: Text('*Insert a random project here*'),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
