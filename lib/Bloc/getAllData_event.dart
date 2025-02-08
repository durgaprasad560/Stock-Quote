part of 'getAllData_Bloc.dart';

// All The Event States

abstract class GetAllDataEvent {}

class GetAllDataEventRequested extends GetAllDataEvent {}

class SearchStockEvent extends GetAllDataEvent {
  final String query;
  SearchStockEvent(this.query);
}
