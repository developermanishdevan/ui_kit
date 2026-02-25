import 'package:flutter/material.dart';

class AppSliverAppBar extends StatelessWidget {
  const AppSliverAppBar({
    required this.title, super.key,
    this.flexibleSpace,
    this.expandedHeight,
    this.pinned = true,
    this.floating = false,
    this.actions,
    this.leading,
  });

  final Widget title;
  final Widget? flexibleSpace;
  final double? expandedHeight;
  final bool pinned;
  final bool floating;
  final List<Widget>? actions;
  final Widget? leading;

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      title: title,
      flexibleSpace: flexibleSpace,
      expandedHeight: expandedHeight,
      pinned: pinned,
      floating: floating,
      actions: actions,
      leading: leading,
    );
  }
}
