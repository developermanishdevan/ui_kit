import 'package:flutter/material.dart';

/// A utility widget that animates the entrance of a list of children
/// in a staggered fashion using opacity and slide transitions.
class AppStaggeredAnimation extends StatefulWidget {
  /// The children widgets to animate.
  final List<Widget> children;

  /// The duration of the entrance animation for each individual item.
  final Duration itemDuration;

  /// The initial delay before the first item starts animating.
  final Duration initialDelay;

  /// The delay between consecutive children starting their animation.
  final Duration staggerDelay;

  /// Defines whether to layout children in a row or column.
  final Axis axis;

  /// Determines layout behavior on the main axis.
  final MainAxisSize mainAxisSize;

  const AppStaggeredAnimation({
    super.key,
    required this.children,
    this.itemDuration = const Duration(milliseconds: 400),
    this.initialDelay = Duration.zero,
    this.staggerDelay = const Duration(milliseconds: 100),
    this.axis = Axis.vertical,
    this.mainAxisSize = MainAxisSize.min,
  });

  @override
  State<AppStaggeredAnimation> createState() => _AppStaggeredAnimationState();
}

class _AppStaggeredAnimationState extends State<AppStaggeredAnimation> {
  @override
  Widget build(BuildContext context) {
    final children = List.generate(widget.children.length, (index) {
      return _StaggeredItem(
        delay: widget.initialDelay + (widget.staggerDelay * index),
        duration: widget.itemDuration,
        axis: widget.axis,
        child: widget.children[index],
      );
    });

    if (widget.axis == Axis.vertical) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: widget.mainAxisSize,
        children: children,
      );
    } else {
      return Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: widget.mainAxisSize,
        children: children,
      );
    }
  }
}

class _StaggeredItem extends StatefulWidget {
  final Widget child;
  final Duration delay;
  final Duration duration;
  final Axis axis;

  const _StaggeredItem({
    required this.child,
    required this.delay,
    required this.duration,
    required this.axis,
  });

  @override
  State<_StaggeredItem> createState() => _StaggeredItemState();
}

class _StaggeredItemState extends State<_StaggeredItem>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _opacity;
  late final Animation<Offset> _slide;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: widget.duration);

    _opacity = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));

    final beginOffset = widget.axis == Axis.vertical
        ? const Offset(0.0, 0.2) // slide up
        : const Offset(0.2, 0.0); // slide left

    _slide = Tween<Offset>(
      begin: beginOffset,
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic));

    Future.delayed(widget.delay, () {
      if (mounted) {
        _controller.forward();
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _opacity,
      child: SlideTransition(position: _slide, child: widget.child),
    );
  }
}
