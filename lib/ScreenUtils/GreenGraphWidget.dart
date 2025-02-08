import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import '../Themes/themeData.dart';

class PositiveGraphReadingWidget extends StatelessWidget {
  const PositiveGraphReadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return LineChart(LineChartData(
        gridData: FlGridData(show: false),
        titlesData: FlTitlesData(show: false),
        borderData: FlBorderData(show: false),
        lineTouchData: LineTouchData(enabled: false),
        // Spots Data...
        lineBarsData: [
          LineChartBarData(
            spots: [
              FlSpot(-5, 0),
              FlSpot(4, 0.1),
              FlSpot(20, 2.3),
              FlSpot(40, 0.5),
              FlSpot(50, 1.5),
              FlSpot(65, 1.2),
              FlSpot(80, 3.4),
            ],
            isCurved: false,
            color: AppTheme().positiveColor,
            dotData: FlDotData(show: false),
          )
        ]));
  }
}
