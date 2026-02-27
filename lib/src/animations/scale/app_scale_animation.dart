import 'package:flutter/material.dart';

/// A wrapper around [AnimatedScale] for easy scale animations.
class AppScaleAnimation extends StatelessWidget {
  /// The widget below this widget in the tree.
  final Widget child;

  /// The target scale.
  final double scale;

  /// The alignment of the scale origin.
  final Alignment alignment;

  /// The duration of the animation.
  final Duration duration;

  /// The curve to apply when animating the scale.
  final Curve curve;

  /// Called every time the animation completes.
  final VoidCallback? onEnd;

  const AppScaleAnimation({
    super.key,
    required this.child,
    required this.scale,
    this.alignment = Alignment.center,
    this.duration = const Duration(milliseconds: 300),
    this.curve = Curves.easeInOut,
    this.onEnd,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedScale(
      scale: scale,
      alignment: alignment,
      duration: duration,
      curve: curve,
      onEnd: onEnd,
      child: child,
    );
  }
}
