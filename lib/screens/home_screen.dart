import 'package:flutter/material.dart';
import 'package:gofund/constants/theme.dart';
import 'package:gofund/widgets/scaffold_body_wrapper.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('GoFund'),
      ),
      body: ScaffoldBodyWrapper(
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
    );
  }
}
