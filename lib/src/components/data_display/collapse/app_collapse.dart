import 'package:flutter/material.dart';
import '../../../../ui_kit.dart';

enum AppCollapseAxis { vertical, horizontal }

class AppCollapse extends AppStatefulWrapper {
  final bool show;
  final Widget child;
  final Duration? duration;
  final Curve curve;
  final AppCollapseAxis axis;

  const AppCollapse({
    super.key,
    required this.show,
    required this.child,
    this.duration,
    this.curve = Curves.easeInOut,
    this.axis = AppCollapseAxis.vertical,
  });

  @override
  AppStatefulWrapperState<AppCollapse> createState() => _AppCollapseState();
}

class _AppCollapseState extends AppStatefulWrapperState<AppCollapse>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
    _animation = CurvedAnimation(parent: _controller, curve: widget.curve);
    if (widget.show) {
      _controller.value = 1.0;
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _controller.duration = widget.duration ?? AppDurations.normal;
  }

  @override
  void didUpdateWidget(AppCollapse oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.show != oldWidget.show) {
      if (widget.show) {
        _controller.forward();
      } else {
        _controller.reverse();
      }
    }
    if (widget.duration != oldWidget.duration) {
      _controller.duration = widget.duration ?? AppDurations.normal;
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget buildWidget(BuildContext context) {
    return SizeTransition(
      sizeFactor: _animation,
      axis: widget.axis == AppCollapseAxis.vertical
          ? Axis.vertical
          : Axis.horizontal,
      axisAlignment: -1.0,
      child: widget.child,
    );
  }
}
