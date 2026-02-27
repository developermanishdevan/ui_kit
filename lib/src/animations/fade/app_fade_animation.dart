import 'package:flutter/material.dart';

/// A wrapper around [AnimatedOpacity] for easy fade animations.
class AppFadeAnimation extends StatelessWidget {
  /// The widget below this widget in the tree.
  final Widget child;

  /// The target opacity.
  final double opacity;

  /// The duration of the animation.
  final Duration duration;

  /// The curve to apply when animating the opacity.
  final Curve curve;

  /// Called every time the animation completes.
  final VoidCallback? onEnd;

  const AppFadeAnimation({
    super.key,
    required this.child,
    required this.opacity,
    this.duration = const Duration(milliseconds: 300),
    this.curve = Curves.easeInOut,
    this.onEnd,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      opacity: opacity,
      duration: duration,
      curve: curve,
      onEnd: onEnd,
      child: child,
    );
  }
}
