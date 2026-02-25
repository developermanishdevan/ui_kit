import 'package:flutter/material.dart';
import '../../foundation/tokens/colors/app_colors.dart';
import '../../foundation/tokens/spacing/app_spacing.dart';

class AppSidebar extends StatelessWidget {
  const AppSidebar({
    required this.items, super.key,
    this.header,
    this.footer,
    this.width = 280,
    this.backgroundColor,
  });

  final List<Widget> items;
  final Widget? header;
  final Widget? footer;
  final double width;
  final Color? backgroundColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      color: backgroundColor ?? AppColors.surface,
      child: Column(
        children: [
          if (header != null) header!,
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(vertical: AppSpacing.md),
              children: items,
            ),
          ),
          if (footer != null) footer!,
        ],
      ),
    );
  }
}
