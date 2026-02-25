import 'package:flutter/material.dart';

class AppSliverList extends StatelessWidget {
  const AppSliverList({
    required this.itemCount, required this.itemBuilder, super.key,
  });

  final int itemCount;
  final Widget Function(BuildContext, int) itemBuilder;

  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        itemBuilder,
        childCount: itemCount,
      ),
    );
  }
}
