part of 'api_bloc.dart';

abstract class ApiState extends Equatable {
  const ApiState();
  
  @override
  List<Object> get props => [];
}

class ApiInitial extends ApiState {}
class DataLoaded extends ApiState {
  final Model model;
  const DataLoaded({required this.model});
  @override
  List<Object> get props => [model];
}

class ErrorState extends ApiState {
  final String errorMessage;
  const ErrorState({required this.errorMessage});
}
class SearchingState extends ApiState{
  
}