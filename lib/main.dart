import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/application/app/presentation/app.dart';
import 'package:todo_app/data/repositories/todo_collection_repository_mock.dart';
import 'package:todo_app/domain/repositories/todo_repository.dart';

void main() {
  runApp(
    RepositoryProvider<ToDoRepository>(
      create: (context) => ToDoRepositoryMock(),
      child: const App(),
    ),
  );
}
