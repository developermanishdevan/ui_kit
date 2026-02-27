import 'package:flutter/material.dart';
import 'package:ui_kit/ui_kit.dart';

class AppInfoState extends AppStatelessWrapper {
  final String title;
  final String message;
  final IconData? icon;
  final Widget? customIcon;
  final double iconSize;
  final String? actionLabel;
  final VoidCallback? onAction;
  final Widget? actionIcon;
  final AppButtonColor actionButtonColor;
  final Color? color;

  const AppInfoState({
    super.key,
    required this.title,
    required this.message,
    this.icon = Icons.hourglass_empty_rounded,
    this.customIcon,
    this.iconSize = 40.0,
    this.actionLabel,
    this.onAction,
    this.actionIcon,
    this.actionButtonColor = AppButtonColor.primary,
    this.color,
  });

  @override
  Widget buildWidget(BuildContext context) {
    final colors = context.theme.extension<AppColorsExtension>()!;
    final typography = context.theme.extension<AppTypographyExtension>()!;
    final spacing = context.theme.extension<AppSpacingExtension>()!;

    final stateColor = color ?? colors.primary;

    return AppSemantics(
      label: 'Info state: $title',
      child: Padding(
        padding: EdgeInsets.all(spacing.s4),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              customIcon ??
                  Container(
                    padding: EdgeInsets.all(spacing.s4),
                    decoration: BoxDecoration(
                      color: stateColor.withValues(alpha: 0.05),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      icon ?? Icons.hourglass_empty_rounded,
                      size: iconSize,
                      color: stateColor,
                    ),
                  ),
              SizedBox(height: spacing.s4),
              Text(
                title,
                textAlign: TextAlign.center,
                style: typography.h5.copyWith(
                  color: colors.textEmphasis,
                  fontWeight: AppTypography.bold,
                ),
              ),
              SizedBox(height: spacing.s2),
              Text(
                message,
                textAlign: TextAlign.center,
                style: typography.bodyBase.copyWith(
                  color: colors.bodySecondaryColor,
                ),
              ),
              if (actionLabel != null && onAction != null) ...[
                SizedBox(height: spacing.s3),
                AppButton(
                  label: actionLabel!,
                  onPressed: onAction,
                  variant: AppButtonVariant.soft,
                  icon:
                      actionIcon ??
                      (actionLabel == 'Refresh'
                          ? const Icon(Icons.refresh_rounded)
                          : const Icon(Icons.arrow_back_rounded)),
                  color: actionButtonColor,
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
