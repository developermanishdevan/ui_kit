import '../../../../ui_kit.dart';
import 'package:flutter/material.dart';

enum AppAlertVariant {
  primary,
  secondary,
  success,
  danger,
  warning,
  info,
  light,
  dark,
}

class AppAlert extends AppStatefulWrapper {
  final AppAlertVariant variant;
  final String? heading;
  final String message;
  final Widget? icon;
  final bool dismissible;
  final VoidCallback? onDismiss;

  const AppAlert({
    super.key,
    this.variant = AppAlertVariant.primary,
    this.heading,
    required this.message,
    this.icon,
    this.dismissible = false,
    this.onDismiss,
  });

  @override
  State<AppAlert> createState() => _AppAlertState();
}

class _AppAlertState extends AppStatefulWrapperState<AppAlert> {
  bool _isVisible = true;

  Color _getBackgroundColor(AppColorsExtension theme) {
    switch (widget.variant) {
      case AppAlertVariant.primary:
        return theme.primary.withValues(alpha: 0.1);
      case AppAlertVariant.secondary:
        return theme.secondary.withValues(alpha: 0.1);
      case AppAlertVariant.success:
        return theme.success.withValues(alpha: 0.1);
      case AppAlertVariant.danger:
        return theme.danger.withValues(alpha: 0.1);
      case AppAlertVariant.warning:
        return theme.warning.withValues(alpha: 0.1);
      case AppAlertVariant.info:
        return theme.info.withValues(alpha: 0.1);
      case AppAlertVariant.light:
        return theme.bodyBg;
      case AppAlertVariant.dark:
        return theme.textEmphasis.withValues(alpha: 0.1);
    }
  }

  Color _getTextColor(AppColorsExtension theme) {
    switch (widget.variant) {
      case AppAlertVariant.primary:
        return theme.primary;
      case AppAlertVariant.secondary:
        return theme.secondary;
      case AppAlertVariant.success:
        return theme.success;
      case AppAlertVariant.danger:
        return theme.danger;
      case AppAlertVariant.warning:
        return theme.warning;
      case AppAlertVariant.info:
        return theme.info;
      case AppAlertVariant.light:
        return theme.bodyColor;
      case AppAlertVariant.dark:
        return theme.textEmphasis;
    }
  }

  Color _getBorderColor(AppColorsExtension theme) {
    switch (widget.variant) {
      case AppAlertVariant.primary:
        return theme.primary.withValues(alpha: 0.2);
      case AppAlertVariant.secondary:
        return theme.secondary.withValues(alpha: 0.2);
      case AppAlertVariant.success:
        return theme.success.withValues(alpha: 0.2);
      case AppAlertVariant.danger:
        return theme.danger.withValues(alpha: 0.2);
      case AppAlertVariant.warning:
        return theme.warning.withValues(alpha: 0.2);
      case AppAlertVariant.info:
        return theme.info.withValues(alpha: 0.2);
      case AppAlertVariant.light:
        return theme.borderColor;
      case AppAlertVariant.dark:
        return theme.textEmphasis.withValues(alpha: 0.2);
    }
  }

  @override
  Widget buildWidget(BuildContext context) {
    if (!_isVisible) return const SizedBox.shrink();

    final colors = context.theme.extension<AppColorsExtension>()!;
    final spacing = context.theme.extension<AppSpacingExtension>()!;
    final typography = context.theme.extension<AppTypographyExtension>()!;
    final radii = context.theme.extension<AppRadiusExtension>()!;

    final bgColor = _getBackgroundColor(colors);
    final textColor = _getTextColor(colors);
    final borderColor = _getBorderColor(colors);

    return AppSemantics(
      label: '${widget.variant.name} alert',
      hint: widget.dismissible ? 'Double tap to dismiss' : null,
      child: AppFadeAnimation(
        opacity: _isVisible ? 1.0 : 0.0,
        child: Container(
          margin: EdgeInsets.only(bottom: spacing.s3),
          padding: EdgeInsets.symmetric(horizontal: spacing.s4, vertical: 14),
          decoration: BoxDecoration(
            color: bgColor,
            border: Border.all(color: borderColor),
            borderRadius: radii.base,
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (widget.icon != null) ...[
                widget.icon!,
                SizedBox(width: spacing.s1),
              ],
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (widget.heading != null) ...[
                      Text(
                        widget.heading!,
                        style: typography.h6.copyWith(
                          color: textColor,
                          fontWeight: AppTypography.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                    ],
                    Text(
                      widget.message,
                      style: typography.bodyBase.copyWith(color: textColor),
                    ),
                  ],
                ),
              ),
              if (widget.dismissible) ...[
                SizedBox(width: spacing.s2),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      _isVisible = false;
                    });
                    widget.onDismiss?.call();
                  },
                  child: Icon(
                    Icons.close,
                    size: 18,
                    color: textColor.withValues(alpha: 0.6),
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
