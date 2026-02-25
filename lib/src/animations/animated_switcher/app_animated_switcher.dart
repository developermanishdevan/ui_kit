import 'package:flutter/material.dart';
import '../../foundation/tokens/durations/app_durations.dart';

class AppAnimatedSwitcher extends StatelessWidget {
  const AppAnimatedSwitcher({
    required this.child, super.key,
    this.duration = AppDurations.normal,
    this.transitionBuilder,
    this.layoutBuilder,
  });

  final Widget child;
  final Duration duration;
  final AnimatedSwitcherTransitionBuilder? transitionBuilder;
  final AnimatedSwitcherLayoutBuilder? layoutBuilder;

  @override
  Widget build(BuildContext context) => AnimatedSwitcher(
        duration: duration,
        transitionBuilder:
            transitionBuilder ?? AnimatedSwitcher.defaultTransitionBuilder,
        layoutBuilder: layoutBuilder ?? AnimatedSwitcher.defaultLayoutBuilder,
        child: child,
      );
}
