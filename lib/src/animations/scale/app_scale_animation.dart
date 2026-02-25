import 'package:flutter/material.dart';
import '../../foundation/tokens/durations/app_durations.dart';

class AppScaleAnimation extends StatefulWidget {
  const AppScaleAnimation({
    required this.child, super.key,
    this.duration = AppDurations.medium,
    this.delay = Duration.zero,
    this.curve = Curves.elasticOut,
    this.begin = 0.0,
    this.alignment = Alignment.center,
  });

  final Widget child;
  final Duration duration;
  final Duration delay;
  final Curve curve;
  final double begin;
  final Alignment alignment;

  @override
  State<AppScaleAnimation> createState() => _AppScaleAnimationState();
}

class _AppScaleAnimationState extends State<AppScaleAnimation>
    with SingleTickerProviderStateMixin {
  late final AnimationController _ctrl;
  late final Animation<double> _anim;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(vsync: this, duration: widget.duration);
    _anim = Tween<double>(begin: widget.begin, end: 1.0)
        .animate(CurvedAnimation(parent: _ctrl, curve: widget.curve));
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
  Widget build(BuildContext context) => ScaleTransition(
        scale: _anim,
        alignment: widget.alignment,
        child: widget.child,
      );
}
