import 'package:flutter/material.dart';

class AppListView extends StatelessWidget {
  const AppListView({
    required this.itemCount, required this.itemBuilder, super.key,
    this.padding,
    this.shrinkWrap = false,
    this.physics,
    this.scrollController,
  });

  final int itemCount;
  final IndexedWidgetBuilder itemBuilder;
  final EdgeInsetsGeometry? padding;
  final bool shrinkWrap;
  final ScrollPhysics? physics;
  final ScrollController? scrollController;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: itemCount,
      itemBuilder: itemBuilder,
      padding: padding,
      shrinkWrap: shrinkWrap,
      physics: physics ?? const BouncingScrollPhysics(),
      controller: scrollController,
    );
  }
}
