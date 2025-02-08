part of 'getAllData_Bloc.dart';

// All The State Classes
sealed class GetAllDataState {}

class GetAllDataStateInitial extends GetAllDataState {}

// Success State
class GetAllDataStateSuccess extends GetAllDataState {
  final List topGainers;
  final List topLosses;
  final List activeStocks;
  final String lastUpdated;
  final List<dynamic> searchresult;
  GetAllDataStateSuccess(
      {required this.topGainers,
      required this.topLosses,
      required this.activeStocks,
      required this.lastUpdated,
      required this.searchresult});
}

// Failed to Fetch State
class GetAllDataFailed extends GetAllDataState {
  final String err;
  GetAllDataFailed({required this.err});
}

class GetAllDataLoadingState extends GetAllDataState {}
