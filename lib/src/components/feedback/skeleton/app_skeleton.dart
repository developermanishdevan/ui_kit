import 'package:flutter/material.dart';
import '../../../../ui_kit.dart';

enum AppSkeletonVariant { rectangle, circle, text }

/// A premium Skeleton component for placeholder loading.
class AppSkeleton extends AppStatelessWrapper {
  final double? width;
  final double? height;
  final double? borderRadius;
  final AppSkeletonVariant variant;

  const AppSkeleton({
    super.key,
    this.width,
    this.height,
    this.borderRadius,
    this.variant = AppSkeletonVariant.rectangle,
  });

  const AppSkeleton.text({
    super.key,
    this.width,
    this.height = 12,
    this.borderRadius = 4,
  }) : variant = AppSkeletonVariant.text;

  const AppSkeleton.circle({super.key, required double size})
    : width = size,
      height = size,
      borderRadius = null,
      variant = AppSkeletonVariant.circle;

  @override
  Widget buildWidget(BuildContext context) {
    final colors = context.theme.extension<AppColorsExtension>()!;

    return AppShimmer(
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: colors.bodySecondaryBg,
          shape: variant == AppSkeletonVariant.circle
              ? BoxShape.circle
              : BoxShape.rectangle,
          borderRadius: variant == AppSkeletonVariant.circle
              ? null
              : BorderRadius.circular(borderRadius ?? AppRadius.base),
        ),
      ),
    );
  }
}
