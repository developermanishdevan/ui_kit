import 'package:flutter/material.dart';

/// A wrapper around [AnimatedSize] for easy size animations.
class AppSizeAnimation extends StatelessWidget {
  /// The widget below this widget in the tree.
  final Widget child;

  /// The duration of the animation when changing size.
  final Duration duration;

  /// The curve to apply when animating the size.
  final Curve curve;

  /// The duration of the return animation when changing size.
  final Duration? reverseDuration;

  /// The alignment of the child within the animated size bounds.
  final Alignment alignment;

  /// How to clip the content if it overflows.
  final Clip clipBehavior;

  /// Called every time the animation completes.
  final VoidCallback? onEnd;

  const AppSizeAnimation({
    super.key,
    required this.child,
    this.duration = const Duration(milliseconds: 300),
    this.curve = Curves.easeInOut,
    this.reverseDuration,
    this.alignment = Alignment.center,
    this.clipBehavior = Clip.hardEdge,
    this.onEnd,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedSize(
      duration: duration,
      curve: curve,
      reverseDuration: reverseDuration,
      alignment: alignment,
      clipBehavior: clipBehavior,
      onEnd: onEnd,
      child: child,
    );
  }
}
