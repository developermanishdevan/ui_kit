import 'package:flutter/material.dart';

/// A wrapper around [AnimatedContainer] with sensible defaults for quick UI transitions.
class AppAnimatedContainer extends StatelessWidget {
  /// The widget below this widget in the tree.
  final Widget? child;

  /// The duration over which to animate the parameters of this container.
  final Duration duration;

  /// The curve to apply when animating the parameters of this container.
  final Curve curve;

  /// The decoration to paint behind the [child].
  final Decoration? decoration;

  /// The width of the container.
  final double? width;

  /// The height of the container.
  final double? height;

  /// The padding to apply to the [child].
  final EdgeInsetsGeometry? padding;

  /// The margin to surround the container.
  final EdgeInsetsGeometry? margin;

  /// Constraints to apply to the [child].
  final BoxConstraints? constraints;

  /// The color to paint behind the [child].
  final Color? color;

  /// Called every time the animation completes.
  final VoidCallback? onEnd;

  const AppAnimatedContainer({
    super.key,
    this.child,
    this.duration = const Duration(milliseconds: 300),
    this.curve = Curves.easeInOut,
    this.decoration,
    this.width,
    this.height,
    this.padding,
    this.margin,
    this.constraints,
    this.color,
    this.onEnd,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: duration,
      curve: curve,
      decoration: decoration,
      width: width,
      height: height,
      padding: padding,
      margin: margin,
      constraints: constraints,
      color: color,
      onEnd: onEnd,
      child: child,
    );
  }
}
