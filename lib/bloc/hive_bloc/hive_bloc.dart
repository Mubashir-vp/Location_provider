// ignore_for_file: unrelated_type_equality_checks

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:workshop/model/hivemodel.dart';
import 'package:workshop/services/hive_services.dart';

part 'hive_event.dart';
part 'hive_state.dart';

class HiveBloc extends Bloc<HiveEvent, HiveState> {
  HiveBloc() : super(HiveInitial()) {
    on<SaveData>((event, emit) {
      _savedata(
        event,
        emit,
        hiveModel: event.data!,
      );
    });
    on<LoadHiveData>((event, emit) {
      _loadData(
        event,
        emit,
      );
    });
  }
  _savedata(
    SaveData event,
    Emitter<HiveState> emit, {
    required HiveModel hiveModel,
  }) {
    try {
      HiveServices().savedatatobox(
        data: hiveModel,
      );
    } catch (e) {
      emit(
        ErrorState(
          errorMessage: e.toString(),
        ),
      );
    }
  }

  _loadData(
    LoadHiveData event,
    Emitter<HiveState> emit,
  ) {
    try {
      var data = HiveServices().loadData();
      if (data == "empty") {
        emit(const EmptyState());
      } else {
        emit(HiveDataLoaded(keys: data));
      }
    } catch (e) {
      emit(ErrorState(errorMessage: e.toString()));
    }
  }
}
