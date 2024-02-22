part of 'to_do_overview_cubit.dart';

abstract class ToDoOverviewState extends Equatable {
  const ToDoOverviewState();

  @override
  List<Object> get props => [];
}

class ToDoOverviewLoadingState extends ToDoOverviewState {}

class ToDoOverviewErrorState extends ToDoOverviewState {}

class ToDoOverviewLoadedState extends ToDoOverviewState {
  const ToDoOverviewLoadedState({required this.collections});

  final List<ToDoCollection> collections;

  @override
  List<Object> get props => [collections];
}
