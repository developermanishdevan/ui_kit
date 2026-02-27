import 'package:flutter/material.dart';
import '../../../../ui_kit.dart';

enum AppProgressSize { xs, sm, md, lg, xl }

class AppProgressSegment {
  final double value; // 0.0 to 1.0
  final Color? color;
  final String? label;

  const AppProgressSegment({required this.value, this.color, this.label});
}

class AppProgress extends AppStatelessWrapper {
  final List<AppProgressSegment> segments;
  final AppProgressSize size;
  final bool isStriped;
  final bool isAnimated;

  AppProgress({
    super.key,
    required double value,
    Color? color,
    String? label,
    this.size = AppProgressSize.md,
    this.isStriped = false,
    this.isAnimated = false,
  }) : segments = [
         AppProgressSegment(value: value, color: color, label: label),
       ];

  const AppProgress.stacked({
    super.key,
    required this.segments,
    this.size = AppProgressSize.md,
    this.isStriped = false,
    this.isAnimated = false,
  });

  @override
  Widget buildWidget(BuildContext context) {
    final colors = context.theme.extension<AppColorsExtension>()!;
    final radii = context.theme.extension<AppRadiusExtension>()!;
    final typography = context.theme.extension<AppTypographyExtension>()!;

    double height;
    TextStyle style;
    switch (size) {
      case AppProgressSize.xs:
        height = 4;
        style = typography.bodyXs;
        break;
      case AppProgressSize.sm:
        height = 8;
        style = typography.bodyXs;
        break;
      case AppProgressSize.md:
        height = 12;
        style = typography.bodySm;
        break;
      case AppProgressSize.lg:
        height = 16;
        style = typography.bodySm;
        break;
      case AppProgressSize.xl:
        height = 20;
        style = typography.bodyBase;
        break;
    }

    return AppSemantics(
      label: 'Progress bar',
      child: Container(
        height: height,
        decoration: BoxDecoration(
          color: colors.borderColor.withValues(
            alpha: 0.3,
          ), // More visible track
          borderRadius: radii.base,
        ),
        clipBehavior: Clip.antiAlias,
        child: Row(
          children: [
            ...segments.map((segment) {
              return Expanded(
                flex: (segment.value * 100).toInt(),
                child: _ProgressBar(
                  value: segment.value,
                  color: segment.color ?? colors.primary,
                  label: segment.label,
                  isStriped: isStriped,
                  isAnimated: isAnimated,
                  height: height,
                  textStyle: style,
                ),
              );
            }),
            if (segments.fold(0.0, (sum, s) => sum + s.value) < 1.0)
              Spacer(
                flex:
                    (100 -
                            (segments.fold(0.0, (sum, s) => sum + s.value) *
                                    100)
                                .toInt())
                        .clamp(0, 100),
              ),
          ],
        ),
      ),
    );
  }
}

class _ProgressBar extends AppStatefulWrapper {
  final double value;
  final Color color;
  final String? label;
  final bool isStriped;
  final bool isAnimated;
  final double height;
  final TextStyle textStyle;

  const _ProgressBar({
    required this.value,
    required this.color,
    this.label,
    required this.isStriped,
    required this.isAnimated,
    required this.height,
    required this.textStyle,
  });

  @override
  State<_ProgressBar> createState() => _ProgressBarState();
}

class _ProgressBarState extends AppStatefulWrapperState<_ProgressBar>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );
    if (widget.isAnimated && widget.isStriped) {
      _controller.repeat();
    }
  }

  @override
  void didUpdateWidget(_ProgressBar oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isAnimated && widget.isStriped) {
      if (!_controller.isAnimating) _controller.repeat();
    } else {
      _controller.stop();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget buildWidget(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Container(
          decoration: BoxDecoration(color: widget.color),
          child: Stack(
            children: [
              if (widget.isStriped)
                Positioned.fill(
                  child: CustomPaint(
                    painter: _StripePainter(
                      animationValue: widget.isAnimated ? _controller.value : 0,
                    ),
                  ),
                ),
              if (widget.label != null)
                Center(
                  child: Text(
                    widget.label!,
                    style: widget.textStyle.copyWith(
                      color: Colors.white,
                      fontWeight: AppTypography.bold,
                      shadows: [
                        Shadow(
                          color: Colors.black.withValues(alpha: 0.2),
                          blurRadius: 2,
                        ),
                      ],
                    ),
                  ),
                ),
            ],
          ),
        );
      },
    );
  }
}

class _StripePainter extends CustomPainter {
  final double animationValue;

  _StripePainter({required this.animationValue});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white
          .withValues(alpha: 0.2) // Slightly more prominent
      ..style = PaintingStyle.fill;

    const double stripeWidth = 20.0;
    final double offset = animationValue * stripeWidth * 2;

    for (double i = -stripeWidth * 2; i < size.width; i += stripeWidth * 2) {
      final path = Path()
        ..moveTo(i + offset, 0)
        ..lineTo(i + offset + stripeWidth, 0)
        ..lineTo(i + offset, size.height)
        ..lineTo(i + offset - stripeWidth, size.height)
        ..close();

      canvas.drawPath(path, paint);
    }
  }

  @override
  bool shouldRepaint(covariant _StripePainter oldDelegate) {
    return oldDelegate.animationValue != animationValue;
  }
}
