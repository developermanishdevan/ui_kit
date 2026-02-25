import 'package:flutter/material.dart';

import 'package:ui_kit/src/foundation/tokens/spacing/app_spacing.dart';

/// Constrained content container (max-width) for desktop layouts.
class AppContainer extends StatelessWidget {
  const AppContainer({
    required this.child, super.key,
    this.maxWidth = 1200.0,
    this.padding,
    this.center = true,
  });

  final Widget child;
  final double maxWidth;
  final EdgeInsetsGeometry? padding;
  final bool center;

  @override
  Widget build(BuildContext context) {
    Widget content = ConstrainedBox(
      constraints: BoxConstraints(maxWidth: maxWidth),
      child: Padding(
        padding:
            padding ?? const EdgeInsets.symmetric(horizontal: AppSpacing.base),
        child: child,
      ),
    );
    return center ? Center(child: content) : content;
  }
}
