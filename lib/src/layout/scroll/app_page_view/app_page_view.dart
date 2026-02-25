import 'package:flutter/material.dart';

class AppPageView extends StatelessWidget {
  const AppPageView({
    required this.children, super.key,
    this.controller,
    this.onPageChanged,
    this.scrollDirection = Axis.horizontal,
    this.physics,
  });

  final List<Widget> children;
  final PageController? controller;
  final ValueChanged<int>? onPageChanged;
  final Axis scrollDirection;
  final ScrollPhysics? physics;

  @override
  Widget build(BuildContext context) {
    return PageView(
      controller: controller,
      onPageChanged: onPageChanged,
      scrollDirection: scrollDirection,
      physics: physics,
      children: children,
    );
  }
}
