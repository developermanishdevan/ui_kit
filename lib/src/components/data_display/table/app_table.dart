import 'package:flutter/material.dart';
import '../../../../ui_kit.dart';

/// Defines the color variants for the table or its header.
enum AppTableVariant {
  defaultVariant,
  primary,
  secondary,
  success,
  danger,
  warning,
  info,
  light,
  dark,
}

/// Defines vertical alignment for cell content.
enum AppTableVerticalAlign { top, middle, bottom }

/// A premium, customizable data table component for displaying structured information.
/// Adheres to the UI Kit design system with tokenized spacing, colors, and typography.
class AppTable extends AppStatelessWrapper {
  /// The collection of column headers. Each item can be a [String] or [Widget].
  final List<dynamic> columns;

  /// The collection of data rows. Each row is a list of [Widget]s representing cells.
  final List<List<Widget>> rows;

  /// Optional footer rows.
  final List<List<Widget>>? footers;

  /// The color variant for the header specifically.
  final AppTableVariant? headerVariant;

  /// The overall color variant for the table body.
  final AppTableVariant variant;

  /// Whether to alternate row background colors.
  final bool isStriped;

  /// Whether to alternate column background colors.
  final bool isStripedColumns;

  /// Whether to show a highlight effect on the active row.
  final bool isHoverable;

  /// Whether to show borders around the table and between cells.
  final bool isBordered;

  /// Whether to use the primary brand color for borders.
  final bool borderPrimary;

  /// Whether to hide all borders.
  final bool isBorderless;

  /// Whether to use reduced padding for a compressed layout.
  final bool isSmall;

  /// Whether to use the dark theme palette for the table.
  final bool isDark;

  /// The index of the row currently highlighted/selected.
  final int? activeRowIndex;

  /// Whether to use thicker dividers between sections (header/body/footer).
  final bool useGroupDividers;

  /// Vertical alignment for cell content.
  final AppTableVerticalAlign verticalAlign;

  /// Optional caption text or widget.
  final Widget? caption;

  /// Whether to place the caption at the top of the table.
  final bool captionTop;

  /// Relative widths for columns. If null, columns size to their content.
  final List<double>? columnWidths;

  const AppTable({
    super.key,
    required this.columns,
    required this.rows,
    this.footers,
    this.headerVariant,
    this.variant = AppTableVariant.defaultVariant,
    this.isStriped = false,
    this.isStripedColumns = false,
    this.isHoverable = false,
    this.isBordered = false,
    this.borderPrimary = false,
    this.isBorderless = false,
    this.isSmall = false,
    this.isDark = false,
    this.activeRowIndex,
    this.useGroupDividers = false,
    this.verticalAlign = AppTableVerticalAlign.middle,
    this.caption,
    this.captionTop = false,
    this.columnWidths,
  });

  Color _getVariantBg(AppColorsExtension colors, AppTableVariant v) {
    if (v == AppTableVariant.defaultVariant) return Colors.transparent;

    switch (v) {
      case AppTableVariant.primary:
        return colors.primary.withValues(alpha: 0.1);
      case AppTableVariant.secondary:
        return colors.secondary.withValues(alpha: 0.1);
      case AppTableVariant.success:
        return colors.success.withValues(alpha: 0.1);
      case AppTableVariant.danger:
        return colors.danger.withValues(alpha: 0.1);
      case AppTableVariant.warning:
        return colors.warning.withValues(alpha: 0.1);
      case AppTableVariant.info:
        return colors.info.withValues(alpha: 0.1);
      case AppTableVariant.light:
        return colors.bodyBg;
      case AppTableVariant.dark:
        return colors.dark;
      default:
        return Colors.transparent;
    }
  }

  Color _getVariantText(AppColorsExtension colors, AppTableVariant v) {
    switch (v) {
      case AppTableVariant.primary:
        return colors.primary;
      case AppTableVariant.secondary:
        return colors.secondary;
      case AppTableVariant.success:
        return colors.success;
      case AppTableVariant.danger:
        return colors.danger;
      case AppTableVariant.warning:
        return colors.warning;
      case AppTableVariant.info:
        return colors.info;
      case AppTableVariant.dark:
        return Colors.white;
      default:
        return colors.bodyColor;
    }
  }

  @override
  Widget buildWidget(BuildContext context) {
    final colors = context.theme.extension<AppColorsExtension>()!;
    final typography = context.theme.extension<AppTypographyExtension>()!;
    final spacing = context.theme.extension<AppSpacingExtension>()!;

    final baseTextColor = isDark
        ? Colors.white
        : _getVariantText(colors, variant);
    final borderColor = borderPrimary
        ? colors.primary
        : (isDark ? const Color(0xFF272F37) : colors.borderColor);

    final headerBg = headerVariant != null
        ? _getVariantBg(colors, headerVariant!)
        : (isDark ? const Color(0xFF1D2329) : colors.bodyBg);
    final headerTextColor = headerVariant != null
        ? _getVariantText(colors, headerVariant!)
        : (isDark ? Colors.white : colors.textEmphasis);

    final cellPadding = isSmall
        ? EdgeInsets.symmetric(horizontal: spacing.s2, vertical: spacing.s2)
        : EdgeInsets.symmetric(horizontal: spacing.s4, vertical: spacing.s3);

    final List<TableRow> tableRows = [];

    // 1. Header Row
    tableRows.add(
      TableRow(
        decoration: BoxDecoration(
          color: headerBg,
          border: !isBorderless
              ? Border(
                  bottom: BorderSide(
                    color: borderColor,
                    width: useGroupDividers ? 2.0 : 1.0,
                  ),
                )
              : null,
        ),
        children: columns.asMap().entries.map((entry) {
          final col = entry.value;
          return TableCell(
            verticalAlignment: TableCellVerticalAlignment.middle,
            child: Padding(
              padding: cellPadding,
              child: col is Widget
                  ? col
                  : Text(
                      col.toString().toUpperCase(),
                      style: typography.bodyXs.copyWith(
                        fontWeight: AppTypography.bold,
                        color: headerTextColor,
                        letterSpacing: 0.5,
                      ),
                    ),
            ),
          );
        }).toList(),
      ),
    );

    // 2. Data Rows
    for (int rIndex = 0; rIndex < rows.length; rIndex++) {
      final row = rows[rIndex];
      final isSelected = activeRowIndex == rIndex;
      final isStripe = isStriped && rIndex % 2 != 0;

      Color? rowColor;
      if (isSelected) {
        rowColor = colors.primary.withValues(alpha: 0.05);
      } else if (isStripe) {
        rowColor = isDark
            ? Colors.white.withValues(alpha: 0.02)
            : Colors.black.withValues(alpha: 0.02);
      }

      tableRows.add(
        TableRow(
          decoration: BoxDecoration(
            color: rowColor,
            border: !isBorderless
                ? Border(bottom: BorderSide(color: borderColor))
                : null,
          ),
          children: row.asMap().entries.map((entry) {
            final cIndex = entry.key;
            final cell = entry.value;
            final isStripeCol = isStripedColumns && cIndex % 2 != 0;

            return TableCell(
              verticalAlignment: _getVAlign(verticalAlign),
              child: Container(
                padding: cellPadding,
                decoration: isStripeCol
                    ? BoxDecoration(
                        color: isDark
                            ? Colors.white.withValues(alpha: 0.01)
                            : Colors.black.withValues(alpha: 0.01),
                      )
                    : null,
                child: DefaultTextStyle(
                  style: typography.bodySm.copyWith(color: baseTextColor),
                  child: cell,
                ),
              ),
            );
          }).toList(),
        ),
      );
    }

    // 3. Footer Rows
    if (footers != null) {
      for (int fIndex = 0; fIndex < footers!.length; fIndex++) {
        final fRow = footers![fIndex];
        tableRows.add(
          TableRow(
            decoration: BoxDecoration(
              color: isDark ? const Color(0xFF1D2329) : colors.bodyBg,
              border: !isBorderless
                  ? Border(
                      top: fIndex == 0
                          ? BorderSide(
                              color: borderColor,
                              width: useGroupDividers ? 2.0 : 1.0,
                            )
                          : BorderSide.none,
                      bottom: isBordered
                          ? BorderSide(color: borderColor)
                          : BorderSide.none,
                    )
                  : null,
            ),
            children: fRow.asMap().entries.map((entry) {
              final cell = entry.value;
              return TableCell(
                verticalAlignment: _getVAlign(verticalAlign),
                child: Padding(
                  padding: cellPadding,
                  child: DefaultTextStyle(
                    style: typography.bodySm.copyWith(
                      fontWeight: AppTypography.semiBold,
                      color: baseTextColor,
                    ),
                    child: cell,
                  ),
                ),
              );
            }).toList(),
          ),
        );
      }
    }

    Widget tableWidget = Table(
      defaultColumnWidth: const IntrinsicColumnWidth(),
      columnWidths: columnWidths != null
          ? {
              for (var i = 0; i < columnWidths!.length; i++)
                i: FlexColumnWidth(columnWidths![i]),
            }
          : null,
      border: isBordered ? TableBorder.all(color: borderColor) : null,
      children: tableRows,
    );

    // Caption Logic
    if (caption != null) {
      final captionWidget = Padding(
        padding: EdgeInsets.symmetric(
          vertical: spacing.s2,
          horizontal: spacing.s3,
        ),
        child: DefaultTextStyle(
          style: typography.bodyXs.copyWith(
            color: colors.bodySecondaryColor,
            fontStyle: FontStyle.italic,
          ),
          child: caption!,
        ),
      );
      tableWidget = Column(
        crossAxisAlignment: CrossAxisAlignment
            .start, // Avoid stretch to prevent layout conflicts
        mainAxisSize: MainAxisSize.min,
        children: [
          if (captionTop) captionWidget,
          tableWidget,
          if (!captionTop) captionWidget,
        ],
      );
    }

    return AppSemantics(
      label: 'Data Table',
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: ConstrainedBox(
          constraints: BoxConstraints(
            minWidth:
                MediaQuery.of(context).size.width -
                (spacing.s3 * 2), // Slightly safer minWidth
          ),
          child: tableWidget,
        ),
      ),
    );
  }

  TableCellVerticalAlignment _getVAlign(AppTableVerticalAlign align) {
    switch (align) {
      case AppTableVerticalAlign.top:
        return TableCellVerticalAlignment.top;
      case AppTableVerticalAlign.bottom:
        return TableCellVerticalAlignment.bottom;
      case AppTableVerticalAlign.middle:
        return TableCellVerticalAlignment.middle;
    }
  }
}
