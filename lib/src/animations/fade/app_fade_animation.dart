import 'package:flutter/material.dart';
import '../../foundation/tokens/durations/app_durations.dart';

class AppFadeAnimation extends StatefulWidget {
  const AppFadeAnimation({
    required this.child, super.key,
    this.duration = AppDurations.medium,
    this.delay = Duration.zero,
    this.curve = Curves.easeIn,
    this.begin = 0.0,
  });

  final Widget child;
  final Duration duration;
  final Duration delay;
  final Curve curve;
  final double begin;

  @override
  State<AppFadeAnimation> createState() => _AppFadeAnimationState();
}

class _AppFadeAnimationState extends State<AppFadeAnimation>
    with SingleTickerProviderStateMixin {
  late final AnimationController _ctrl;
  late final Animation<double> _anim;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(vsync: this, duration: widget.duration);
    _anim = Tween<double>(begin: widget.begin, end: 1.0)
        .animate(CurvedAnimation(parent: _ctrl, curve: widget.curve));

    if (widget.delay == Duration.zero) {
      _ctrl.forward();
    } else {
      Future.delayed(widget.delay, () {
        if (mounted) _ctrl.forward();
      });
    }
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) =>
      FadeTransition(opacity: _anim, child: widget.child);
}
