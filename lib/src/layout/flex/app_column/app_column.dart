import 'package:flutter/material.dart';
import 'package:ui_kit/src/foundation/tokens/spacing/app_spacing.dart';

/// Column with built-in gap support.
class AppColumn extends StatelessWidget {
  const AppColumn({
    required this.children, super.key,
    this.gap = AppSpacing.sm,
    this.mainAxisAlignment = MainAxisAlignment.start,
    this.crossAxisAlignment = CrossAxisAlignment.start,
    this.mainAxisSize = MainAxisSize.min,
  });

  final List<Widget> children;
  final double gap;
  final MainAxisAlignment mainAxisAlignment;
  final CrossAxisAlignment crossAxisAlignment;
  final MainAxisSize mainAxisSize;

  @override
  Widget build(BuildContext context) {
    final separated = <Widget>[];
    for (int i = 0; i < children.length; i++) {
      separated.add(children[i]);
      if (i < children.length - 1) separated.add(SizedBox(height: gap));
    }
    return Column(
      mainAxisAlignment: mainAxisAlignment,
      crossAxisAlignment: crossAxisAlignment,
      mainAxisSize: mainAxisSize,
      children: separated,
    );
  }
}
