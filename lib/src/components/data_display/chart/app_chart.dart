import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import '../../../../ui_kit.dart';

class AppChartSeries {
  final String name;
  final List<double> data;
  final Color? color;
  final bool isArea;

  const AppChartSeries({
    required this.name,
    required this.data,
    this.color,
    this.isArea = false,
  });
}

enum AppChartType { line, area, bar, stackedBar }

class AppChart extends AppStatelessWrapper {
  final List<AppChartSeries> series;
  final List<String> categories;
  final double height;
  final AppChartType type;
  final bool showDataLabels;
  final bool showGrid;
  final bool showLegend;
  final String? title;

  const AppChart({
    super.key,
    required this.series,
    required this.categories,
    this.height = 380,
    this.type = AppChartType.line,
    this.showDataLabels = false,
    this.showGrid = true,
    this.showLegend = true,
    this.title,
  });

  @override
  Widget buildWidget(BuildContext context) {
    if (series.isEmpty) return const SizedBox.shrink();

    final colors = context.theme.extension<AppColorsExtension>()!;
    final typography = context.theme.extension<AppTypographyExtension>()!;
    final spacing = context.theme.extension<AppSpacingExtension>()!;

    return AppSemantics(
      label: title ?? 'Chart',
      child: SizedBox(
        height: height,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (title != null) ...[
              Text(
                title!,
                style: typography.bodyBase.copyWith(
                  fontWeight: AppTypography.semiBold,
                  color: colors.bodyColor,
                ),
              ),
              SizedBox(height: spacing.s3),
            ],
            Expanded(
              child: type == AppChartType.bar || type == AppChartType.stackedBar
                  ? _buildBarChart(context, colors, typography, spacing)
                  : _buildLineChart(context, colors, typography, spacing),
            ),
            if (showLegend) ...[
              SizedBox(height: spacing.s3),
              _buildLegend(context, colors, typography, spacing),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildLineChart(
    BuildContext context,
    AppColorsExtension colors,
    AppTypographyExtension typography,
    AppSpacingExtension spacing,
  ) {
    // Define default colors
    final defaultColors = [
      colors.primary,
      colors.success,
      colors.warning,
      colors.danger,
      colors.info,
    ];

    double minY = double.infinity;
    double maxY = double.negativeInfinity;

    for (var s in series) {
      for (var val in s.data) {
        if (val < minY) minY = val;
        if (val > maxY) maxY = val;
      }
    }

    if (maxY > 0) maxY += maxY * 0.1;

    return LineChart(
      LineChartData(
        minY: minY < 0 ? minY : 0,
        maxY: maxY,
        gridData: FlGridData(
          show: showGrid,
          drawVerticalLine: false,
          getDrawingHorizontalLine: (value) {
            return FlLine(
              color: colors.borderColor,
              strokeWidth: 1,
              dashArray: [5, 5],
            );
          },
        ),
        titlesData: FlTitlesData(
          leftTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              reservedSize: 40,
              getTitlesWidget: (value, meta) {
                return Padding(
                  padding: EdgeInsets.only(right: spacing.s2),
                  child: Text(
                    value.round().toString(),
                    style: typography.bodySm.copyWith(
                      color: colors.bodySecondaryColor,
                    ),
                    textAlign: TextAlign.right,
                  ),
                );
              },
            ),
          ),
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              getTitlesWidget: (value, meta) {
                final int idx = value.toInt();
                if (idx < 0 || idx >= categories.length) {
                  return const SizedBox.shrink();
                }
                return Padding(
                  padding: EdgeInsets.only(top: spacing.s2),
                  child: Text(
                    categories[idx],
                    style: typography.bodySm.copyWith(
                      color: colors.bodySecondaryColor,
                    ),
                  ),
                );
              },
              interval: 1,
            ),
          ),
          rightTitles: const AxisTitles(
            sideTitles: SideTitles(showTitles: false),
          ),
          topTitles: const AxisTitles(
            sideTitles: SideTitles(showTitles: false),
          ),
        ),
        borderData: FlBorderData(show: false),
        lineBarsData: series.asMap().entries.map((entry) {
          int idx = entry.key;
          var s = entry.value;
          Color c = s.color ?? defaultColors[idx % defaultColors.length];

          // isArea check
          bool fillArea = type == AppChartType.area || s.isArea;

          return LineChartBarData(
            spots: s.data.asMap().entries.map((point) {
              return FlSpot(point.key.toDouble(), point.value);
            }).toList(),
            isCurved: true,
            color: c,
            barWidth: 3,
            isStrokeCapRound: true,
            dotData: FlDotData(show: showDataLabels),
            belowBarData: BarAreaData(
              show: fillArea,
              color: c.withValues(alpha: 0.3),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildBarChart(
    BuildContext context,
    AppColorsExtension colors,
    AppTypographyExtension typography,
    AppSpacingExtension spacing,
  ) {
    final defaultColors = [
      colors.primary,
      colors.success,
      colors.warning,
      colors.danger,
      colors.info,
    ];

    double minY = double.infinity;
    double maxY = double.negativeInfinity;

    for (var s in series) {
      for (var val in s.data) {
        if (val < minY) minY = val;
        if (val > maxY) maxY = val;
      }
    }

    // Simplistic stacking tracking to grow max Y if needed
    bool isStacked = type == AppChartType.stackedBar;

    if (isStacked) {
      double maxStacked = 0;
      int dataLength = categories.length;
      for (int i = 0; i < dataLength; i++) {
        double sum = 0;
        for (var s in series) {
          if (i < s.data.length) sum += s.data[i];
        }
        if (sum > maxStacked) maxStacked = sum;
      }
      maxY = maxStacked;
    }

    if (maxY > 0) maxY += maxY * 0.1;
    if (minY > 0) minY = 0;

    List<BarChartGroupData> barGroups = [];
    int dataLength = categories.length;

    for (int i = 0; i < dataLength; i++) {
      List<BarChartRodData> rods = [];

      if (isStacked) {
        double currentBottom = 0;
        List<BarChartRodStackItem> stackItems = [];
        for (int sIdx = 0; sIdx < series.length; sIdx++) {
          var s = series[sIdx];
          double val = i < s.data.length ? s.data[i] : 0;
          Color c = s.color ?? defaultColors[sIdx % defaultColors.length];
          stackItems.add(
            BarChartRodStackItem(currentBottom, currentBottom + val, c),
          );
          currentBottom += val;
        }
        rods.add(
          BarChartRodData(
            toY: currentBottom,
            width: 20,
            borderRadius: BorderRadius.only(
              topLeft: context.theme
                  .extension<AppRadiusExtension>()!
                  .base
                  .topLeft,
              topRight: context.theme
                  .extension<AppRadiusExtension>()!
                  .base
                  .topRight,
            ),
            rodStackItems: stackItems,
          ),
        );
      } else {
        for (int sIdx = 0; sIdx < series.length; sIdx++) {
          var s = series[sIdx];
          double val = i < s.data.length ? s.data[i] : 0;
          Color c = s.color ?? defaultColors[sIdx % defaultColors.length];
          rods.add(
            BarChartRodData(
              toY: val,
              color: c,
              width: 14,
              borderRadius: BorderRadius.only(
                topLeft: context.theme
                    .extension<AppRadiusExtension>()!
                    .base
                    .topLeft,
                topRight: context.theme
                    .extension<AppRadiusExtension>()!
                    .base
                    .topRight,
              ),
            ),
          );
        }
      }

      barGroups.add(BarChartGroupData(x: i, barRods: rods));
    }

    return BarChart(
      BarChartData(
        gridData: FlGridData(
          show: showGrid,
          drawVerticalLine: false,
          getDrawingHorizontalLine: (value) {
            return FlLine(
              color: colors.borderColor,
              strokeWidth: 1,
              dashArray: [5, 5],
            );
          },
        ),
        titlesData: FlTitlesData(
          leftTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              reservedSize: 40,
              getTitlesWidget: (value, meta) {
                if (value == 0) {
                  return const SizedBox.shrink();
                }
                return Padding(
                  padding: EdgeInsets.only(right: spacing.s2),
                  child: Text(
                    value.round().toString(),
                    style: typography.bodySm.copyWith(
                      color: colors.bodySecondaryColor,
                    ),
                    textAlign: TextAlign.right,
                  ),
                );
              },
            ),
          ),
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              getTitlesWidget: (value, meta) {
                final int idx = value.toInt();
                if (idx < 0 || idx >= categories.length) {
                  return const SizedBox.shrink();
                }
                return Padding(
                  padding: EdgeInsets.only(top: spacing.s2),
                  child: Text(
                    categories[idx],
                    style: typography.bodySm.copyWith(
                      color: colors.bodySecondaryColor,
                    ),
                  ),
                );
              },
            ),
          ),
          rightTitles: const AxisTitles(
            sideTitles: SideTitles(showTitles: false),
          ),
          topTitles: const AxisTitles(
            sideTitles: SideTitles(showTitles: false),
          ),
        ),
        borderData: FlBorderData(show: false),
        barGroups: barGroups,
        maxY: maxY,
        minY: minY,
      ),
    );
  }

  Widget _buildLegend(
    BuildContext context,
    AppColorsExtension colors,
    AppTypographyExtension typography,
    AppSpacingExtension spacing,
  ) {
    final defaultColors = [
      colors.primary,
      colors.success,
      colors.warning,
      colors.danger,
      colors.info,
    ];

    return Wrap(
      spacing: spacing.s3,
      runSpacing: spacing.s2,
      alignment: WrapAlignment.center,
      children: series.asMap().entries.map((entry) {
        Color c =
            entry.value.color ??
            defaultColors[entry.key % defaultColors.length];
        return Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 12,
              height: 12,
              decoration: BoxDecoration(color: c, shape: BoxShape.circle),
            ),
            SizedBox(width: spacing.s2),
            Text(
              entry.value.name,
              style: typography.bodySm.copyWith(color: colors.bodyColor),
            ),
          ],
        );
      }).toList(),
    );
  }
}
