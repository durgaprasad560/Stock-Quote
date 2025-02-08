import 'package:Stock_Quote/Themes/themeData.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class WatchList extends StatefulWidget {
  const WatchList({super.key});

  @override
  _WatchListState createState() => _WatchListState();
}

class _WatchListState extends State<WatchList> {
  List<String> _watchlist = [];

  @override
  void initState() {
    super.initState();
    _loadWatchlist();
  }

  // Load WatchList data
  Future<void> _loadWatchlist() async {
    final prefs = await SharedPreferences.getInstance();
    List<String> watchlist = prefs.getStringList('watchlist') ?? [];
    setState(() {
      _watchlist = watchlist;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme().backGroundColor,
      appBar: AppBar(
        title: const Text('WatchList',
            style: TextStyle(
              color: Colors.white,
            )),
        backgroundColor: AppTheme().primaryColor,
      ),
      body: ListView.builder(
        itemCount: _watchlist.length,
        itemBuilder: (context, index) {
          return Card(
            elevation: 5.0,
            shadowColor: Colors.white24,
            color: AppTheme().primaryColor,
            child: ListTile(
              iconColor: Colors.red[300],
              title: Text(
                _watchlist[index],
                style: TextStyle(color: Colors.white),
              ),
              trailing: IconButton(
                icon: Icon(Icons.remove_circle),
                onPressed: () async {
                  final prefs = await SharedPreferences.getInstance();
                  _watchlist.removeAt(index);
                  await prefs.setStringList('watchlist', _watchlist);
                  setState(() {});
                },
              ),
            ),
          );
        },
      ),
    );
  }
}
