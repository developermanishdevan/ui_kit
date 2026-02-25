import 'package:flutter/material.dart';
import '../../foundation/tokens/durations/app_durations.dart';

enum AppTransitionType { fade, slide, slideUp, scale, rotate }

class AppRouteTransition<T> extends PageRouteBuilder<T> {
  AppRouteTransition({
    required Widget page,
    this.type = AppTransitionType.slide,
    super.settings,
    Duration duration = AppDurations.page,
  }) : super(
          transitionDuration: duration,
          reverseTransitionDuration: duration,
          pageBuilder: (_, __, ___) => page,
          transitionsBuilder: (ctx, anim, secAnim, child) {
            final curved = CurvedAnimation(
              parent: anim,
              curve: Curves.easeInOut,
            );
            return switch (type) {
              AppTransitionType.fade =>
                FadeTransition(opacity: curved, child: child),
              AppTransitionType.scale =>
                ScaleTransition(scale: curved, child: child),
              AppTransitionType.slideUp => SlideTransition(
                  position:
                      Tween<Offset>(begin: const Offset(0, 1), end: Offset.zero)
                          .animate(curved),
                  child: child,
                ),
              AppTransitionType.rotate =>
                RotationTransition(turns: curved, child: child),
              _ => SlideTransition(
                  position:
                      Tween<Offset>(begin: const Offset(1, 0), end: Offset.zero)
                          .animate(curved),
                  child: child,
                ),
            };
          },
        );

  final AppTransitionType type;
}
