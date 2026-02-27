import 'package:flutter/material.dart';
import '../../../../ui_kit.dart';

class AppExpandableTile extends AppStatefulWrapper {
  final Widget? leading;
  final Widget title;
  final Widget? subtitle;
  final Widget? trailing;
  final Widget child;
  final bool initiallyExpanded;
  final ValueChanged<bool>? onExpansionChanged;
  final EdgeInsetsGeometry? contentPadding;
  final bool showBorder;
  final Color? backgroundColor;

  const AppExpandableTile({
    super.key,
    this.leading,
    required this.title,
    this.subtitle,
    this.trailing,
    required this.child,
    this.initiallyExpanded = false,
    this.onExpansionChanged,
    this.contentPadding,
    this.showBorder = true,
    this.backgroundColor,
  });

  @override
  AppStatefulWrapperState<AppExpandableTile> createState() =>
      _AppExpandableTileState();
}

class _AppExpandableTileState
    extends AppStatefulWrapperState<AppExpandableTile> {
  late bool _isExpanded;

  @override
  void initState() {
    super.initState();
    _isExpanded = widget.initiallyExpanded;
  }

  void _handleTap() {
    setState(() {
      _isExpanded = !_isExpanded;
    });
    widget.onExpansionChanged?.call(_isExpanded);
  }

  @override
  Widget buildWidget(BuildContext context) {
    final colors = context.theme.extension<AppColorsExtension>()!;
    final spacing = context.theme.extension<AppSpacingExtension>()!;
    final radii = context.theme.extension<AppRadiusExtension>()!;

    return AppSemantics(
      label: _isExpanded ? 'Collapse tile' : 'Expand tile',
      child: Container(
        decoration: BoxDecoration(
          color: widget.backgroundColor ?? colors.bodyBg,
          borderRadius: radii.base,
          border: widget.showBorder
              ? Border.all(color: colors.borderColor)
              : null,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            AppInteractiveWidget(
              onTap: _handleTap,
              semanticLabel: 'Toggle expand',
              child: Padding(
                padding: widget.contentPadding ?? EdgeInsets.all(spacing.s3),
                child: Row(
                  children: [
                    if (widget.leading != null) ...[
                      widget.leading!,
                      SizedBox(width: spacing.s3),
                    ],
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          DefaultTextStyle(
                            style: AppTypography.bodyBase.copyWith(
                              color: colors.textEmphasis,
                              fontWeight: AppTypography.semiBold,
                            ),
                            child: widget.title,
                          ),
                          if (widget.subtitle != null) ...[
                            SizedBox(height: spacing.s1),
                            DefaultTextStyle(
                              style: AppTypography.bodySm.copyWith(
                                color: colors.bodySecondaryColor,
                              ),
                              child: widget.subtitle!,
                            ),
                          ],
                        ],
                      ),
                    ),
                    SizedBox(width: spacing.s3),
                    AppRotateAnimation(
                      turns: _isExpanded ? 0.5 : 0.0,
                      duration: AppDurations.normal,
                      child:
                          widget.trailing ??
                          Icon(
                            Icons.expand_more,
                            color: colors.bodySecondaryColor,
                          ),
                    ),
                  ],
                ),
              ),
            ),
            AppCollapse(
              show: _isExpanded,
              duration: AppDurations.normal,
              child: Padding(
                padding:
                    widget.contentPadding ??
                    EdgeInsets.only(
                      left: spacing.s3,
                      right: spacing.s3,
                      bottom: spacing.s3,
                    ),
                child: widget.child,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
