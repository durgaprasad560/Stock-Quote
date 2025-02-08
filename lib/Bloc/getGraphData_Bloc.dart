import 'dart:convert';
import 'package:Stock_Quote/Secrets/secretsKeys.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_bloc/flutter_bloc.dart';

sealed class GetIndividualDataState {}

final class GetIndividualDataStateInitial
    extends GetIndividualDataState {} // Initial

final class GetIndividualDataStateSuccess extends GetIndividualDataState {
  Map<String, dynamic> response;
  GetIndividualDataStateSuccess({required this.response});
} // Success

final class GetIndividualDataStateFailed
    extends GetIndividualDataState {} // Failure

final class GetIndividualDataStateLoading
    extends GetIndividualDataState {} // Loading

sealed class GetIndividualDataEvent {}

final class GetIndividualDataRequested extends GetIndividualDataEvent {
  final String ticker;
  GetIndividualDataRequested({required this.ticker});
}

class GetIndividualDataBloc
    extends Bloc<GetIndividualDataEvent, GetIndividualDataState> {
  GetIndividualDataBloc() : super(GetIndividualDataStateInitial()) {
    on<GetIndividualDataRequested>((event, emit) async {
      emit(GetIndividualDataStateLoading());
      final Uri uri = Uri.parse(
          "https://www.alphavantage.co/query?function=TIME_SERIES_INTRADAY&symbol=${event.ticker}&interval=15min&apikey=${SecretKeys().getIndividualDataKey}");

      try {
        final response = await http.get(uri);
        if (response.statusCode == 200) {
          Map<String, dynamic> finalResponse = jsonDecode(response.body);
          Map<String, dynamic> res =
              finalResponse["Time Series (15min)"] ?? {"Data": "None"};
          emit(GetIndividualDataStateSuccess(response: res));
          print(res);
        }
      } catch (e) {
        emit(GetIndividualDataStateFailed());
      }
    });
  }
}
