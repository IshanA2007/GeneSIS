import 'package:fl_chart/fl_chart.dart';

class GPAData {
  final spots = const [
    FlSpot(12, 50),
    FlSpot(25, 48),
    FlSpot(55, 10),
    FlSpot(72, 90),
    FlSpot(87, 22),
    FlSpot(91, 78),
    FlSpot(100, 12),
    FlSpot(110, 87),
  ];

  final leftTitle = {20: "3.2", 50: "3.5", 80: "3.8", 110: "4.1"};

  final bottomTitle = {
    20: "Feb",
    60: "Jun",
    100: "Oct",
  };
}
