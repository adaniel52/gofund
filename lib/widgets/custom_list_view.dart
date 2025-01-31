import 'package:flutter/material.dart';
import 'package:gofund/constants/theme.dart';

class CustomListView extends StatelessWidget {
  const CustomListView({
    super.key,
    this.padding = AppSpacing.mediumPadding,
    required this.children,
  });

  final EdgeInsetsGeometry padding;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Scrollbar(
      child: ListView.separated(
        padding: padding,
        itemCount: children.length,
        itemBuilder: (context, index) {
          return children[index];
        },
        separatorBuilder: (context, index) {
          return const SizedBox(height: AppSpacing.small);
        },
      ),
    );
  }
}
