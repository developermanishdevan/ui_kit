import 'package:flutter/material.dart';

/// A wrapper widget that provides an [AnimationController] to its builder.
/// This prevents developers from having to create a custom [StatefulWidget]
/// containing a [SingleTickerProviderStateMixin] when they just need
/// a simple animation controller.
class AppAnimationControllerWrapper extends StatefulWidget {
  /// The duration of the internal animation controller.
  final Duration duration;

  /// The builder that takes the [AnimationController] for rendering UI.
  final Widget Function(BuildContext context, AnimationController controller)
  builder;

  /// Whether the animation should automatically start playing upon initialization.
  final bool autoPlay;

  /// Whether the animation should repeat indefinitely instead of playing once.
  final bool repeat;

  const AppAnimationControllerWrapper({
    super.key,
    required this.duration,
    required this.builder,
    this.autoPlay = true,
    this.repeat = false,
  });

  @override
  State<AppAnimationControllerWrapper> createState() =>
      _AppAnimationControllerWrapperState();
}

class _AppAnimationControllerWrapperState
    extends State<AppAnimationControllerWrapper>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: widget.duration);

    if (widget.autoPlay) {
      if (widget.repeat) {
        _controller.repeat();
      } else {
        _controller.forward();
      }
    }
  }

  @override
  void didUpdateWidget(AppAnimationControllerWrapper oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.duration != oldWidget.duration) {
      _controller.duration = widget.duration;
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return widget.builder(context, _controller);
  }
}
