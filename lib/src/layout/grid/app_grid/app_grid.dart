import 'package:flutter/material.dart';

/// Fixed column grid.
class AppGrid extends StatelessWidget {
  const AppGrid({
    required this.children, super.key,
    this.crossAxisCount = 2,
    this.mainAxisSpacing = 12.0,
    this.crossAxisSpacing = 12.0,
    this.childAspectRatio = 1.0,
    this.shrinkWrap = true,
    this.physics,
    this.padding,
  });

  final List<Widget> children;
  final int crossAxisCount;
  final double mainAxisSpacing;
  final double crossAxisSpacing;
  final double childAspectRatio;
  final bool shrinkWrap;
  final ScrollPhysics? physics;
  final EdgeInsetsGeometry? padding;

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: crossAxisCount,
      mainAxisSpacing: mainAxisSpacing,
      crossAxisSpacing: crossAxisSpacing,
      childAspectRatio: childAspectRatio,
      shrinkWrap: shrinkWrap,
      padding: padding,
      physics:
          physics ?? (shrinkWrap ? const NeverScrollableScrollPhysics() : null),
      children: children,
    );
  }
}
