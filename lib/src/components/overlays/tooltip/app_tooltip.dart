import '../../../../ui_kit.dart';
import 'package:flutter/material.dart';

enum AppTooltipVariant {
  primary,
  secondary,
  success,
  danger,
  warning,
  info,
  light,
  dark,
}

enum AppTooltipPlacement { top, bottom, left, right }

class AppTooltip extends AppStatelessWrapper {
  final Widget child;
  final String message;
  final AppTooltipVariant variant;
  final AppTooltipPlacement placement;
  final bool showArrow;

  const AppTooltip({
    super.key,
    required this.child,
    required this.message,
    this.variant = AppTooltipVariant.dark,
    this.placement = AppTooltipPlacement.top,
    this.showArrow = true,
  });

  @override
  Widget buildWidget(BuildContext context) {
    final theme = Theme.of(context).extension<AppColorsExtension>()!;

    Color bgColor;
    Color textColor;

    switch (variant) {
      case AppTooltipVariant.primary:
        bgColor = theme.primary;
        textColor = Colors.white;
        break;
      case AppTooltipVariant.secondary:
        bgColor = theme.secondary;
        textColor = Colors.white;
        break;
      case AppTooltipVariant.success:
        bgColor = theme.success;
        textColor = Colors.white;
        break;
      case AppTooltipVariant.danger:
        bgColor = theme.danger;
        textColor = Colors.white;
        break;
      case AppTooltipVariant.warning:
        bgColor = theme.warning;
        textColor = Colors.black87;
        break;
      case AppTooltipVariant.info:
        bgColor = theme.info;
        textColor = Colors.white;
        break;
      case AppTooltipVariant.light:
        bgColor = theme.light;
        textColor = theme.dark;
        break;
      case AppTooltipVariant.dark:
        bgColor = const Color(
          0xFF000000,
        ); // Absolute black for maximum contrast
        textColor = Colors.white;
        break;
    }

    // Map custom placement to Tooltip's preferredDirection
    // Note: Flutter's Tooltip doesn't support left/right in older versions or easily.
    // However, Tooltip handles vertical better.
    // To get the exact React look with arrows, a custom shape is best.

    return Tooltip(
      message: message,
      textStyle: Theme.of(context)
          .extension<AppTypographyExtension>()!
          .bodySm
          .copyWith(color: textColor, fontSize: 12),
      decoration: ShapeDecoration(
        color: bgColor,
        shadows: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.2),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
        shape: _TooltipShape(
          placement: placement,
          showArrow: showArrow,
          borderRadius: 4.0,
          arrowSize: 6.0,
          borderColor: variant == AppTooltipVariant.dark
              ? theme.borderColor.withValues(alpha: 0.5)
              : Colors.transparent,
        ),
      ),
      preferBelow: placement == AppTooltipPlacement.bottom,
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      triggerMode: TooltipTriggerMode.longPress, // Default for mobile
      waitDuration: const Duration(milliseconds: 500),
      child: child,
    );
  }
}

class _TooltipShape extends ShapeBorder {
  final AppTooltipPlacement placement;
  final bool showArrow;
  final double borderRadius;
  final double arrowSize;
  final Color borderColor;

  const _TooltipShape({
    required this.placement,
    required this.showArrow,
    this.borderRadius = 4.0,
    this.arrowSize = 6.0,
    this.borderColor = Colors.transparent,
  });

  @override
  EdgeInsetsGeometry get dimensions => EdgeInsets.zero;

  @override
  Path getInnerPath(Rect rect, {TextDirection? textDirection}) {
    return Path()..addRect(rect);
  }

  @override
  Path getOuterPath(Rect rect, {TextDirection? textDirection}) {
    final path = Path();
    final r = borderRadius;
    final s = arrowSize;

    // Base rectangle with rounded corners
    path.addRRect(RRect.fromRectAndRadius(rect, Radius.circular(r)));

    if (showArrow) {
      switch (placement) {
        case AppTooltipPlacement.top:
          path.moveTo(rect.center.dx - s, rect.bottom);
          path.lineTo(rect.center.dx, rect.bottom + s);
          path.lineTo(rect.center.dx + s, rect.bottom);
          break;
        case AppTooltipPlacement.bottom:
          path.moveTo(rect.center.dx - s, rect.top);
          path.lineTo(rect.center.dx, rect.top - s);
          path.lineTo(rect.center.dx + s, rect.top);
          break;
        case AppTooltipPlacement.left:
          path.moveTo(rect.right, rect.center.dy - s);
          path.lineTo(rect.right + s, rect.center.dy);
          path.lineTo(rect.right, rect.center.dy + s);
          break;
        case AppTooltipPlacement.right:
          path.moveTo(rect.left, rect.center.dy - s);
          path.lineTo(rect.left - s, rect.center.dy);
          path.lineTo(rect.left, rect.center.dy + s);
          break;
      }
    }

    path.close();
    return path;
  }

  @override
  void paint(Canvas canvas, Rect rect, {TextDirection? textDirection}) {
    if (borderColor != Colors.transparent) {
      final paint = Paint()
        ..color = borderColor
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1.0;
      canvas.drawPath(getOuterPath(rect), paint);
    }
  }

  @override
  ShapeBorder scale(double t) => this;
}
