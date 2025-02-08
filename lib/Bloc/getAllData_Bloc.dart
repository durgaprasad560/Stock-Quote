import 'dart:convert';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;

part 'getAllData_event.dart';
part 'getAllData_State.dart';

class GetAllDataUsingBloc extends Bloc<GetAllDataEvent, GetAllDataState> {
  List<dynamic> allstocks = [];
  List<dynamic> topLossesList = [];

  GetAllDataUsingBloc() : super(GetAllDataStateInitial()) {
    // Fetching All Stock Data
    on<GetAllDataEventRequested>((event, emit) async {
      emit(GetAllDataLoadingState());
      try {
        final Uri uri = Uri.parse(
            "https://www.alphavantage.co/query?function=TOP_GAINERS_LOSERS&apikey=demo");
        final res = await http.get(uri);
        if (res.statusCode == 200) {
          final Map<String, dynamic> response = jsonDecode(res.body);
          allstocks = response["top_gainers"] ?? [];
          topLossesList = response["top_losers"] ?? [];

          emit(GetAllDataStateSuccess(
            topGainers: response["top_gainers"] ?? [],
            topLosses: topLossesList, // Fixing losses not updating
            activeStocks: response["most_actively_traded"] ?? [],
            lastUpdated: response["last_updated"] ?? "No Data Available",
            searchresult: allstocks,
          ));
        } else {
          emit(GetAllDataFailed(err: "Failed to fetch data"));
        }
      } catch (e) {
        print("Error: ${e.toString()}");
        emit(GetAllDataFailed(err: e.toString()));
      }
    });

    // Handling Stock Search
    on<SearchStockEvent>((event, emit) async {
      final filteredStocks = allstocks
          .where((stock) => stock["ticker"]
              .toString()
              .toLowerCase()
              .contains(event.query.toLowerCase()))
          .toList();

      // Include the stored top losers when filtering
      final filteredLosers = topLossesList
          .where((stock) => stock["ticker"]
              .toString()
              .toLowerCase()
              .contains(event.query.toLowerCase()))
          .toList();

      print("Query: ${event.query}");
      print("Filtered Gainers: ${filteredStocks}");
      print("Filtered Losers: ${filteredLosers}");

      emit(GetAllDataStateSuccess(
        topGainers: allstocks,
        topLosses: filteredLosers,
        activeStocks: state is GetAllDataStateSuccess
            ? (state as GetAllDataStateSuccess).activeStocks
            : [],
        lastUpdated: state is GetAllDataStateSuccess
            ? (state as GetAllDataStateSuccess).lastUpdated
            : "",
        searchresult: filteredStocks,
      ));
    });
  }
}
