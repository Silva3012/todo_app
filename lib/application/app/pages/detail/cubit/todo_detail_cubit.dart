import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:todo_app/core/use_case.dart';
import 'package:todo_app/domain/entities/unique_id.dart';
import 'package:todo_app/domain/usecases/load_todo_entry_id_for_collection.dart';

part 'todo_detail_state.dart';

class ToDoDetailCubit extends Cubit<ToDoDetailState> {
  ToDoDetailCubit(
      {required this.collectionId, required this.loadToDoEntryIdsForCollection})
      : super(ToDoDetailLoadingState());

  final CollectionId collectionId;
  final LoadToDoEntryIdsForCollection loadToDoEntryIdsForCollection;

  Future<void> fetch() async {
    emit(ToDoDetailLoadingState());
    try {
      final entryIds = await loadToDoEntryIdsForCollection.call(
        CollectionIdParam(collectionId: collectionId),
      );

      if (entryIds.isLeft) {
        emit(ToDoDetailErrorState());
      } else {
        emit(ToDoDetailLoadedState(entryIds: entryIds.right));
      }
    } on Exception {
      emit(ToDoDetailErrorState());
    }
  }
}
