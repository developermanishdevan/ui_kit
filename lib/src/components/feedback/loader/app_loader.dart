import 'package:flutter/material.dart';
import '../../../../ui_kit.dart';

/// A wrapper that shows a loader when isLoading is true.
class AppLoader extends AppStatelessWrapper {
  final Widget child;
  final bool isLoading;
  final String? loadingText;
  final AppSpinnerType spinnerType;
  final Color? barrierColor;

  const AppLoader({
    super.key,
    required this.child,
    required this.isLoading,
    this.loadingText,
    this.spinnerType = AppSpinnerType.border,
    this.barrierColor,
  });

  @override
  Widget buildWidget(BuildContext context) {
    final colors = context.theme.extension<AppColorsExtension>()!;
    final typography = context.theme.extension<AppTypographyExtension>()!;
    final spacing = context.theme.extension<AppSpacingExtension>()!;
    final radii = context.theme.extension<AppRadiusExtension>()!;

    return Stack(
      children: [
        child,
        if (isLoading)
          Positioned.fill(
            child: AppSemantics(
              label: loadingText ?? 'Loading indicator',
              child: AppFadeAnimation(
                opacity: 1.0,
                child: Container(
                  color: barrierColor ?? colors.bodyBg.withValues(alpha: 0.7),
                  child: Center(
                    child: Container(
                      padding: EdgeInsets.all(spacing.s4),
                      decoration: BoxDecoration(
                        color: colors.bodyBg,
                        borderRadius: radii.base,
                        boxShadow: [AppShadows.lg],
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          AppSpinner(type: spinnerType),
                          if (loadingText != null) ...[
                            SizedBox(height: spacing.s3),
                            Text(
                              loadingText!,
                              style: typography.bodySm.copyWith(
                                color: colors.bodySecondaryColor,
                                fontWeight: AppTypography.semiBold,
                              ),
                            ),
                          ],
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
      ],
    );
  }
}
