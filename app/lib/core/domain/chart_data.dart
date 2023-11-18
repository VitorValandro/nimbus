import 'package:fl_chart/fl_chart.dart';
import 'package:nimbus/core/domain/constants.dart';
import 'package:nimbus/core/domain/date_value.dart';

class ChartData {
  final DateValue x;
  final double y;

  ChartData(this.x, this.y);

  FlSpot get flSpot =>
      FlSpot(Constants.timestampConversorDivider(x.unixTimestamp), y);

  static List<double> getMinAndMaxYValues(List<ChartData> data) {
    double min = data
        .map((e) => e.y)
        .reduce((value, element) => value < element ? value : element)
        .toDouble();

    double max = data
        .map((e) => e.y)
        .reduce((value, element) => value > element ? value : element)
        .toDouble();

    double offset = max - min;

    return [(min - offset).ceilToDouble(), (max + offset).ceilToDouble()];
  }
}
