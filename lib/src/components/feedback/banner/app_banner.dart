import 'package:flutter/material.dart';
import '../../../../ui_kit.dart';

/// A premium Banner component for persistent feedback.
class AppBanner extends AppStatelessWrapper {
  final String message;
  final String? leadingLabel;
  final Widget? leading;
  final List<Widget>? actions;
  final AppButtonColor color;

  const AppBanner({
    super.key,
    required this.message,
    this.leadingLabel,
    this.leading,
    this.actions,
    this.color = AppButtonColor.primary,
  });

  @override
  Widget buildWidget(BuildContext context) {
    final colors = context.theme.extension<AppColorsExtension>()!;
    final typography = context.theme.extension<AppTypographyExtension>()!;
    final spacing = context.theme.extension<AppSpacingExtension>()!;

    Color bgColor;
    Color textColor;

    switch (color) {
      case AppButtonColor.primary:
        bgColor = colors.primary;
        textColor = Colors.white;
        break;
      case AppButtonColor.secondary:
        bgColor = colors.secondary;
        textColor = Colors.white;
        break;
      case AppButtonColor.success:
        bgColor = colors.success;
        textColor = Colors.white;
        break;
      case AppButtonColor.danger:
        bgColor = colors.danger;
        textColor = Colors.white;
        break;
      case AppButtonColor.warning:
        bgColor = colors.warning;
        textColor = Colors.black87;
        break;
      case AppButtonColor.info:
        bgColor = colors.info;
        textColor = Colors.white;
        break;
      case AppButtonColor.light:
        bgColor = colors.light;
        textColor = colors.dark;
        break;
      case AppButtonColor.dark:
        bgColor = colors.dark;
        textColor = Colors.white;
        break;
    }

    return AppSemantics(
      label: 'Banner: $message',
      child: Material(
        color: bgColor,
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: spacing.s4,
            vertical: spacing.s2,
          ),
          child: Row(
            children: [
              if (leading != null) ...[
                leading!,
                SizedBox(width: spacing.s3),
              ] else if (leadingLabel != null) ...[
                CircleAvatar(
                  backgroundColor: textColor.withValues(alpha: 0.2),
                  radius: 16,
                  child: Text(
                    leadingLabel!,
                    style: typography.bodySm.copyWith(
                      color: textColor,
                      fontWeight: AppTypography.bold,
                    ),
                  ),
                ),
                SizedBox(width: spacing.s3),
              ],
              Expanded(
                child: Text(
                  message,
                  style: typography.bodyBase.copyWith(color: textColor),
                ),
              ),
              if (actions != null) ...[
                SizedBox(width: spacing.s4),
                ...actions!,
              ],
            ],
          ),
        ),
      ),
    );
  }
}
