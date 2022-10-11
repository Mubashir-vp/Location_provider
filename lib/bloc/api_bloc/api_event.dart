part of 'api_bloc.dart';

abstract class ApiEvent extends Equatable {
  const ApiEvent();

  @override
  List<Object> get props => [];
}

class Searching extends ApiEvent {}

class LoadData extends ApiEvent {
  final Model? data;
  final String lat;
  final String lon;
  const LoadData({this.data, required this.lat,required this.lon});
  @override
  List<Object> get props => [data!];
}
