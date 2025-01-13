import 'package:flutter/material.dart';
import 'package:gofund/constants/theme.dart';

class ScaffoldBodyWrapper extends StatelessWidget {
  final List<Widget> children;
  const ScaffoldBodyWrapper({
    super.key,
    required this.children,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: AppSpacing.mediumPadding,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          spacing: AppSpacing.small,
          children: children,
        ),
      ),
    );
  }
}
