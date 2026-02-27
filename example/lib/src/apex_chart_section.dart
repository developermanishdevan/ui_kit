import 'dart:math';
import 'package:flutter/material.dart';
import 'package:ui_kit/ui_kit.dart';
import 'package:iconify_flutter_plus/iconify_flutter_plus.dart';
import 'package:iconify_flutter_plus/icons/bx.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:fl_chart/fl_chart.dart';

class _ChartData {
  final dynamic x;
  final double? y;
  final double? y1;
  final double? y2;
  final double? open;
  final double? high;
  final double? low;
  final double? close;

  _ChartData({
    this.x,
    this.y,
    this.y1,
    this.y2,
    this.open,
    this.high,
    this.low,
    this.close,
  });
}

class ApexChartSection extends StatelessWidget {
  const ApexChartSection({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Chart', style: AppTypography.h4),
                    Row(
                      children: [
                        Text(
                          'App',
                          style: AppTypography.bodySm.copyWith(
                            color: Theme.of(
                              context,
                            ).extension<AppColorsExtension>()!.primary,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Iconify(
                          Bx.chevron_right,
                          size: 16,
                          color: Theme.of(
                            context,
                          ).extension<AppColorsExtension>()!.bodySecondaryColor,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          'Chart',
                          style: AppTypography.bodySm.copyWith(
                            color: Theme.of(
                              context,
                            ).extension<AppColorsExtension>()!.bodyColor,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          LayoutBuilder(
            builder: (context, constraints) {
              final isDesktop = constraints.maxWidth > 768;
              final width = isDesktop
                  ? (constraints.maxWidth / 2) - 12
                  : constraints.maxWidth;

              return Wrap(
                spacing: 24,
                runSpacing: 24,
                children: [
                  SizedBox(
                    width: width,
                    child: _buildLineWithDataLabels(context),
                  ),
                  SizedBox(
                    width: width,
                    child: _buildGradientLineChart(context),
                  ),
                  SizedBox(
                    width: width,
                    child: _buildStackedAreaChart(context),
                  ),
                  SizedBox(
                    width: width,
                    child: _buildBasicColumnChart(context),
                  ),
                  SizedBox(
                    width: width,
                    child: _buildColumnWithDataLabels(context),
                  ),
                  SizedBox(
                    width: width,
                    child: _buildLineAreaMixedChart(context),
                  ),
                  SizedBox(width: width, child: _buildBasicBarChart(context)),
                  SizedBox(
                    width: width,
                    child: _buildNegativeStackedBar(context),
                  ),
                  SizedBox(width: width, child: _buildScatterXYChart(context)),
                  SizedBox(
                    width: width,
                    child: _buildCandlestickChart(context),
                  ),
                  SizedBox(width: width, child: _buildPieChart(context)),
                  SizedBox(
                    width: width,
                    child: _buildGradientDonutChart(context),
                  ),
                  SizedBox(width: width, child: _buildRadialBarChart(context)),
                  SizedBox(
                    width: width,
                    child: _buildMultipleRadialBars(context),
                  ),
                  SizedBox(
                    width: width,
                    child: _buildStrokedCircularGauge(context),
                  ),
                  SizedBox(
                    width: constraints.maxWidth,
                    child: _buildSparklines(context),
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _wrapChart(
    BuildContext context,
    String title,
    Widget chart, {
    double height = 380,
  }) {
    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: Theme.of(
                context,
              ).extension<AppColorsExtension>()!.bodyColor,
            ),
          ),
          const SizedBox(height: 16),
          SizedBox(height: height, child: chart),
        ],
      ),
    );
  }

  Widget _buildLineWithDataLabels(BuildContext context) {
    final theme = Theme.of(context).extension<AppColorsExtension>()!;
    final data = [
      _ChartData(x: 'Jan', y: 28, y1: 12),
      _ChartData(x: 'Feb', y: 29, y1: 11),
      _ChartData(x: 'Mar', y: 33, y1: 14),
      _ChartData(x: 'Apr', y: 36, y1: 18),
      _ChartData(x: 'May', y: 32, y1: 17),
      _ChartData(x: 'Jun', y: 32, y1: 13),
      _ChartData(x: 'Jul', y: 33, y1: 13),
    ];

    return _wrapChart(
      context,
      'Line with Data Labels',
      SfCartesianChart(
        tooltipBehavior: TooltipBehavior(enable: true, shared: true),
        trackballBehavior: TrackballBehavior(
          enable: true,
          activationMode: ActivationMode.singleTap,
          tooltipSettings: const InteractiveTooltip(enable: true),
        ),
        primaryXAxis: const CategoryAxis(
          majorGridLines: MajorGridLines(width: 0),
        ),
        primaryYAxis: const NumericAxis(minimum: 5, maximum: 40),
        legend: const Legend(isVisible: true, position: LegendPosition.top),
        series: <CartesianSeries>[
          LineSeries<_ChartData, String>(
            name: 'High - 2018',
            dataSource: data,
            xValueMapper: (d, _) => d.x as String,
            yValueMapper: (d, _) => d.y,
            color: theme.primary,
            markerSettings: const MarkerSettings(isVisible: true),
            dataLabelSettings: const DataLabelSettings(isVisible: true),
          ),
          LineSeries<_ChartData, String>(
            name: 'Low - 2018',
            dataSource: data,
            xValueMapper: (d, _) => d.x as String,
            yValueMapper: (d, _) => d.y1,
            color: theme.success,
            markerSettings: const MarkerSettings(isVisible: true),
            dataLabelSettings: const DataLabelSettings(isVisible: true),
          ),
        ],
      ),
    );
  }

  Widget _buildGradientLineChart(BuildContext context) {
    final yValues = [
      4,
      3,
      10,
      9,
      29,
      19,
      22,
      9,
      12,
      7,
      19,
      5,
      13,
      9,
      17,
      2,
      7,
      5,
    ];
    final data = List.generate(
      yValues.length,
      (i) => _ChartData(x: i.toString(), y: yValues[i].toDouble()),
    );

    return _wrapChart(
      context,
      'Gradient Line Chart',
      SfCartesianChart(
        tooltipBehavior: TooltipBehavior(enable: true, shared: true),
        trackballBehavior: TrackballBehavior(
          enable: true,
          activationMode: ActivationMode.singleTap,
          tooltipSettings: const InteractiveTooltip(enable: true),
        ),
        primaryXAxis: const CategoryAxis(
          majorGridLines: MajorGridLines(width: 0),
        ),
        primaryYAxis: const NumericAxis(minimum: 0, maximum: 40),
        series: <CartesianSeries>[
          LineSeries<_ChartData, String>(
            name: 'Likes',
            dataSource: data,
            xValueMapper: (d, _) => d.x as String,
            yValueMapper: (d, _) => d.y,
            width: 4,
            onCreateShader: (ShaderDetails details) {
              return const LinearGradient(
                colors: [Color(0xFFf672a7), Color(0xFF6658dd)],
              ).createShader(details.rect);
            },
            markerSettings: const MarkerSettings(
              isVisible: true,
              color: Color(0xFF56c2d6),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStackedAreaChart(BuildContext context) {
    final theme = Theme.of(context).extension<AppColorsExtension>()!;
    final random = Random(42);
    final data = List.generate(
      20,
      (i) => _ChartData(
        x: 'Day $i',
        y: 10 + random.nextInt(50).toDouble(),
        y1: 10 + random.nextInt(10).toDouble(),
        y2: 10 + random.nextInt(5).toDouble(),
      ),
    );

    return _wrapChart(
      context,
      'Stacked Area',
      SfCartesianChart(
        tooltipBehavior: TooltipBehavior(enable: true, shared: true),
        trackballBehavior: TrackballBehavior(
          enable: true,
          activationMode: ActivationMode.singleTap,
          tooltipSettings: const InteractiveTooltip(enable: true),
        ),
        primaryXAxis: const CategoryAxis(
          majorGridLines: MajorGridLines(width: 0),
        ),
        legend: const Legend(isVisible: true, position: LegendPosition.top),
        series: <CartesianSeries>[
          StackedAreaSeries<_ChartData, String>(
            name: 'South',
            dataSource: data,
            xValueMapper: (d, _) => d.x as String,
            yValueMapper: (d, _) => d.y,
            color: theme.primary.withValues(alpha: 0.7),
          ),
          StackedAreaSeries<_ChartData, String>(
            name: 'North',
            dataSource: data,
            xValueMapper: (d, _) => d.x as String,
            yValueMapper: (d, _) => d.y1,
            color: theme.warning.withValues(alpha: 0.7),
          ),
          StackedAreaSeries<_ChartData, String>(
            name: 'Central',
            dataSource: data,
            xValueMapper: (d, _) => d.x as String,
            yValueMapper: (d, _) => d.y2,
            color: theme.bodySecondaryColor.withValues(alpha: 0.7),
          ),
        ],
      ),
    );
  }

  Widget _buildBasicColumnChart(BuildContext context) {
    final theme = Theme.of(context).extension<AppColorsExtension>()!;
    final cats = [
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
    ];
    final y1 = [44, 55, 57, 56, 61, 58, 63, 60, 66];
    final y2 = [76, 85, 101, 98, 87, 105, 91, 114, 94];
    final y3 = [35, 41, 36, 26, 45, 48, 52, 53, 41];
    final data = List.generate(
      cats.length,
      (i) => _ChartData(
        x: cats[i],
        y: y1[i].toDouble(),
        y1: y2[i].toDouble(),
        y2: y3[i].toDouble(),
      ),
    );

    return _wrapChart(
      context,
      'Basic Column Chart',
      SfCartesianChart(
        tooltipBehavior: TooltipBehavior(enable: true, shared: true),
        trackballBehavior: TrackballBehavior(
          enable: true,
          activationMode: ActivationMode.singleTap,
          tooltipSettings: const InteractiveTooltip(enable: true),
        ),
        primaryXAxis: const CategoryAxis(
          majorGridLines: MajorGridLines(width: 0),
        ),
        legend: const Legend(isVisible: true, position: LegendPosition.top),
        series: <CartesianSeries>[
          ColumnSeries<_ChartData, String>(
            name: 'Net Profit',
            dataSource: data,
            xValueMapper: (d, _) => d.x as String,
            yValueMapper: (d, _) => d.y,
            color: theme.primary,
          ),
          ColumnSeries<_ChartData, String>(
            name: 'Revenue',
            dataSource: data,
            xValueMapper: (d, _) => d.x as String,
            yValueMapper: (d, _) => d.y1,
            color: theme.success,
          ),
          ColumnSeries<_ChartData, String>(
            name: 'Free Cash Flow',
            dataSource: data,
            xValueMapper: (d, _) => d.x as String,
            yValueMapper: (d, _) => d.y2,
            color: theme.bodySecondaryColor,
          ),
        ],
      ),
    );
  }

  Widget _buildColumnWithDataLabels(BuildContext context) {
    final theme = Theme.of(context).extension<AppColorsExtension>()!;
    final cats = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec',
    ];
    final y = [2.3, 3.1, 4.0, 10.1, 4.0, 3.6, 3.2, 2.3, 1.4, 0.8, 0.5, 0.2];
    final data = List.generate(
      cats.length,
      (i) => _ChartData(x: cats[i], y: y[i]),
    );

    return _wrapChart(
      context,
      'Column Chart with Datalabels',
      SfCartesianChart(
        tooltipBehavior: TooltipBehavior(enable: true, shared: true),
        trackballBehavior: TrackballBehavior(
          enable: true,
          activationMode: ActivationMode.singleTap,
          tooltipSettings: const InteractiveTooltip(enable: true),
        ),
        primaryXAxis: const CategoryAxis(
          majorGridLines: MajorGridLines(width: 0),
          labelPlacement: LabelPlacement.betweenTicks,
        ),
        primaryYAxis: const NumericAxis(isVisible: false),
        series: <CartesianSeries>[
          ColumnSeries<_ChartData, String>(
            name: 'Inflation',
            dataSource: data,
            xValueMapper: (d, _) => d.x as String,
            yValueMapper: (d, _) => d.y,
            color: theme.primary,
            dataLabelSettings: const DataLabelSettings(
              isVisible: true,
              labelPosition: ChartDataLabelPosition.outside,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLineAreaMixedChart(BuildContext context) {
    final theme = Theme.of(context).extension<AppColorsExtension>()!;
    final cats = [
      'Dec 01',
      'Dec 02',
      'Dec 03',
      'Dec 04',
      'Dec 05',
      'Dec 06',
      'Dec 07',
      'Dec 08',
      'Dec 09',
      'Dec 10',
      'Dec 11',
    ];
    final y1 = [44, 55, 31, 47, 31, 43, 26, 41, 31, 47, 33];
    final y2 = [55, 69, 45, 61, 43, 54, 37, 52, 44, 61, 43];
    final data = List.generate(
      cats.length,
      (i) => _ChartData(x: cats[i], y: y1[i].toDouble(), y1: y2[i].toDouble()),
    );

    return _wrapChart(
      context,
      'Mixed Chart - Line & Area',
      SfCartesianChart(
        tooltipBehavior: TooltipBehavior(enable: true, shared: true),
        trackballBehavior: TrackballBehavior(
          enable: true,
          activationMode: ActivationMode.singleTap,
          tooltipSettings: const InteractiveTooltip(enable: true),
        ),
        primaryXAxis: const CategoryAxis(
          majorGridLines: MajorGridLines(width: 0),
        ),
        axes: const <ChartAxis>[
          NumericAxis(name: 'yAxis2', opposedPosition: true),
        ],
        legend: const Legend(isVisible: true, position: LegendPosition.top),
        series: <CartesianSeries>[
          AreaSeries<_ChartData, String>(
            name: 'TEAM A',
            dataSource: data,
            xValueMapper: (d, _) => d.x as String,
            yValueMapper: (d, _) => d.y,
            color: theme.bodySecondaryColor.withValues(alpha: 0.5),
            borderDrawMode: BorderDrawMode.top,
            borderColor: theme.bodySecondaryColor,
            borderWidth: 2,
          ),
          LineSeries<_ChartData, String>(
            name: 'TEAM B',
            dataSource: data,
            xValueMapper: (d, _) => d.x as String,
            yValueMapper: (d, _) => d.y1,
            yAxisName: 'yAxis2',
            color: theme.primary,
            width: 2,
          ),
        ],
      ),
    );
  }

  Widget _buildBasicBarChart(BuildContext context) {
    final theme = Theme.of(context).extension<AppColorsExtension>()!;
    final cats = [
      'South Korea',
      'Canada',
      'United Kingdom',
      'Netherlands',
      'Italy',
      'France',
      'Japan',
      'United States',
      'China',
      'Germany',
    ];
    final y = [400, 430, 448, 470, 540, 580, 690, 1100, 1200, 1380];
    final data = List.generate(
      cats.length,
      (i) => _ChartData(x: cats[i], y: y[i].toDouble()),
    );

    return _wrapChart(
      context,
      'Basic Bar Chart',
      SfCartesianChart(
        tooltipBehavior: TooltipBehavior(enable: true, shared: true),
        trackballBehavior: TrackballBehavior(
          enable: true,
          activationMode: ActivationMode.singleTap,
          tooltipSettings: const InteractiveTooltip(enable: true),
        ),
        primaryXAxis: const CategoryAxis(
          majorGridLines: MajorGridLines(width: 0),
        ),
        series: <CartesianSeries>[
          BarSeries<_ChartData, String>(
            dataSource: data,
            xValueMapper: (d, _) => d.x as String,
            yValueMapper: (d, _) => d.y,
            color: theme.success,
          ),
        ],
      ),
    );
  }

  Widget _buildNegativeStackedBar(BuildContext context) {
    final theme = Theme.of(context).extension<AppColorsExtension>()!;
    final cats = [
      '85+',
      '80-84',
      '75-79',
      '70-74',
      '65-69',
      '60-64',
      '55-59',
      '50-54',
      '45-49',
      '40-44',
      '35-39',
      '30-34',
      '25-29',
      '20-24',
      '15-19',
      '10-14',
      '5-9',
      '0-4',
    ];
    final males = [
      0.4,
      0.65,
      0.76,
      0.88,
      1.5,
      2.1,
      2.9,
      3.8,
      3.9,
      4.2,
      4,
      4.3,
      4.1,
      4.2,
      4.5,
      3.9,
      3.5,
      3,
    ];
    final females = [
      -0.8,
      -1.05,
      -1.06,
      -1.18,
      -1.4,
      -2.2,
      -2.85,
      -3.7,
      -3.96,
      -4.22,
      -4.3,
      -4.4,
      -4.1,
      -4,
      -4.1,
      -3.4,
      -3.1,
      -2.8,
    ];

    final data = List.generate(
      cats.length,
      (i) => _ChartData(
        x: cats[i],
        y: males[i].toDouble(),
        y1: females[i].toDouble(),
      ),
    );

    return _wrapChart(
      context,
      'Bar with Negative Values',
      SfCartesianChart(
        tooltipBehavior: TooltipBehavior(enable: true, shared: true),
        trackballBehavior: TrackballBehavior(
          enable: true,
          activationMode: ActivationMode.singleTap,
          tooltipSettings: const InteractiveTooltip(enable: true),
        ),
        primaryXAxis: const CategoryAxis(
          majorGridLines: MajorGridLines(width: 0),
        ),
        primaryYAxis: const NumericAxis(minimum: -5, maximum: 5),
        legend: const Legend(isVisible: true, position: LegendPosition.top),
        series: <CartesianSeries>[
          StackedBarSeries<_ChartData, String>(
            name: 'Males',
            dataSource: data,
            xValueMapper: (d, _) => d.x as String,
            yValueMapper: (d, _) => d.y,
            color: theme.primary,
          ),
          StackedBarSeries<_ChartData, String>(
            name: 'Females',
            dataSource: data,
            xValueMapper: (d, _) => d.x as String,
            yValueMapper: (d, _) => d.y1,
            color: theme.success,
          ),
        ],
      ),
    );
  }

  Widget _buildScatterXYChart(BuildContext context) {
    final theme = Theme.of(context).extension<AppColorsExtension>()!;
    final List<_ChartData> sampleA = [
      [16.4, 5.4],
      [21.7, 2],
      [25.4, 3],
      [19, 2],
      [10.9, 1],
      [13.6, 3.2],
      [10.9, 7.4],
      [10.9, 0],
      [10.9, 8.2],
      [16.4, 0],
    ].map((e) => _ChartData(x: e[0], y: e[1].toDouble())).toList();
    final List<_ChartData> sampleB = [
      [6.4, 13.4],
      [1.7, 11],
      [5.4, 8],
      [9, 17],
      [1.9, 4],
      [3.6, 12.2],
      [1.9, 14.4],
      [1.9, 9],
      [1.9, 13.2],
      [1.4, 7],
    ].map((e) => _ChartData(x: e[0], y: e[1].toDouble())).toList();
    final List<_ChartData> sampleC = [
      [21.7, 3],
      [23.6, 3.5],
      [24.6, 3],
      [29.9, 3],
      [21.7, 20],
      [23, 2],
      [10.9, 3],
      [28, 4],
      [27.1, 0.3],
      [16.4, 4],
    ].map((e) => _ChartData(x: e[0], y: e[1].toDouble())).toList();

    return _wrapChart(
      context,
      'Scatter (XY) Chart',
      SfCartesianChart(
        tooltipBehavior: TooltipBehavior(enable: true, shared: true),
        trackballBehavior: TrackballBehavior(
          enable: true,
          activationMode: ActivationMode.singleTap,
          tooltipSettings: const InteractiveTooltip(enable: true),
        ),
        legend: const Legend(isVisible: true, position: LegendPosition.top),
        series: <CartesianSeries>[
          ScatterSeries<_ChartData, num>(
            name: 'Sample A',
            dataSource: sampleA,
            xValueMapper: (d, _) => d.x as num,
            yValueMapper: (d, _) => d.y,
            color: theme.success,
          ),
          ScatterSeries<_ChartData, num>(
            name: 'Sample B',
            dataSource: sampleB,
            xValueMapper: (d, _) => d.x as num,
            yValueMapper: (d, _) => d.y,
            color: theme.danger,
          ),
          ScatterSeries<_ChartData, num>(
            name: 'Sample C',
            dataSource: sampleC,
            xValueMapper: (d, _) => d.x as num,
            yValueMapper: (d, _) => d.y,
            color: theme.bodySecondaryColor,
          ),
        ],
      ),
    );
  }

  Widget _buildCandlestickChart(BuildContext context) {
    final theme = Theme.of(context).extension<AppColorsExtension>()!;
    final data = [
      _ChartData(x: 'Jan', open: 51.98, high: 56.29, low: 51.59, close: 53.85),
      _ChartData(x: 'Feb', open: 53.66, high: 54.99, low: 51.35, close: 52.95),
      _ChartData(x: 'Mar', open: 52.96, high: 53.78, low: 51.54, close: 52.48),
      _ChartData(x: 'Apr', open: 52.54, high: 52.79, low: 47.88, close: 49.24),
      _ChartData(x: 'May', open: 49.1, high: 52.86, low: 47.7, close: 52.78),
      _ChartData(x: 'Jun', open: 52.83, high: 53.48, low: 50.32, close: 52.29),
    ];

    return _wrapChart(
      context,
      'Simple Candlestick Chart',
      SfCartesianChart(
        tooltipBehavior: TooltipBehavior(enable: true, shared: true),
        trackballBehavior: TrackballBehavior(
          enable: true,
          activationMode: ActivationMode.singleTap,
          tooltipSettings: const InteractiveTooltip(enable: true),
        ),
        primaryXAxis: const CategoryAxis(
          majorGridLines: MajorGridLines(width: 0),
        ),
        series: <CartesianSeries>[
          CandleSeries<_ChartData, String>(
            dataSource: data,
            xValueMapper: (d, _) => d.x as String,
            lowValueMapper: (d, _) => d.low,
            highValueMapper: (d, _) => d.high,
            openValueMapper: (d, _) => d.open,
            closeValueMapper: (d, _) => d.close,
            bearColor: theme.success,
            bullColor: theme.primary,
          ),
        ],
      ),
    );
  }

  Widget _buildPieChart(BuildContext context) {
    final theme = Theme.of(context).extension<AppColorsExtension>()!;
    final labels = ['Series 1', 'Series 2', 'Series 3', 'Series 4', 'Series 5'];
    final y = [44, 55, 41, 17, 15];
    final colors = [
      theme.primary,
      theme.info,
      theme.success,
      theme.warning,
      theme.danger,
    ];
    final data = List.generate(
      labels.length,
      (i) => _ChartData(x: labels[i], y: y[i].toDouble()),
    );

    return _wrapChart(
      context,
      'Simple Pie Chart',
      SfCircularChart(
        tooltipBehavior: TooltipBehavior(enable: true),
        legend: const Legend(isVisible: true, position: LegendPosition.bottom),
        series: <CircularSeries>[
          PieSeries<_ChartData, String>(
            dataSource: data,
            xValueMapper: (d, _) => d.x as String,
            yValueMapper: (d, _) => d.y,
            pointColorMapper: (d, i) => colors[i % colors.length],
          ),
        ],
      ),
      height: 320,
    );
  }

  Widget _buildGradientDonutChart(BuildContext context) {
    final theme = Theme.of(context).extension<AppColorsExtension>()!;
    final labels = ['Series 1', 'Series 2', 'Series 3', 'Series 4', 'Series 5'];
    final y = [44, 55, 41, 17, 15];
    final colors = [
      theme.primary,
      theme.info,
      theme.success,
      theme.warning,
      theme.danger,
    ];
    final data = List.generate(
      labels.length,
      (i) => _ChartData(x: labels[i], y: y[i].toDouble()),
    );

    return _wrapChart(
      context,
      'Gradient Donut Chart',
      SfCircularChart(
        tooltipBehavior: TooltipBehavior(enable: true),
        legend: const Legend(isVisible: true, position: LegendPosition.bottom),
        series: <CircularSeries>[
          DoughnutSeries<_ChartData, String>(
            dataSource: data,
            xValueMapper: (d, _) => d.x as String,
            yValueMapper: (d, _) => d.y,
            pointColorMapper: (d, i) => colors[i % colors.length],
            // Gradients can be applied via pointShaderMapper in real-world
          ),
        ],
      ),
      height: 320,
    );
  }

  Widget _buildRadialBarChart(BuildContext context) {
    final theme = Theme.of(context).extension<AppColorsExtension>()!;

    return _wrapChart(
      context,
      'Basic RadialBar Chart',
      SfCircularChart(
        tooltipBehavior: TooltipBehavior(enable: true),
        series: <CircularSeries>[
          RadialBarSeries<_ChartData, String>(
            dataSource: [_ChartData(x: 'CRICKET', y: 70)],
            xValueMapper: (d, _) => d.x as String,
            yValueMapper: (d, _) => d.y,
            maximumValue: 100,
            innerRadius: '70%',
            pointColorMapper: (d, _) => theme.bodySecondaryColor,
          ),
        ],
      ),
      height: 320,
    );
  }

  Widget _buildMultipleRadialBars(BuildContext context) {
    final theme = Theme.of(context).extension<AppColorsExtension>()!;
    final labels = ['Apples', 'Oranges', 'Bananas', 'Berries'];
    final y = [44, 55, 67, 83];
    final colors = [theme.primary, theme.danger, theme.success, theme.warning];
    final data = List.generate(
      labels.length,
      (i) => _ChartData(x: labels[i], y: y[i].toDouble()),
    );

    return _wrapChart(
      context,
      'Multiple RadialBars',
      SfCircularChart(
        tooltipBehavior: TooltipBehavior(enable: true),
        legend: const Legend(isVisible: true, position: LegendPosition.right),
        series: <CircularSeries>[
          RadialBarSeries<_ChartData, String>(
            dataSource: data,
            xValueMapper: (d, _) => d.x as String,
            yValueMapper: (d, _) => d.y,
            maximumValue: 100,
            innerRadius: '30%',
            gap: '10%',
            pointColorMapper: (d, i) => colors[i % colors.length],
          ),
        ],
      ),
      height: 320,
    );
  }

  Widget _buildStrokedCircularGauge(BuildContext context) {
    final theme = Theme.of(context).extension<AppColorsExtension>()!;

    return _wrapChart(
      context,
      'Stroked Circular Guage',
      SfCircularChart(
        tooltipBehavior: TooltipBehavior(enable: true),
        annotations: <CircularChartAnnotation>[
          CircularChartAnnotation(
            widget: Text(
              '67%',
              style: TextStyle(
                color: theme.bodyColor,
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
        series: <CircularSeries>[
          RadialBarSeries<_ChartData, String>(
            dataSource: [_ChartData(x: 'Median Ratio', y: 67)],
            xValueMapper: (d, _) => d.x as String,
            yValueMapper: (d, _) => d.y,
            maximumValue: 100,
            innerRadius: '80%',
            pointColorMapper: (d, _) => theme.danger,
            cornerStyle: CornerStyle.bothCurve,
            trackColor: theme.borderColor,
          ),
        ],
      ),
      height: 320,
    );
  }

  Widget _buildSparklines(BuildContext context) {
    final theme = Theme.of(context).extension<AppColorsExtension>()!;
    final sparklineData = [
      47,
      45,
      54,
      38,
      56,
      24,
      65,
      31,
      37,
      39,
      62,
      51,
      35,
      41,
      35,
      27,
      93,
      53,
      61,
      27,
      54,
      43,
      19,
      46,
    ];

    // Create random suffled variations
    final data1 = List.from(sparklineData)..shuffle(Random(1));
    final data2 = List.from(sparklineData)..shuffle(Random(2));
    final data3 = List.from(sparklineData)..shuffle(Random(3));

    Widget sparkCard(
      String amount,
      String title,
      List<int> values,
      Color color,
    ) {
      return Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              amount,
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            Text(
              title,
              style: TextStyle(fontSize: 13, color: theme.bodySecondaryColor),
            ),
            const SizedBox(height: 16),
            SizedBox(
              height: 100,
              child: LineChart(
                LineChartData(
                  gridData: const FlGridData(show: false),
                  titlesData: const FlTitlesData(show: false),
                  borderData: FlBorderData(show: false),
                  lineBarsData: [
                    LineChartBarData(
                      spots: List.generate(
                        values.length,
                        (i) => FlSpot(i.toDouble(), values[i].toDouble()),
                      ),
                      isCurved: false,
                      color: color,
                      barWidth: 2,
                      dotData: const FlDotData(show: false),
                      belowBarData: BarAreaData(
                        show: true,
                        color: color.withValues(alpha: 0.2),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      );
    }

    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Sparkline Charts',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: theme.bodyColor,
            ),
          ),
          const SizedBox(height: 24),
          Row(
            children: [
              sparkCard(
                '\$424,652',
                'Total Sales',
                data1.cast<int>(),
                theme.primary,
              ),
              const SizedBox(width: 16),
              sparkCard(
                '\$235,312',
                'Expenses',
                data2.cast<int>(),
                theme.bodySecondaryColor,
              ),
              const SizedBox(width: 16),
              sparkCard(
                '\$135,965',
                'Profits',
                data3.cast<int>(),
                const Color(0xFFf672a7),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
