import 'package:flutter/material.dart';
import '../../foundation/tokens/durations/app_durations.dart';
import '../slide/app_slide_animation.dart';

/// Animates a list of children with staggered delays.
class AppStaggeredAnimation extends StatefulWidget {
  const AppStaggeredAnimation({
    required this.children, super.key,
    this.staggerDelay = const Duration(milliseconds: 80),
    this.itemDuration = AppDurations.medium,
    this.direction = AppSlideDirection.fromBottom,
    this.initialDelay = Duration.zero,
  });

  final List<Widget> children;
  final Duration staggerDelay;
  final Duration itemDuration;
  final AppSlideDirection direction;
  final Duration initialDelay;

  @override
  State<AppStaggeredAnimation> createState() => _AppStaggeredAnimationState();
}

class _AppStaggeredAnimationState extends State<AppStaggeredAnimation> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(widget.children.length, (i) {
        return AppSlideAnimation(
          delay: widget.initialDelay + (widget.staggerDelay * i),
          duration: widget.itemDuration,
          direction: widget.direction,
          child: widget.children[i],
        );
      }),
    );
  }
}
