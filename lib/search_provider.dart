import 'package:flutter/material.dart';
import 'api_service.dart';

class StockProvider with ChangeNotifier {
  Map<String, dynamic>? stockData;
  bool isLoading = false;
  String errorMessage = "";

  final ApiService _apiService = ApiService();

  Future<void> getStockData(String symbol) async {
    try {
      isLoading = true;
      errorMessage = "";
      notifyListeners();

      final response = await _apiService.fetchStockData(symbol);

      if (response.containsKey("Meta Data")) {
        stockData = response;
      } else {
        errorMessage = "Invalid API response";
        stockData = null;
      }

      print("API Response: $response");
    } catch (e) {
      errorMessage = "Error loading stock data";
      stockData = null;
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
