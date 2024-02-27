import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/application/app/components/todo_entry_item/cubit/todo_entry_item_cubit.dart';
import 'package:todo_app/application/app/components/todo_entry_item/view_states/todo_entry_item_error.dart';
import 'package:todo_app/application/app/components/todo_entry_item/view_states/todo_entry_item_loaded.dart';
import 'package:todo_app/application/app/components/todo_entry_item/view_states/todo_entry_item_loading.dart';
import 'package:todo_app/domain/entities/unique_id.dart';
import 'package:todo_app/domain/repositories/todo_repository.dart';
import 'package:todo_app/domain/usecases/load_todo_entry.dart';
import 'package:todo_app/domain/usecases/update_todo_entry.dart';

class ToDoEntryItemProvider extends StatelessWidget {
  const ToDoEntryItemProvider({
    super.key,
    required this.collectionId,
    required this.entryId,
  });

  final CollectionId collectionId;
  final EntryId entryId;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ToDoEntryItemCubit>(
      create: (context) => ToDoEntryItemCubit(
        loadToDoEntry: LoadToDoEntry(
          toDoRepository: RepositoryProvider.of<ToDoRepository>(context),
        ),
        entryId: entryId,
        collectionId: collectionId,
        uploadToDoEntry: UpdateToDoEntry(
          toDoRepository: RepositoryProvider.of<ToDoRepository>(context),
        ),
      )..fetch(),
      child: const ToDoEntryItem(),
    );
  }
}

class ToDoEntryItem extends StatelessWidget {
  const ToDoEntryItem({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ToDoEntryItemCubit, ToDoEntryItemState>(
        builder: (context, state) {
      if (state is ToDoEntryItemLoadingState) {
        return const ToDoEntryItemLoading();
      } else if (state is ToDoEntryItemLoadedState) {
        return ToDoEntryItemLoaded(
          entryItem: state.toDoEntry,
          onChanged: (value) => context.read<ToDoEntryItemCubit>().update(),
        );
      } else {
        return const ToDoEntryItemError();
      }
    });
  }
}
