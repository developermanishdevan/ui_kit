import 'package:flutter/material.dart';

/// A wrapper around [AnimatedSwitcher] designed for seamless widget replacements.
class AppAnimatedSwitcher extends StatelessWidget {
  /// The current child widget to display.
  final Widget? child;

  /// The duration of the transition.
  final Duration duration;

  /// The duration of the reverse transition.
  final Duration? reverseDuration;

  /// The curve used for the transition.
  final Curve switchInCurve;

  /// The curve used for the reverse transition.
  final Curve switchOutCurve;

  /// A builder that defines the transition between widgets.
  /// Uses a scale and fade transition by default if not provided.
  final AnimatedSwitcherTransitionBuilder? transitionBuilder;

  /// The layout builder for managing sizes during transition.
  final AnimatedSwitcherLayoutBuilder layoutBuilder;

  const AppAnimatedSwitcher({
    super.key,
    this.child,
    this.duration = const Duration(milliseconds: 300),
    this.reverseDuration,
    this.switchInCurve = Curves.easeInOut,
    this.switchOutCurve = Curves.easeInOut,
    this.transitionBuilder,
    this.layoutBuilder = AnimatedSwitcher.defaultLayoutBuilder,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: duration,
      reverseDuration: reverseDuration,
      switchInCurve: switchInCurve,
      switchOutCurve: switchOutCurve,
      transitionBuilder:
          transitionBuilder ?? AnimatedSwitcher.defaultTransitionBuilder,
      layoutBuilder: layoutBuilder,
      child: child,
    );
  }
}
