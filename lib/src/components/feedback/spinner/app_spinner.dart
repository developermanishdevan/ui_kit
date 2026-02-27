import '../../../../ui_kit.dart';
import 'package:flutter/material.dart';

enum AppSpinnerType { border, grow }

enum AppSpinnerSize { sm, md }

class AppSpinner extends AppStatelessWrapper {
  final AppSpinnerType type;
  final AppSpinnerSize size;
  final Color? color;
  final double? thickness;

  const AppSpinner({
    super.key,
    this.type = AppSpinnerType.border,
    this.size = AppSpinnerSize.md,
    this.color,
    this.thickness,
  });

  @override
  Widget buildWidget(BuildContext context) {
    final colors = context.theme.extension<AppColorsExtension>()!;
    final spinnerColor = color ?? colors.primary;

    double dimension;
    switch (size) {
      case AppSpinnerSize.sm:
        dimension = 16.0;
        break;
      case AppSpinnerSize.md:
        dimension = 32.0;
        break;
    }

    return AppSemantics(
      label: 'Loading spinner',
      child: AppAnimationControllerWrapper(
        duration: const Duration(seconds: 1),
        repeat: true,
        builder: (context, controller) {
          return AnimatedBuilder(
            animation: controller,
            builder: (context, child) {
              if (type == AppSpinnerType.grow) {
                return SizedBox(
                  width: dimension,
                  height: dimension,
                  child: Opacity(
                    opacity: (1.0 - controller.value).clamp(0.0, 1.0),
                    child: Transform.scale(
                      scale: controller.value,
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                          color: spinnerColor,
                          shape: BoxShape.circle,
                        ),
                      ),
                    ),
                  ),
                );
              } else {
                // Border spinner
                return SizedBox(
                  width: dimension,
                  height: dimension,
                  child: CustomPaint(
                    painter: _BorderSpinnerPainter(
                      rotation: controller.value,
                      color: spinnerColor,
                      thickness:
                          thickness ?? (size == AppSpinnerSize.sm ? 2.0 : 3.0),
                    ),
                  ),
                );
              }
            },
          );
        },
      ),
    );
  }
}

class _BorderSpinnerPainter extends CustomPainter {
  final double rotation;
  final Color color;
  final double thickness;

  _BorderSpinnerPainter({
    required this.rotation,
    required this.color,
    required this.thickness,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
          .withAlpha(51) // Background track (approx 0.2 opacity)
      ..style = PaintingStyle.stroke
      ..strokeWidth = thickness;

    final activePaint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = thickness
      ..strokeCap = StrokeCap.round;

    final center = Offset(size.width / 2, size.height / 2);
    final radius = (size.width - thickness) / 2;

    // Draw track
    canvas.drawCircle(center, radius, paint);

    // Draw active arc
    final double startAngle = (rotation * 2 * 3.14159) - 1.5708; // -PI/2
    const double sweepAngle = 3.14159 * 0.75; // 3/4 circle
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      startAngle,
      sweepAngle,
      false,
      activePaint,
    );
  }

  @override
  bool shouldRepaint(covariant _BorderSpinnerPainter oldDelegate) {
    return oldDelegate.rotation != rotation || oldDelegate.color != color;
  }
}
