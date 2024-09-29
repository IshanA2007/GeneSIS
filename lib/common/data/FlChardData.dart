import 'package:fl_chart/fl_chart.dart';

class FlChartData {
  final List<FlSpot> spots;
  final Map<int, String> leftTitle;
  final Map<int, String> bottomTitle;
  final double minX;
  final double maxX;
  final double minY;
  final double maxY;

  // Constructor with optional parameters, using default values if not provided
  FlChartData({
    required this.spots,
    required this.leftTitle,
    required this.bottomTitle,
    required this.minX,
    required this.maxX,
    required this.minY,
    required this.maxY,
  });
}
