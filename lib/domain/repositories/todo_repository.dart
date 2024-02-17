import 'package:either_dart/either.dart';
import 'package:todo_app/domain/entities/todo_collection.dart';
import 'package:todo_app/domain/failures/failures.dart';

abstract class ToDoRepository {
  Future<Either<Failure, List<ToDoCollection>>> readToDoCollections();
}
