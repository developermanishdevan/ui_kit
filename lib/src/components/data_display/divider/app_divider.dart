import '../../../../ui_kit.dart';
import 'package:flutter/material.dart';

enum AppDividerVariant { solid, dashed, dotted, double }

class AppDivider extends AppStatelessWrapper {
  final double? height;
  final double thickness;
  final double? indent;
  final double? endIndent;
  final Color? color;
  final AppDividerVariant variant;

  const AppDivider({
    super.key,
    this.height,
    this.thickness = 1.0,
    this.indent,
    this.endIndent,
    this.color,
    this.variant = AppDividerVariant.solid,
  });

  @override
  Widget buildWidget(BuildContext context) {
    final themeExt = context.theme.extension<AppColorsExtension>()!;
    final spacing = context.theme.extension<AppSpacingExtension>()!;
    final effectiveColor = color ?? themeExt.borderColor;

    return AppSemantics(
      label: 'Divider',
      child: SizedBox(
        height: height ?? spacing.s3,
        child: Center(
          child: Container(
            margin: EdgeInsets.only(
              left: indent ?? 0.0,
              right: endIndent ?? 0.0,
            ),
            child: _buildDividerLine(effectiveColor, spacing),
          ),
        ),
      ),
    );
  }

  Widget _buildDividerLine(Color effectiveColor, AppSpacingExtension spacing) {
    switch (variant) {
      case AppDividerVariant.solid:
        return Container(height: thickness, color: effectiveColor);
      case AppDividerVariant.double:
        return Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(height: thickness, color: effectiveColor),
            SizedBox(
              height: thickness,
            ), // gap between double line based on thickness
            Container(height: thickness, color: effectiveColor),
          ],
        );
      case AppDividerVariant.dashed:
        return CustomPaint(
          size: Size(double.infinity, thickness),
          painter: _DashedLinePainter(
            color: effectiveColor,
            thickness: thickness,
            dashWidth: thickness * 5,
            dashSpace: thickness * 3,
            isDotted: false,
          ),
        );
      case AppDividerVariant.dotted:
        return CustomPaint(
          size: Size(double.infinity, thickness),
          painter: _DashedLinePainter(
            color: effectiveColor,
            thickness: thickness,
            dashWidth: thickness * 2,
            dashSpace: thickness * 2,
            isDotted: true,
          ),
        );
    }
  }
}

class _DashedLinePainter extends CustomPainter {
  final Color color;
  final double thickness;
  final double dashWidth;
  final double dashSpace;
  final bool isDotted;

  _DashedLinePainter({
    required this.color,
    required this.thickness,
    required this.dashWidth,
    required this.dashSpace,
    required this.isDotted,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = thickness
      ..strokeCap = isDotted ? StrokeCap.round : StrokeCap.square;

    double startX = 0;
    while (startX < size.width) {
      final endX = startX + dashWidth;
      if (isDotted) {
        canvas.drawCircle(
          Offset(startX + (dashWidth / 2), size.height / 2),
          thickness / 2,
          paint,
        );
      } else {
        canvas.drawLine(
          Offset(startX, size.height / 2),
          Offset(endX, size.height / 2),
          paint,
        );
      }
      startX += dashWidth + dashSpace;
    }
  }

  @override
  bool shouldRepaint(covariant _DashedLinePainter oldDelegate) {
    return oldDelegate.color != color ||
        oldDelegate.thickness != thickness ||
        oldDelegate.dashWidth != dashWidth ||
        oldDelegate.dashSpace != dashSpace ||
        oldDelegate.isDotted != isDotted;
  }
}
