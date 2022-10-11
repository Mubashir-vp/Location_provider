part of 'hive_bloc.dart';

abstract class HiveState extends Equatable {
  const HiveState();

  @override
  List<Object> get props => [];
}

class HiveInitial extends HiveState {}

class HiveDataLoaded extends HiveState {
  final List<int> keys;
  const HiveDataLoaded({required this.keys});
  @override
  List<Object> get props => [keys];
}

class ErrorState extends HiveState {
  final String errorMessage;
  const ErrorState({required this.errorMessage});
}

class EmptyState extends HiveState {
  const EmptyState();
}
