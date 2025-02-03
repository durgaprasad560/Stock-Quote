import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'search_provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => StockProvider()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Home(),
    );
  }
}

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final stockProvider = Provider.of<StockProvider>(context);

    return Scaffold(
      appBar: AppBar(
        shadowColor: const Color.fromARGB(255, 180, 255, 159),
        elevation: 2.5,
        backgroundColor: Colors.black,
        title: Center(
          child: Text(
            "Marketing",
            style: GoogleFonts.acme(color: Colors.green[300]),
          ),
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(20),
          ),
        ),
      ),
      backgroundColor: Colors.black,
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              style: TextStyle(color: Colors.white),
              controller: _searchController,
              decoration: InputDecoration(
                labelText: "Enter Stock Symbol",
                border: OutlineInputBorder(),
                suffixIcon: IconButton(
                  icon: Icon(Icons.search),
                  onPressed: () {
                    if (_searchController.text.isNotEmpty) {
                      stockProvider.getStockData(_searchController.text.trim());
                    }
                  },
                ),
              ),
            ),
            SizedBox(height: 20),
            stockProvider.isLoading
                ? Center(child: CircularProgressIndicator())
                : stockProvider.errorMessage.isNotEmpty
                    ? Center(child: Text(stockProvider.errorMessage))
                    : stockProvider.stockData == null
                        ? Center(child: Text("Enter a stock symbol to search"))
                        : Expanded(
                            child: ListView(
                              children: [
                                // Ensure stockData is valid before accessing keys
                                if (stockProvider.stockData != null &&
                                    stockProvider.stockData!
                                        .containsKey("Meta Data"))
                                  Text(
                                    "Symbol: ${stockProvider.stockData!["Meta Data"]["2. Symbol"]}",
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold),
                                  ),
                                if (stockProvider.stockData != null &&
                                    stockProvider.stockData!
                                        .containsKey("Meta Data"))
                                  Text(
                                    "Last Refreshed: ${stockProvider.stockData!["Meta Data"]["3. Last Refreshed"]}",
                                  ),
                                Divider(),
                                Text("Stock Prices:"),
                                // Check if "Time Series (5min)" exists before mapping
                                if (stockProvider.stockData != null &&
                                    stockProvider.stockData!
                                        .containsKey("Time Series (5min)"))
                                  ...stockProvider
                                      .stockData!["Time Series (5min)"].entries
                                      .map((entry) {
                                    final time = entry.key;
                                    final data = entry.value;
                                    return ListTile(
                                      title: Text("Time: $time"),
                                      subtitle: Text(
                                          "Open: ${data["1. open"]} | Close: ${data["4. close"]}"),
                                    );
                                  }).toList(),
                              ],
                            ),
                          ),
          ],
        ),
      ),
    );
  }
}
