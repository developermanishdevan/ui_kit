import 'package:flutter/material.dart';
import '../../../../ui_kit.dart';

/// A component for selecting multiple tags.
class AppTagSelector extends AppStatefulWrapper {
  final List<String> availableTags;
  final List<String> selectedTags;
  final ValueChanged<List<String>> onChanged;
  final String? labelText;
  final String? hintText;

  const AppTagSelector({
    super.key,
    required this.availableTags,
    required this.selectedTags,
    required this.onChanged,
    this.labelText,
    this.hintText,
  });

  @override
  State<AppTagSelector> createState() => _AppTagSelectorState();
}

class _AppTagSelectorState extends AppStatefulWrapperState<AppTagSelector> {
  final TextEditingController _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget buildWidget(BuildContext context) {
    final colors = context.theme.extension<AppColorsExtension>()!;
    final spacing = context.theme.extension<AppSpacingExtension>()!;
    final typography = context.theme.extension<AppTypographyExtension>()!;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        if (widget.labelText != null) ...[
          Text(
            widget.labelText!,
            style: typography.bodyBase.copyWith(
              fontWeight: AppTypography.medium,
              color: colors.textEmphasis,
            ),
          ),
          SizedBox(height: spacing.s2),
        ],
        Container(
          padding: EdgeInsets.all(spacing.s2),
          decoration: BoxDecoration(
            color: colors.bodyBg,
            borderRadius: AppRadius.baseRadius,
            border: Border.all(color: colors.borderColor),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              if (widget.selectedTags.isNotEmpty) ...[
                Wrap(
                  spacing: spacing.s2,
                  runSpacing: spacing.s2,
                  children: widget.selectedTags.map((tag) {
                    return AppInputChip(
                      label: tag,
                      onDeleted: () {
                        final newList = List<String>.from(widget.selectedTags);
                        newList.remove(tag);
                        widget.onChanged(newList);
                      },
                    );
                  }).toList(),
                ),
                SizedBox(height: spacing.s2),
              ],
              TextField(
                controller: _controller,
                onSubmitted: (value) {
                  if (value.isNotEmpty &&
                      !widget.selectedTags.contains(value)) {
                    final newList = List<String>.from(widget.selectedTags);
                    newList.add(value);
                    widget.onChanged(newList);
                    _controller.clear();
                  }
                },
                decoration: InputDecoration(
                  hintText: widget.hintText ?? 'Type and press enter...',
                  border: InputBorder.none,
                  isDense: true,
                  contentPadding: EdgeInsets.zero,
                ),
                style: typography.bodySm,
              ),
            ],
          ),
        ),
        if (widget.availableTags.isNotEmpty) ...[
          SizedBox(height: spacing.s2),
          Wrap(
            spacing: spacing.s1,
            children: widget.availableTags
                .where((tag) => !widget.selectedTags.contains(tag))
                .take(5)
                .map((tag) {
                  return TextButton(
                    onPressed: () {
                      final newList = List<String>.from(widget.selectedTags);
                      newList.add(tag);
                      widget.onChanged(newList);
                    },
                    style: TextButton.styleFrom(
                      padding: EdgeInsets.symmetric(horizontal: spacing.s2),
                      minimumSize: const Size(0, 30),
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    ),
                    child: Text(
                      '+ $tag',
                      style: typography.bodyXs.copyWith(color: colors.primary),
                    ),
                  );
                })
                .toList(),
          ),
        ],
      ],
    );
  }
}
