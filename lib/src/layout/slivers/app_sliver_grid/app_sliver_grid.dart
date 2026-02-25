import 'package:flutter/material.dart';

class AppSliverGrid extends StatelessWidget {
  const AppSliverGrid({
    required this.itemCount, required this.itemBuilder, required this.gridDelegate, super.key,
  });

  final int itemCount;
  final Widget Function(BuildContext, int) itemBuilder;
  final SliverGridDelegate gridDelegate;

  @override
  Widget build(BuildContext context) {
    return SliverGrid(
      delegate: SliverChildBuilderDelegate(
        itemBuilder,
        childCount: itemCount,
      ),
      gridDelegate: gridDelegate,
    );
  }
}
