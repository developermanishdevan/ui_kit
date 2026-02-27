import 'package:flutter/material.dart';
import '../../../../ui_kit.dart';

/// A component for selecting multiple items from a list.
class AppMultiSelectList<T> extends AppStatelessWrapper {
  final List<T> items;
  final List<T> selectedItems;
  final String Function(T) itemLabel;
  final ValueChanged<List<T>> onChanged;
  final String? labelText;
  final bool enabled;

  const AppMultiSelectList({
    super.key,
    required this.items,
    required this.selectedItems,
    required this.itemLabel,
    required this.onChanged,
    this.labelText,
    this.enabled = true,
  });

  @override
  Widget buildWidget(BuildContext context) {
    final colors = context.theme.extension<AppColorsExtension>()!;
    final typography = context.theme.extension<AppTypographyExtension>()!;
    final spacing = context.theme.extension<AppSpacingExtension>()!;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        if (labelText != null) ...[
          Text(
            labelText!,
            style: typography.bodyBase.copyWith(
              fontWeight: AppTypography.medium,
              color: colors.textEmphasis,
            ),
          ),
          SizedBox(height: spacing.s2),
        ],
        Container(
          decoration: BoxDecoration(
            color: colors.bodyBg,
            borderRadius: AppRadius.baseRadius,
            border: Border.all(color: colors.borderColor),
          ),
          child: Column(
            children: items.map((item) {
              final isSelected = selectedItems.contains(item);
              final isLast = items.last == item;

              return Column(
                children: [
                  Material(
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: enabled
                          ? () {
                              final newList = List<T>.from(selectedItems);
                              if (isSelected) {
                                newList.remove(item);
                              } else {
                                newList.add(item);
                              }
                              onChanged(newList);
                            }
                          : null,
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: spacing.s3,
                          vertical: spacing.s2,
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: Text(
                                itemLabel(item),
                                style: typography.bodySm.copyWith(
                                  color: colors.bodyColor,
                                ),
                              ),
                            ),
                            AppCheckbox(
                              value: isSelected,
                              onChanged: enabled
                                  ? (val) {
                                      final newList = List<T>.from(
                                        selectedItems,
                                      );
                                      if (val == true) {
                                        newList.add(item);
                                      } else {
                                        newList.remove(item);
                                      }
                                      onChanged(newList);
                                    }
                                  : null,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  if (!isLast)
                    Divider(
                      height: 1,
                      color: colors.borderColorTranslucent,
                      indent: spacing.s3,
                      endIndent: spacing.s3,
                    ),
                ],
              );
            }).toList(),
          ),
        ),
      ],
    );
  }
}
