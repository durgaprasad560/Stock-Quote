import 'package:Stock_Quote/ScreenUtils/LoserGraphWidget.dart';
import 'package:Stock_Quote/ScreenUtils/stockContainerWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'watchList.dart';
import '../../Bloc/getAllData_Bloc.dart';

class LoserStocksPage extends StatelessWidget {
  const LoserStocksPage({super.key});

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
      buildWhen: (prev, curr) => curr is! GetAllDataStateInitial,
      listenWhen: (prev, curr) => curr is GetAllDataStateInitial,
      builder: (context, state) {
        if (state is GetAllDataStateSuccess) {
          return ListView.builder(
            itemCount: state.topLosses.length,
            itemBuilder: (context, ind) {
              return GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => Losser_Graph_Present(
                                  ticker: state.topLosses[ind]["ticker"],
                                )));
                  },
                  child: StockDetails(
                    ticker: state.topLosses[ind]["ticker"],
                    priceOfTheCurrentStock: state.topLosses[ind]["price"],
                    changePrice: state.topLosses[ind]["change_amount"],
                    changePercentage: state.topLosses[ind]["change_percentage"],
                    volume: state.topLosses[ind]["volume"],
                    icon: GestureDetector(
                      onTap: () async {
                        await _saveToWatchlist(state.topLosses[ind]);
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                              content: Text(
                                  "${state.topLosses[ind]['ticker']} added to WatchList")),
                        );
                      },
                      child: Icon(
                        Icons.bookmark,
                        color: Colors.white,
                      ),
                    ),
                  ));
            },
          );
        } else if (state is GetAllDataLoadingState) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else {
          // Return POP UP Message over here...
          return SizedBox();
        }
      },
      listener: (context, state) {
        // TODO:
        // handle State Failure Error over here
      },
    );
  }
}
