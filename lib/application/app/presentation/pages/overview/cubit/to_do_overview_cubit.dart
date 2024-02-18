import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:todo_app/core/use_case.dart';
import 'package:todo_app/domain/entities/todo_collection.dart';
import 'package:todo_app/domain/usecases/load_todo_collections.dart';

part 'to_do_overview_state.dart';

class ToDoOverviewCubit extends Cubit<ToDoOverviewState> {
  ToDoOverviewCubit(
      {required this.loadToDoCollections, ToDoOverviewState? initialState})
      : super(initialState ?? ToDoOverviewLoadingState());

  final LoadToDoCollections loadToDoCollections;

  Future<void> readToDoCollections() async {
    emit(ToDoOverviewLoadingState());
    try {
      final collectionsFuture = loadToDoCollections.call(NoParams());
      final collections = await collectionsFuture;

      if (collections.isLeft) {
        emit(ToDoOverviewErrorState());
      } else {
        emit(ToDoOverviewLoadedState(collections: collections.right));
      }
    } on Exception {
      emit(ToDoOverviewErrorState());
    }
  }
}
