import 'package:flutter/material.dart';
import '../../foundation/tokens/durations/app_durations.dart';

class AppAnimatedContainer extends StatelessWidget {
  const AppAnimatedContainer({
    super.key,
    this.child,
    this.duration = AppDurations.medium,
    this.curve = Curves.easeInOut,
    this.width,
    this.height,
    this.color,
    this.padding,
    this.margin,
    this.decoration,
    this.alignment,
  });

  final Widget? child;
  final Duration duration;
  final Curve curve;
  final double? width;
  final double? height;
  final Color? color;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final Decoration? decoration;
  final AlignmentGeometry? alignment;

  @override
  Widget build(BuildContext context) => AnimatedContainer(
        duration: duration,
        curve: curve,
        width: width,
        height: height,
        color: decoration == null ? color : null,
        padding: padding,
        margin: margin,
        decoration: decoration,
        alignment: alignment,
        child: child,
      );
}
