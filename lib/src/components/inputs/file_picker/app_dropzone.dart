import 'package:flutter/material.dart';
import '../../../../ui_kit.dart';

class AppDropzone extends AppStatelessWrapper {
  final VoidCallback onTap;
  final String title;
  final String? subtitle;
  final Widget? icon;

  const AppDropzone({
    super.key,
    required this.onTap,
    this.title = 'Drop files here or click to upload.',
    this.subtitle,
    this.icon,
  });

  @override
  Widget buildWidget(BuildContext context) {
    final colors = Theme.of(context).extension<AppColorsExtension>()!;
    final typography = Theme.of(context).extension<AppTypographyExtension>()!;
    final spacing = Theme.of(context).extension<AppSpacingExtension>()!;
    final radii = Theme.of(context).extension<AppRadiusExtension>()!;

    return AppSemantics(
      label: title,
      button: true,
      child: AppInteractiveWidget(
        onTap: onTap,
        showHoverEffect: true,
        child: CustomPaint(
          painter: _DropzoneBorderPainter(color: colors.borderColor),
          child: Container(
            width: double.infinity,
            padding: EdgeInsets.all(spacing.s4),
            decoration: BoxDecoration(
              color: colors.bodySecondaryBg,
              borderRadius: radii.base,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (icon != null) ...[
                  IconTheme(
                    data: IconThemeData(
                      color: colors.bodySecondaryColor,
                      size: 40,
                    ),
                    child: icon!,
                  ),
                  SizedBox(height: spacing.s3),
                ],
                Text(
                  title,
                  textAlign: TextAlign.center,
                  style: typography.h4.copyWith(
                    fontWeight: AppTypography.bold,
                    color: colors.textEmphasis,
                  ),
                ),
                if (subtitle != null) ...[
                  SizedBox(height: spacing.s1),
                  Text(
                    subtitle!,
                    textAlign: TextAlign.center,
                    style: typography.bodySm.copyWith(
                      color: colors.bodySecondaryColor,
                    ),
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _DropzoneBorderPainter extends CustomPainter {
  final Color color;

  _DropzoneBorderPainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;

    const double dashWidth = 8.0;
    const double dashSpace = 4.0;
    final Path path = Path()
      ..addRRect(
        RRect.fromRectAndRadius(
          Rect.fromLTWH(0, 0, size.width, size.height),
          const Radius.circular(6.0), // match base radius
        ),
      );

    var metrics = path.computeMetrics();
    Path dashedPath = Path();

    for (var metric in metrics) {
      double distance = 0;
      while (distance < metric.length) {
        dashedPath.addPath(
          metric.extractPath(distance, distance + dashWidth),
          Offset.zero,
        );
        distance += dashWidth;
        distance += dashSpace;
      }
    }

    canvas.drawPath(dashedPath, paint);
  }

  @override
  bool shouldRepaint(covariant _DropzoneBorderPainter oldDelegate) {
    return oldDelegate.color != color;
  }
}
