import 'package:flutter/material.dart';
import 'package:ui_kit/src/foundation/tokens/colors/app_colors.dart';
import 'package:ui_kit/src/foundation/tokens/typography/app_typography.dart';
import 'package:ui_kit/src/foundation/tokens/radius/app_radius.dart';

class AppTooltip extends StatelessWidget {
  const AppTooltip({
    required this.message, required this.child, super.key,
    this.preferBelow = true,
    this.triggerMode,
    this.showDuration,
    this.waitDuration,
  });

  final String message;
  final Widget child;
  final bool preferBelow;
  final TooltipTriggerMode? triggerMode;
  final Duration? showDuration;
  final Duration? waitDuration;

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: message,
      preferBelow: preferBelow,
      triggerMode: triggerMode,
      showDuration: showDuration,
      waitDuration: waitDuration,
      decoration: const BoxDecoration(
        color: AppColors.grey900,
        borderRadius: AppRadius.smAll,
      ),
      textStyle: AppTypography.caption.copyWith(color: AppColors.white),
      child: child,
    );
  }
}
