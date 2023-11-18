import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:nimbus/core/domain/chart_data.dart';
import 'package:nimbus/core/domain/constants.dart';
import 'package:nimbus/core/domain/date_value.dart';
import 'package:nimbus/features/weather/application/measure_service.dart';

class TemperatureChart extends StatefulWidget {
  const TemperatureChart({super.key});

  @override
  State<TemperatureChart> createState() => _TemperatureChartState();
}

class _TemperatureChartState extends State<TemperatureChart> {
  final MeasuresService _measuresService = MeasuresService();

  List<Color> gradientColors = [
    Colors.orange,
    Colors.red,
  ];

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        AspectRatio(
          aspectRatio: 1.70,
          child: Padding(
            padding: const EdgeInsets.only(
              right: 18,
              left: 12,
              top: 24,
              bottom: 12,
            ),
            child: LineChart(
              mainData(),
            ),
          ),
        ),
      ],
    );
  }

  Widget bottomTitleWidgets(double value, TitleMeta meta) {
    const style = TextStyle(
      fontWeight: FontWeight.w300,
      fontSize: 12,
    );

    double milliseconds = value * Constants.timestampConversorMultiplier;
    DateValue dateValue = DateValue.fromTimestamp(milliseconds.toInt());

    return SideTitleWidget(
      axisSide: meta.axisSide,
      child: Text(dateValue.getTime(), style: style),
    );
  }

  Widget leftTitleWidgets(double value, TitleMeta meta) {
    const style = TextStyle(
      fontWeight: FontWeight.w300,
      fontSize: 12,
    );

    return Text(value.toString(), style: style, textAlign: TextAlign.left);
  }

  LineChartData mainData() {
    List<ChartData>? chartData =
        _measuresService.getTodayMeasureTemperatureChartData() ?? [];

    List<FlSpot> flSpotsFromData = chartData.map((e) => e.flSpot).toList();

    List<double> minAndMax = ChartData.getMinAndMaxYValues(chartData);

    return LineChartData(
      gridData: const FlGridData(show: false),
      titlesData: FlTitlesData(
        show: true,
        rightTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        topTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
              showTitles: true,
              reservedSize: 30,
              interval: 4,
              getTitlesWidget: bottomTitleWidgets),
        ),
        leftTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            interval: 1,
            reservedSize: 42,
            getTitlesWidget: leftTitleWidgets,
          ),
        ),
      ),
      borderData: FlBorderData(
        show: false,
      ),
      minY: minAndMax[0],
      maxY: minAndMax[1],
      lineBarsData: [
        LineChartBarData(
          spots: flSpotsFromData,
          isCurved: true,
          gradient: LinearGradient(
            colors: gradientColors,
          ),
          barWidth: 1,
          isStrokeCapRound: true,
          dotData: const FlDotData(
            show: false,
          ),
          belowBarData: BarAreaData(
            show: true,
            gradient: LinearGradient(
              colors: gradientColors
                  .map((color) => color.withOpacity(0.3))
                  .toList(),
            ),
          ),
        ),
      ],
    );
  }
}
