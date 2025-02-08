import 'package:Stock_Quote/ScreenUtils/GraphWidget.dart';
import 'package:Stock_Quote/ScreenUtils/stockContainerWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../Bloc/getGraphData_Bloc.dart';
import 'showStockCharts.dart';
import 'watchList.dart';
import '../../Bloc/getAllData_Bloc.dart';

class GainerStocks extends StatelessWidget {
  const GainerStocks({super.key});

  Future<void> _saveToWatchlist(Map<String, dynamic> stock) async {
    final prefs = await SharedPreferences.getInstance();
    List<String> watchlist = prefs.getStringList('watchlist') ?? [];
    watchlist.add(stock['ticker']);
    await prefs.setStringList('watchlist', watchlist);
  }

  Future<bool> _isInWatchlist(String ticker) async {
    final prefs = await SharedPreferences.getInstance();
    List<String> watchlist = prefs.getStringList('watchlist') ?? [];
    return watchlist.contains(ticker);
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<GetAllDataUsingBloc, GetAllDataState>(
      builder: (context, state) {
        if (state is GetAllDataStateSuccess) {
          final stocks = state.searchresult.isNotEmpty
              ? state.searchresult
              : state.topGainers;

          return ListView.builder(
            itemCount: stocks.length,
            itemBuilder: (context, ind) {
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Gainer_Graph_Present(
                        ticker: stocks[ind]["ticker"],
                      ),
                    ),
                  );
                },
                child: StockDetails(
                  ticker: stocks[ind]["ticker"],
                  priceOfTheCurrentStock: stocks[ind]["price"],
                  changePrice: stocks[ind]["change_amount"],
                  changePercentage: stocks[ind]["change_percentage"],
                  volume: stocks[ind]["volume"],
                  icon: GestureDetector(
                    onTap: () async {
                      await _saveToWatchlist(stocks[ind]);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                            content: Text(
                                "${stocks[ind]['ticker']} added to WatchList")),
                      );
                    },
                    child: Icon(Icons.bookmark, color: Colors.white),
                  ),
                ),
              );
            },
          );
        } else if (state is GetAllDataLoadingState) {
          return Center(child: CircularProgressIndicator());
        } else {
          return SizedBox(); // Handle errors here
        }
      },
      listener: (context, state) {
        // getAllData.add(event)
        // TODO:
        // handle State Failure Error over here
      },
    );
  }
}
