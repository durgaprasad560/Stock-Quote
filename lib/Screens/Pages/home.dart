import 'package:Stock_Quote/Themes/themeData.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../Bloc/getAllData_Bloc.dart';
import 'ProfitStocks.dart';
import 'lossesStocks.dart';
import 'watchList.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final searchTextController = TextEditingController();

  @override
  void initState() {
    context.read<GetAllDataUsingBloc>().add(GetAllDataEventRequested());
    super.initState();
  }

  @override
  void dispose() {
    searchTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: DefaultTabController(
        length: 3,
        child: Scaffold(
            resizeToAvoidBottomInset: false,
            bottomNavigationBar: TabBar(
                splashFactory: NoSplash.splashFactory,
                indicatorAnimation: TabIndicatorAnimation.linear,
                padding: EdgeInsets.only(top: 5, bottom: 8, left: 3, right: 3),
                indicatorSize: TabBarIndicatorSize.tab,
                indicator: BoxDecoration(
                  color: AppTheme().primaryColor,
                  borderRadius: BorderRadius.circular(20),
                ),
                indicatorColor: Colors.transparent,
                labelColor: AppTheme().primaryColor,
                unselectedLabelColor: Colors.grey,
                dividerColor: Colors.transparent,
                tabs: [
                  Tab(
                    icon: Icon(
                      FontAwesomeIcons.arrowTrendUp,
                      color: AppTheme().darkPositiveColor,
                    ),
                  ),
                  Tab(
                    icon: Icon(
                      FontAwesomeIcons.arrowTrendDown,
                      color: AppTheme().negativeColor,
                    ),
                  ),
                  Tab(
                    icon: Icon(
                      FontAwesomeIcons.glasses,
                      color: AppTheme().textColor,
                    ),
                  ),
                ]),
            appBar: AppBar(
              title: Text(
                "Stocks",
                style: TextStyle(color: AppTheme().textColor),
              ),
              backgroundColor: AppTheme().backGroundColor,
              surfaceTintColor: Colors.transparent,
            ),
            backgroundColor: AppTheme().backGroundColor,
            // Bloc Consumer := Main Bloc & Main State...
            body: Column(
              children: [
                Expanded(
                    flex: 1,
                    child: Column(
                      children: [
                        Stack(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: SizedBox(
                                height: 60,
                                width: double.infinity,
                                child: TextField(
                                  controller: searchTextController,
                                  onChanged: (query) {
                                    context
                                        .read<GetAllDataUsingBloc>()
                                        .add(SearchStockEvent(query));
                                  },
                                  cursorColor: AppTheme().textColor,
                                  decoration: InputDecoration(
                                    fillColor: AppTheme().primaryColor,
                                    filled: true,
                                    prefixIcon: Icon(
                                      Icons.search,
                                      color: AppTheme().textColor,
                                    ),
                                    border: OutlineInputBorder(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(20)),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: AppTheme().primaryColor,
                                      ),
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(18)),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: AppTheme().primaryColor,
                                      ),
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(20)),
                                    ),
                                  ),
                                  style: TextStyle(color: AppTheme().textColor),
                                ),
                              ),
                            )
                          ],
                        )
                      ],
                    )),
                Expanded(
                    flex: 7,
                    child: TabBarView(
                      children: [
                        GainerStocks(),
                        LoserStocksPage(),
                        WatchList(),
                      ],
                    )),
              ],
            )),
      ),
    );
  }
}
