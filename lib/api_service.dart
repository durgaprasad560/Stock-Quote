import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static const String baseUrl =
      "https://www.alphavantage.co/query?function=TIME_SERIES_INTRADAY&symbol=IBM&interval=5min&apikey=demo";
  static const String apiKey = "85CMFZ2I9ZGV1GLM";

  Future<Map<String, dynamic>> fetchStockData(String symbol) async {
    final url = Uri.parse(
        "$baseUrl?function=TIME_SERIES_INTRADAY&symbol=$symbol&interval=5min&apikey=$apiKey");

    final response = await http.get(url);

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception("Failed to load stock data");
    }
  }
}
