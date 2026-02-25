import 'package:flutter/material.dart';
import 'package:ui_kit/src/foundation/tokens/colors/app_colors.dart';
import 'package:ui_kit/src/foundation/tokens/radius/app_radius.dart';
import 'package:ui_kit/src/foundation/tokens/spacing/app_spacing.dart';

class AppModal extends StatelessWidget {
  const AppModal({
    required this.child, super.key,
    this.padding,
    this.maxWidth = 560.0,
    this.barrierDismissible = true,
  });

  final Widget child;
  final EdgeInsetsGeometry? padding;
  final double maxWidth;
  final bool barrierDismissible;

  static Future<T?> show<T>({
    required BuildContext context,
    required Widget child,
    double maxWidth = 560.0,
    bool barrierDismissible = true,
    EdgeInsetsGeometry? padding,
  }) {
    return showGeneralDialog<T>(
      context: context,
      barrierDismissible: barrierDismissible,
      barrierLabel: 'Modal',
      barrierColor: AppColors.overlayMedium,
      transitionDuration: const Duration(milliseconds: 250),
      pageBuilder: (ctx, anim, _) => AppModal(
        maxWidth: maxWidth,
        padding: padding,
        barrierDismissible: barrierDismissible,
        child: child,
      ),
      transitionBuilder: (ctx, anim, _, child2) => FadeTransition(
        opacity: anim,
        child: ScaleTransition(
          scale: Tween<double>(begin: 0.92, end: 1.0).animate(
            CurvedAnimation(parent: anim, curve: Curves.easeOut),
          ),
          child: child2,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: const RoundedRectangleBorder(borderRadius: AppRadius.xlAll),
      child: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: maxWidth),
        child: Padding(
          padding: padding ?? const EdgeInsets.all(AppSpacing.xl),
          child: child,
        ),
      ),
    );
  }
}
