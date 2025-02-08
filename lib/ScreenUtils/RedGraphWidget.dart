import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import '../Themes/themeData.dart';

class NegativeGraphReadingWidget extends StatelessWidget {
  const NegativeGraphReadingWidget({super.key});

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
              FlSpot(65, 0.5),
              FlSpot(75, 0.4),
              FlSpot(90, -1)
            ],
            isCurved: false,
            color: AppTheme().negativeColor,
            dotData: FlDotData(show: false),
          )
        ]));
  }
}
