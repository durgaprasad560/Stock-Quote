import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class ShowStockChartsPage extends StatefulWidget {
  final String ticker;
  const ShowStockChartsPage({super.key, required this.ticker});

  @override
  State<ShowStockChartsPage> createState() => _ShowStockChartsPageState();
}

class _ShowStockChartsPageState extends State<ShowStockChartsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(child: Container()),
          Expanded(child: Container()),
        ],
      ),
    );
  }
}
