import 'package:flutter/material.dart';

class AppPullToRefresh extends StatelessWidget {
  const AppPullToRefresh({
    required this.child, required this.onRefresh, super.key,
    this.color,
    this.backgroundColor,
  });

  final Widget child;
  final Future<void> Function() onRefresh;
  final Color? color;
  final Color? backgroundColor;

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: onRefresh,
      color: color ?? Theme.of(context).colorScheme.primary,
      backgroundColor: backgroundColor ?? Theme.of(context).colorScheme.surface,
      child: child,
    );
  }
}
