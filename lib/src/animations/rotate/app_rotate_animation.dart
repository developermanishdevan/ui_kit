import 'package:flutter/material.dart';

/// A wrapper around [AnimatedRotation] for easy rotation animations.
class AppRotateAnimation extends StatelessWidget {
  /// The widget below this widget in the tree.
  final Widget child;

  /// The amount of rotation in turns. (e.g., 0.5 is half a rotation).
  final double turns;

  /// The alignment of the rotation origin.
  final Alignment alignment;

  /// The duration of the animation.
  final Duration duration;

  /// The curve to apply when animating the rotation.
  final Curve curve;

  /// Called every time the animation completes.
  final VoidCallback? onEnd;

  const AppRotateAnimation({
    super.key,
    required this.child,
    required this.turns,
    this.alignment = Alignment.center,
    this.duration = const Duration(milliseconds: 300),
    this.curve = Curves.easeInOut,
    this.onEnd,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedRotation(
      turns: turns,
      alignment: alignment,
      duration: duration,
      curve: curve,
      onEnd: onEnd,
      child: child,
    );
  }
}
