import 'package:flutter/material.dart';
import 'package:gofund/constants/theme.dart';

class CustomColumn extends StatelessWidget {
  const CustomColumn({
    super.key,
    this.padding = const EdgeInsets.all(0),
    required this.children,
  });

  final EdgeInsetsGeometry padding;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    final scrollController = ScrollController();
    return Scrollbar(
      controller: scrollController,
      child: SingleChildScrollView(
        controller: scrollController,
        child: Padding(
          padding: padding,
          child: Column(
            spacing: AppSpacing.small,
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: children,
          ),
        ),
      ),
    );
  }
}
