import 'dart:convert';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../Themes/themeData.dart';

class Losser_Graph_Present extends StatefulWidget {
  final String ticker;
  const Losser_Graph_Present({super.key, required this.ticker});

  @override
  State<Losser_Graph_Present> createState() => _Losser_Graph_PresentState();
}

class _Losser_Graph_PresentState extends State<Losser_Graph_Present> {
  List<FlSpot> stockSpots = [];
  String stockTicker = "";

  @override
  void initState() {
    super.initState();
    fetchTopLosersData();
  }

  Future<void> fetchTopLosersData() async {
    final url = Uri.parse(
        "https://www.alphavantage.co/query?function=TOP_GAINERS_LOSERS&apikey=demo");
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final List<dynamic> topLosers = data["top_losers"];

        var selectedStock = topLosers.firstWhere(
            (stock) => stock["ticker"] == widget.ticker,
            orElse: () => null);

        setState(() {
          stockTicker = selectedStock["ticker"];
          stockSpots = topLosers.asMap().entries.map((entry) {
            int index = entry.key;
            double priceChange = double.parse(entry.value["change_amount"]);
            return FlSpot(index.toDouble(), priceChange);
          }).toList();
        });
      } else {
        print("Failed to load stock data");
      }
    } catch (e) {
      print("Error: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme().backGroundColor,
      body: Column(
        children: [
          SizedBox(
            height: 60,
          ),
          Text(
            stockTicker.isNotEmpty ? "$stockTicker" : "Loading...",
            style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: AppTheme().textColor),
          ),
          SizedBox(
            height: 250,
          ),
          Center(
            child: Container(
              width: 350,
              height: 300,
              decoration: BoxDecoration(
                border: Border.all(color: AppTheme().textColor, width: 2),
                borderRadius: BorderRadius.circular(10),
                color: AppTheme().primaryColor,
              ),
              padding: const EdgeInsets.all(10),
              child: stockSpots.isEmpty
                  ? const Center(
                      child: CircularProgressIndicator(color: Colors.white))
                  : LineChart(
                      LineChartData(
                        backgroundColor: AppTheme().backGroundColor,
                        borderData: FlBorderData(show: false),
                        gridData: FlGridData(
                          show: true,
                          drawVerticalLine: false,
                          getDrawingHorizontalLine: (value) => FlLine(
                              color: Colors.grey.withOpacity(0.3),
                              strokeWidth: 1),
                        ),
                        titlesData: FlTitlesData(
                          leftTitles: AxisTitles(
                            sideTitles: SideTitles(
                              showTitles: true,
                              reservedSize: 40,
                              getTitlesWidget: (value, meta) {
                                return Text(
                                  value.toString(),
                                  style: const TextStyle(
                                      color: Colors.white, fontSize: 12),
                                );
                              },
                            ),
                          ),
                          bottomTitles: AxisTitles(
                            sideTitles: SideTitles(
                              showTitles: true,
                              getTitlesWidget: (value, meta) {
                                return Text(
                                  "Day ${value.toInt() + 1}",
                                  style: const TextStyle(
                                      color: Colors.white, fontSize: 12),
                                );
                              },
                            ),
                          ),
                          rightTitles: AxisTitles(
                              sideTitles: SideTitles(showTitles: false)),
                          topTitles: AxisTitles(
                              sideTitles: SideTitles(showTitles: false)),
                        ),
                        minX: 0,
                        maxX: stockSpots.length.toDouble() - 1,
                        minY: stockSpots.isNotEmpty
                            ? stockSpots
                                    .map((spot) => spot.y)
                                    .reduce((a, b) => a < b ? a : b) -
                                1
                            : 0,
                        maxY: stockSpots.isNotEmpty
                            ? stockSpots
                                    .map((spot) => spot.y)
                                    .reduce((a, b) => a > b ? a : b) +
                                1
                            : 10,
                        lineBarsData: [
                          LineChartBarData(
                            spots: stockSpots,
                            isCurved: true,
                            barWidth: 3,
                            color: AppTheme().darkPositiveColor,
                            belowBarData: BarAreaData(
                              show: true,
                              gradient: LinearGradient(
                                colors: stockSpots.any((spot) => spot.y < 0)
                                    ? [
                                        AppTheme().negativeColor,
                                        Colors.red.withOpacity(0.1)
                                      ]
                                    : [
                                        AppTheme().darkPositiveColor,
                                        Colors.green.withOpacity(0.1)
                                      ],
                              ),
                            ),
                            dotData: FlDotData(show: true),
                          ),
                        ],
                      ),
                    ),
            ),
          ),
          SizedBox(
            height: 200,
          ),
        ],
      ),
    );
  }
}
