import 'package:either_dart/either.dart';
import 'package:todo_app/domain/entities/todo_collection.dart';
import 'package:todo_app/domain/entities/todo_entry.dart';
import 'package:todo_app/domain/entities/unique_id.dart';
import 'package:todo_app/domain/failures/failures.dart';

abstract class ToDoRepository {
  Future<Either<Failure, List<ToDoCollection>>> readToDoCollections();

  Future<Either<Failure, ToDoEntry>> readToDoEntry(
      CollectionId collectionId, EntryId entryId);

  Future<Either<Failure, List<EntryId>>> readToDoEntryIds(
      CollectionId collectionId);
}
