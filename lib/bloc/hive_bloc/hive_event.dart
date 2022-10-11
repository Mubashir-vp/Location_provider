part of 'hive_bloc.dart';

abstract class HiveEvent extends Equatable {
  const HiveEvent();

  @override
  List<Object> get props => [];
}

class SaveData extends HiveEvent {
  final HiveModel? data;
  const SaveData({
    required this.data,
  });
  @override
  List<Object> get props => [data!];
}

class LoadHiveData extends HiveEvent {
  final HiveModel? data;
  const LoadHiveData({this.data});
  @override
  List<Object> get props => [data!];
}
