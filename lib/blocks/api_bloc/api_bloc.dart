import 'dart:io';

// ignore: depend_on_referenced_packages
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:workshop/services/http_services.dart';
import '../../model/model.dart';
part 'api_event.dart';
part 'api_state.dart';

class ApiBloc extends Bloc<ApiEvent, ApiState> {
  ApiBloc() : super(ApiInitial()) {
    on<LoadData>((event, emit) {
      _loadData(
        event,
        emit,
        lat: event.lat,
        lon: event.lon,
      );
    });
    on<Searching>((event, emit) {
      emit(SearchingState());
    });
  }

  _loadData(LoadData event, Emitter<ApiState> emit,
      {required String lat, required String lon}) async {
    try {
      var data = await HttpServices().loadData(
        lat: lat,
        lon: lon,
      );
      if (data == false) {
        emit(
          const ErrorState(errorMessage: "404 Not found"),
        );
      } else {
        emit(DataLoaded(model: data));
      }
    } on SocketException {
      emit(const ErrorState(errorMessage: "Network Error"));
    } catch (e) {
      emit(ErrorState(errorMessage: e.toString()));
    }
  }
}
