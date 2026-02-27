import 'package:flutter/material.dart';
import '../../../../ui_kit.dart';

/// A list tile component that can be selected.
class AppSelectableTile extends AppStatelessWrapper {
  final Widget title;
  final Widget? subtitle;
  final Widget? leading;
  final bool selected;
  final VoidCallback? onTap;
  final bool enabled;

  const AppSelectableTile({
    super.key,
    required this.title,
    this.subtitle,
    this.leading,
    required this.selected,
    this.onTap,
    this.enabled = true,
  });

  @override
  Widget buildWidget(BuildContext context) {
    final colors = context.theme.extension<AppColorsExtension>()!;
    final spacing = context.theme.extension<AppSpacingExtension>()!;
    final typography = context.theme.extension<AppTypographyExtension>()!;

    return Material(
      color: selected
          ? colors.primary.withValues(alpha: 0.05)
          : Colors.transparent,
      child: InkWell(
        onTap: enabled ? onTap : null,
        child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: spacing.s4,
            vertical: spacing.s3,
          ),
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(color: colors.borderColorTranslucent),
              left: BorderSide(
                color: selected ? colors.primary : Colors.transparent,
                width: 4,
              ),
            ),
          ),
          child: Row(
            children: [
              if (leading != null) ...[
                Theme(
                  data: Theme.of(context).copyWith(
                    iconTheme: IconThemeData(
                      color: selected
                          ? colors.primary
                          : colors.bodySecondaryColor,
                    ),
                  ),
                  child: leading!,
                ),
                SizedBox(width: spacing.s4),
              ],
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    DefaultTextStyle(
                      style: typography.bodyBase.copyWith(
                        fontWeight: selected
                            ? AppTypography.semiBold
                            : AppTypography.medium,
                        color: selected ? colors.primary : colors.textEmphasis,
                      ),
                      child: title,
                    ),
                    if (subtitle != null) ...[
                      SizedBox(height: 2),
                      DefaultTextStyle(
                        style: typography.bodySm.copyWith(
                          color: colors.bodySecondaryColor,
                        ),
                        child: subtitle!,
                      ),
                    ],
                  ],
                ),
              ),
              if (selected)
                Icon(Icons.check_circle, color: colors.primary, size: 20),
            ],
          ),
        ),
      ),
    );
  }
}
