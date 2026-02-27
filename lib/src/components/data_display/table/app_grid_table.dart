import 'package:flutter/material.dart';
import '../../../../ui_kit.dart';

/// A sophisticated data table wrapper with built-in search, sorting, and pagination.
/// Leverages [AppTable] for layout and design consistency.
class AppGridTable extends AppStatefulWrapper {
  /// The list of column identifiers.
  final List<String> columns;

  /// The raw data rows.
  final List<List<dynamic>> rows;

  /// Number of entries per page. If null, pagination is disabled.
  final int? pagination;

  /// Whether to show the search input field.
  final bool search;

  /// Whether to enable column-based sorting.
  final bool sort;

  /// Whether to show a loading overlay.
  final bool loading;

  /// Whether the table header remains fixed while scrolling vertically.
  final bool fixedHeader;

  /// Explicit height for vertical scrolling.
  final double? height;

  /// Indices of columns that should not be rendered.
  final List<int>? hiddenColumns;

  // Passthrough properties for underlying AppTable styling
  final AppTableVariant? headerVariant;
  final AppTableVariant variant;
  final bool isStriped;
  final bool isStripedColumns;
  final bool isHoverable;
  final bool isBordered;
  final bool isBorderless;
  final bool isSmall;
  final bool isDark;
  final bool borderPrimary;
  final bool useGroupDividers;
  final AppTableVerticalAlign verticalAlign;

  const AppGridTable({
    super.key,
    required this.columns,
    required this.rows,
    this.pagination,
    this.search = false,
    this.sort = false,
    this.loading = false,
    this.fixedHeader = false,
    this.height,
    this.hiddenColumns,
    this.headerVariant,
    this.variant = AppTableVariant.defaultVariant,
    this.isStriped = false,
    this.isStripedColumns = false,
    this.isHoverable = false,
    this.isBordered = false,
    this.isBorderless = false,
    this.isSmall = false,
    this.isDark = false,
    this.borderPrimary = false,
    this.useGroupDividers = false,
    this.verticalAlign = AppTableVerticalAlign.middle,
  });

  @override
  AppStatefulWrapperState<AppGridTable> createState() => _AppGridTableState();
}

class _AppGridTableState extends AppStatefulWrapperState<AppGridTable> {
  int _currentPage = 1;
  String _searchQuery = '';
  int? _sortColumnIndex;
  bool _sortAscending = true;

  List<List<dynamic>> get _filteredAndSortedRows {
    List<List<dynamic>> currentRows = List.from(widget.rows);

    // Apply Search
    if (widget.search && _searchQuery.isNotEmpty) {
      final query = _searchQuery.toLowerCase();
      currentRows = currentRows.where((row) {
        return row.any((cell) => cell.toString().toLowerCase().contains(query));
      }).toList();
    }

    // Apply Sorting
    if (widget.sort && _sortColumnIndex != null) {
      currentRows.sort((a, b) {
        dynamic aValue = a[_sortColumnIndex!];
        dynamic bValue = b[_sortColumnIndex!];

        int comparison = 0;
        if (aValue is num && bValue is num) {
          comparison = aValue.compareTo(bValue);
        } else {
          comparison = aValue.toString().toLowerCase().compareTo(
            bValue.toString().toLowerCase(),
          );
        }

        return _sortAscending ? comparison : -comparison;
      });
    }

    return currentRows;
  }

  List<List<dynamic>> _getPaginatedRows(List<List<dynamic>> rows) {
    if (widget.pagination == null) return rows;
    final limit = widget.pagination!;
    int start = (_currentPage - 1) * limit;
    int end = start + limit;
    if (start >= rows.length) {
      start = 0;
      // Note: In real app, we might reset _currentPage here
    }
    if (end > rows.length) end = rows.length;
    return rows.sublist(start, end);
  }

  void _handleSort(int absoluteIndex) {
    if (!widget.sort) return;

    setState(() {
      if (_sortColumnIndex == absoluteIndex) {
        if (_sortAscending) {
          _sortAscending = false;
        } else {
          _sortColumnIndex = null; // Reset sort
          _sortAscending = true;
        }
      } else {
        _sortColumnIndex = absoluteIndex;
        _sortAscending = true;
      }
      _currentPage = 1;
    });
  }

  Widget _buildHeaderCell(
    String title,
    int absoluteIndex,
    AppColorsExtension colors,
  ) {
    bool isSortingThis = _sortColumnIndex == absoluteIndex;
    return AppInteractiveWidget(
      onTap: widget.sort ? () => _handleSort(absoluteIndex) : null,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(title),
          if (widget.sort) ...[
            const SizedBox(width: 4),
            Icon(
              isSortingThis
                  ? (_sortAscending ? Icons.arrow_upward : Icons.arrow_downward)
                  : Icons.unfold_more,
              size: 14,
              color: isSortingThis
                  ? colors.primary
                  : colors.bodySecondaryColor.withValues(alpha: 0.4),
            ),
          ],
        ],
      ),
    );
  }

  @override
  Widget buildWidget(BuildContext context) {
    final colors = context.theme.extension<AppColorsExtension>()!;
    final typography = context.theme.extension<AppTypographyExtension>()!;
    final spacing = context.theme.extension<AppSpacingExtension>()!;
    final radii = context.theme.extension<AppRadiusExtension>()!;

    final processedRows = _filteredAndSortedRows;
    final paginatedRows = _getPaginatedRows(processedRows);
    final totalPages = widget.pagination != null
        ? (processedRows.length / widget.pagination!).ceil()
        : 1;

    // Header Widgets
    List<Widget> headers = [];
    for (int i = 0; i < widget.columns.length; i++) {
      if (widget.hiddenColumns?.contains(i) ?? false) continue;
      headers.add(_buildHeaderCell(widget.columns[i], i, colors));
    }

    // Body Content Widgets
    List<List<Widget>> rowsData = [];
    for (var row in paginatedRows) {
      List<Widget> rowCells = [];
      for (int i = 0; i < row.length; i++) {
        if (widget.hiddenColumns?.contains(i) ?? false) continue;

        dynamic val = row[i];
        if (val is Widget) {
          rowCells.add(val);
        } else {
          rowCells.add(Text(val.toString()));
        }
      }
      rowsData.add(rowCells);
    }

    Widget table = AppTable(
      columns: headers,
      rows: rowsData,
      headerVariant: widget.headerVariant,
      variant: widget.variant,
      isStriped: widget.isStriped,
      isStripedColumns: widget.isStripedColumns,
      isHoverable: widget.isHoverable,
      isBordered: widget.isBordered,
      isBorderless: widget.isBorderless,
      isSmall: widget.isSmall,
      isDark: widget.isDark,
      borderPrimary: widget.borderPrimary,
      useGroupDividers: widget.useGroupDividers,
      verticalAlign: widget.verticalAlign,
    );

    if (widget.fixedHeader || widget.height != null) {
      table = SizedBox(
        height: widget.height ?? 400,
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: table,
        ),
      );
    }

    if (widget.loading) {
      table = Stack(
        children: [
          Opacity(opacity: 0.5, child: IgnorePointer(child: table)),
          Positioned.fill(
            child: Center(
              child: Container(
                padding: EdgeInsets.all(spacing.s3),
                decoration: BoxDecoration(
                  color: colors.bodyBg,
                  borderRadius: radii.base,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.1),
                      blurRadius: 12,
                    ),
                  ],
                ),
                child: const AppSpinner(size: AppSpinnerSize.md),
              ),
            ),
          ),
        ],
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        if (widget.search)
          Padding(
            padding: EdgeInsets.only(bottom: spacing.s4),
            child: Align(
              alignment: Alignment.centerRight,
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 240),
                child: AppTextField(
                  hintText: 'Search records...',
                  prefixIcon: const Icon(Icons.search),
                  onChanged: (val) {
                    setState(() {
                      _searchQuery = val;
                      _currentPage = 1;
                    });
                  },
                ),
              ),
            ),
          ),
        Container(
          clipBehavior: Clip.antiAlias,
          decoration: BoxDecoration(
            border: !widget.isBorderless
                ? Border.all(
                    color: widget.isDark
                        ? const Color(0xFF272F37)
                        : colors.borderColor,
                  )
                : null,
            borderRadius: widget.isBorderless ? null : radii.base,
          ),
          child: table,
        ),
        if (widget.pagination != null && totalPages > 1)
          Padding(
            padding: EdgeInsets.only(top: spacing.s4),
            child: Wrap(
              alignment: WrapAlignment.spaceBetween,
              crossAxisAlignment: WrapCrossAlignment.center,
              spacing: spacing.s4,
              runSpacing: spacing.s3,
              children: [
                Text(
                  'Showing ${paginatedRows.isEmpty ? 0 : (_currentPage - 1) * widget.pagination! + 1} to '
                  '${(_currentPage - 1) * widget.pagination! + paginatedRows.length} '
                  'of ${processedRows.length} entries',
                  style: typography.bodySm.copyWith(
                    color: colors.bodySecondaryColor,
                  ),
                ),
                AppPagination(
                  totalPages: totalPages,
                  currentPage: _currentPage,
                  onPageChanged: (page) => setState(() => _currentPage = page),
                  size: AppPaginationSize.sm,
                  shape: AppPaginationShape.rounded,
                ),
              ],
            ),
          ),
      ],
    );
  }
}
