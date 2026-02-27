import 'package:flutter/material.dart';
import '../../../../ui_kit.dart';

/// A premium Shimmer effect for loading states.
class AppShimmer extends AppStatelessWrapper {
  final Widget child;
  final bool enabled;
  final Color? baseColor;
  final Color? highlightColor;
  final Duration duration;

  const AppShimmer({
    super.key,
    required this.child,
    this.enabled = true,
    this.baseColor,
    this.highlightColor,
    this.duration = const Duration(milliseconds: 1500),
  });

  @override
  Widget buildWidget(BuildContext context) {
    if (!enabled) return child;

    return AppAnimationControllerWrapper(
      duration: duration,
      repeat: true,
      builder: (context, controller) {
        final colors = context.theme.extension<AppColorsExtension>()!;
        final base = baseColor ?? colors.bodySecondaryBg;
        final highlight = highlightColor ?? colors.bodyBg;

        return AnimatedBuilder(
          animation: controller,
          builder: (context, child) {
            return ShaderMask(
              blendMode: BlendMode.srcATop,
              shaderCallback: (bounds) {
                return LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [base, highlight, base],
                  stops: const [0.1, 0.5, 0.9],
                  transform: _SlideGradientTransform(offset: controller.value),
                ).createShader(bounds);
              },
              child: child,
            );
          },
          child: child,
        );
      },
    );
  }
}

class _SlideGradientTransform extends GradientTransform {
  final double offset;

  const _SlideGradientTransform({required this.offset});

  @override
  Matrix4? transform(Rect bounds, {TextDirection? textDirection}) {
    return Matrix4.translationValues(bounds.width * (offset * 3 - 1.5), 0, 0);
  }
}
