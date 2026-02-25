import 'package:flutter/material.dart';
import '../../foundation/tokens/durations/app_durations.dart';

enum AppSlideDirection { fromTop, fromBottom, fromLeft, fromRight }

class AppSlideAnimation extends StatefulWidget {
  const AppSlideAnimation({
    required this.child, super.key,
    this.direction = AppSlideDirection.fromBottom,
    this.duration = AppDurations.medium,
    this.delay = Duration.zero,
    this.curve = Curves.easeOut,
    this.distance = 0.3,
    this.fade = true,
  });

  final Widget child;
  final AppSlideDirection direction;
  final Duration duration;
  final Duration delay;
  final Curve curve;
  final double distance;
  final bool fade;

  @override
  State<AppSlideAnimation> createState() => _AppSlideAnimationState();
}

class _AppSlideAnimationState extends State<AppSlideAnimation>
    with SingleTickerProviderStateMixin {
  late final AnimationController _ctrl;
  late final Animation<Offset> _slide;
  late final Animation<double> _fade;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(vsync: this, duration: widget.duration);

    final begin = switch (widget.direction) {
      AppSlideDirection.fromTop => Offset(0, -widget.distance),
      AppSlideDirection.fromBottom => Offset(0, widget.distance),
      AppSlideDirection.fromLeft => Offset(-widget.distance, 0),
      AppSlideDirection.fromRight => Offset(widget.distance, 0),
    };

    final curved = CurvedAnimation(parent: _ctrl, curve: widget.curve);
    _slide = Tween<Offset>(begin: begin, end: Offset.zero).animate(curved);
    _fade = Tween<double>(begin: 0.0, end: 1.0).animate(curved);

    Future.delayed(widget.delay, () {
      if (mounted) _ctrl.forward();
    });
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Widget w = SlideTransition(position: _slide, child: widget.child);
    if (widget.fade) w = FadeTransition(opacity: _fade, child: w);
    return w;
  }
}
