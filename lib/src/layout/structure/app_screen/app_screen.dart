import 'package:flutter/material.dart';
import 'package:ui_kit/src/foundation/tokens/spacing/app_spacing.dart';

/// A full-screen content container with optional padding and scroll.
class AppScreen extends StatelessWidget {
  const AppScreen({
    required this.child, super.key,
    this.padding,
    this.scrollable = false,
    this.backgroundColor,
    this.alignment,
  });

  final Widget child;
  final EdgeInsetsGeometry? padding;
  final bool scrollable;
  final Color? backgroundColor;
  final AlignmentGeometry? alignment;

  @override
  Widget build(BuildContext context) {
    Widget content = Padding(
      padding:
          padding ?? const EdgeInsets.symmetric(horizontal: AppSpacing.base),
      child: child,
    );

    if (scrollable) {
      content = SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: content,
      );
    }

    return Container(
      color: backgroundColor,
      alignment: alignment,
      child: content,
    );
  }
}
