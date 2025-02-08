import 'package:flutter/material.dart';
import 'package:http/io_client.dart';
import '../Themes/themeData.dart';
import 'RedGraphWidget.dart';
import 'GreenGraphWidget.dart';

class StockDetails extends StatelessWidget {
  final String ticker; // Unique ID of the Company
  final String priceOfTheCurrentStock; // Current Price of the Stock
  final String
      changePrice; // Indicates the diff between previous and current price
  final String changePercentage; // (CurrPrice / PreviousPrice) * 100
  final String volume;
  final Widget icon;
  const StockDetails(
      {super.key,
      required this.ticker,
      required this.priceOfTheCurrentStock,
      required this.changePrice,
      required this.changePercentage,
      required this.volume,
      required this.icon});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(8),
      child: Container(
        height: 90,
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(20)),
          boxShadow: [
            BoxShadow(
              color: Color(0xFF3D3D3D),
              offset: Offset(1.6, 1.3),
              blurRadius: 1.5,
              spreadRadius: 0,
            ),
          ],
          color: AppTheme().backGroundColor,
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(6.0),
                  child: Row(
                    children: [
                      Text(
                        ticker,
                        style: TextStyle(color: AppTheme().textColor),
                      ),
                      Text(
                        ' -USD',
                        style: TextStyle(color: AppTheme().secondaryTextColor),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                  flex: 1,
                  child: Padding(
                    padding: const EdgeInsets.all(1),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: (changePercentage[0] != '-')
                          ? PositiveGraphReadingWidget()
                          : NegativeGraphReadingWidget(),
                      // child: NegativeGraphReadingWidget(),
                    ),
                  )),
              Expanded(
                  child: Padding(
                padding: const EdgeInsets.all(6.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      "\$$priceOfTheCurrentStock",
                      style: TextStyle(color: AppTheme().textColor),
                    ),
                    Text(
                      changePercentage,
                      style: TextStyle(
                          color: (changePercentage[0] != '-')
                              ? AppTheme().darkPositiveColor
                              : AppTheme().negativeColor),
                    ),
                  ],
                ),
              )),
              SizedBox(
                width: 10,
              ),
              Center(child: icon)
            ],
          ),
        ),
      ),
    );
  }
}
