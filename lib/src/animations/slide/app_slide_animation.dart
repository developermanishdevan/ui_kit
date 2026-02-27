import 'package:flutter/material.dart';

/// A wrapper around [AnimatedSlide] for easy sliding animations.
class AppSlideAnimation extends StatelessWidget {
  /// The widget below this widget in the tree.
  final Widget child;

  /// The fractional offset from the original position.
  final Offset offset;

  /// The duration of the animation.
  final Duration duration;

  /// The curve to apply when animating the offset.
  final Curve curve;

  /// Called every time the animation completes.
  final VoidCallback? onEnd;

  const AppSlideAnimation({
    super.key,
    required this.child,
    required this.offset,
    this.duration = const Duration(milliseconds: 300),
    this.curve = Curves.easeInOut,
    this.onEnd,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedSlide(
      offset: offset,
      duration: duration,
      curve: curve,
      onEnd: onEnd,
      child: child,
    );
  }
}
