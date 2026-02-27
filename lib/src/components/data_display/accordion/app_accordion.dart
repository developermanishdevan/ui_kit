import '../../../../ui_kit.dart';
import 'package:flutter/material.dart';

class AppAccordionItem {
  final String title;
  final Widget content;
  final bool isInitiallyExpanded;

  AppAccordionItem({
    required this.title,
    required this.content,
    this.isInitiallyExpanded = false,
  });
}

class AppAccordion extends AppStatefulWrapper {
  final List<AppAccordionItem> items;
  final bool flush;
  final bool alwaysOpen;

  const AppAccordion({
    super.key,
    required this.items,
    this.flush = false,
    this.alwaysOpen = false,
  });

  @override
  AppStatefulWrapperState<AppAccordion> createState() => _AppAccordionState();
}

class _AppAccordionState extends AppStatefulWrapperState<AppAccordion> {
  late List<bool> _expandedStates;

  @override
  void initState() {
    super.initState();
    _expandedStates = widget.items
        .map((item) => item.isInitiallyExpanded)
        .toList();

    // If not always open, ensure only the first initially expanded item is kept expanded
    if (!widget.alwaysOpen) {
      bool foundOpen = false;
      for (int i = 0; i < _expandedStates.length; i++) {
        if (_expandedStates[i]) {
          if (foundOpen) {
            _expandedStates[i] = false;
          } else {
            foundOpen = true;
          }
        }
      }
    }
  }

  void _handleToggle(int index) {
    setState(() {
      if (widget.alwaysOpen) {
        _expandedStates[index] = !_expandedStates[index];
      } else {
        final wasExpanded = _expandedStates[index];
        for (int i = 0; i < _expandedStates.length; i++) {
          _expandedStates[i] = false;
        }
        _expandedStates[index] = !wasExpanded;
      }
    });
  }

  @override
  Widget buildWidget(BuildContext context) {
    final theme = context.theme.extension<AppColorsExtension>()!;
    final radii = context.theme.extension<AppRadiusExtension>()!;

    return Container(
      decoration: widget.flush
          ? null
          : BoxDecoration(
              border: Border.all(color: theme.borderColor),
              borderRadius: radii.base,
            ),
      child: Column(
        children: List.generate(widget.items.length, (index) {
          final isFirst = index == 0;
          final isLast = index == widget.items.length - 1;

          return _AppAccordionItemWidget(
            item: widget.items[index],
            isExpanded: _expandedStates[index],
            flush: widget.flush,
            isFirst: isFirst,
            isLast: isLast,
            onToggle: () => _handleToggle(index),
          );
        }),
      ),
    );
  }
}

class _AppAccordionItemWidget extends AppStatelessWrapper {
  final AppAccordionItem item;
  final bool isExpanded;
  final bool flush;
  final bool isFirst;
  final bool isLast;
  final VoidCallback onToggle;

  const _AppAccordionItemWidget({
    required this.item,
    required this.isExpanded,
    required this.flush,
    required this.isFirst,
    required this.isLast,
    required this.onToggle,
  });

  BorderRadius? _getBorderRadius(BuildContext context) {
    if (flush) return BorderRadius.zero;
    final radii = context.theme.extension<AppRadiusExtension>()!;

    if (isFirst && isLast) {
      return radii.base;
    }
    if (isFirst) {
      return BorderRadius.only(
        topLeft: radii.base.topLeft,
        topRight: radii.base.topRight,
      );
    }
    if (isLast && !isExpanded) {
      return BorderRadius.only(
        bottomLeft: radii.base.bottomLeft,
        bottomRight: radii.base.bottomRight,
      );
    }
    return BorderRadius.zero;
  }

  @override
  Widget buildWidget(BuildContext context) {
    final theme = context.theme.extension<AppColorsExtension>()!;
    final typography = context.theme.extension<AppTypographyExtension>()!;
    final spacing = context.theme.extension<AppSpacingExtension>()!;

    final headerDecoration = BoxDecoration(
      color: isExpanded
          ? theme.primary.withValues(alpha: 0.05)
          : Colors.transparent,
      borderRadius: _getBorderRadius(context),
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        if (!isFirst)
          Divider(height: 1, thickness: 1, color: theme.borderColor),

        AppSemantics(
          label: item.title,
          button: true,
          hint: isExpanded ? 'Collapse' : 'Expand',
          child: AppInteractiveWidget(
            onTap: onToggle,
            semanticLabel: item.title,
            showHoverEffect: true,
            child: Container(
              decoration: headerDecoration,
              padding: EdgeInsets.symmetric(
                horizontal: spacing.s3,
                vertical: spacing.s3,
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      item.title,
                      style: typography.bodyBase.copyWith(
                        fontWeight: AppTypography.medium,
                        color: isExpanded ? theme.primary : theme.textEmphasis,
                      ),
                    ),
                  ),
                  AppRotateAnimation(
                    turns: isExpanded ? 0.5 : 0.0,
                    duration: AppDurations.quick,
                    child: Icon(
                      Icons.keyboard_arrow_down,
                      color: isExpanded ? theme.primary : theme.bodyColor,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        AppSizeAnimation(
          duration: AppDurations.quick,
          alignment: Alignment.topCenter,
          child: !isExpanded
              ? const SizedBox.shrink()
              : Container(
                  padding: EdgeInsets.only(
                    left: spacing.s3,
                    right: spacing.s3,
                    bottom: spacing.s3,
                    top: spacing.s2,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.transparent, // Background of expanded area
                    borderRadius: flush || !isLast
                        ? BorderRadius.zero
                        : BorderRadius.only(
                            bottomLeft: context.theme
                                .extension<AppRadiusExtension>()!
                                .base
                                .bottomLeft,
                            bottomRight: context.theme
                                .extension<AppRadiusExtension>()!
                                .base
                                .bottomRight,
                          ),
                  ),
                  child: item.content,
                ),
        ),
      ],
    );
  }
}
