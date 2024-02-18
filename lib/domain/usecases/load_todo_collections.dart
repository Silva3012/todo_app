import 'package:either_dart/either.dart';
import 'package:todo_app/core/use_case.dart';
import 'package:todo_app/domain/entities/todo_collection.dart';
import 'package:todo_app/domain/failures/failures.dart';
import 'package:todo_app/domain/repositories/todo_repository.dart';

class LoadToDoCollections implements UseCase<List<ToDoCollection>, NoParams> {
  const LoadToDoCollections({required this.toDoRepository});

  final ToDoRepository toDoRepository;

  @override
  Future<Either<Failure, List<ToDoCollection>>> call(NoParams params) async {
    try {
      final loadedCollections = toDoRepository.readToDoCollections();
      print(loadedCollections);
      return loadedCollections.fold(
        (left) => Left(left),
        (right) => Right(right),
      );
    } on Exception catch (e) {
      return Left(
        ServerFailure(stackTrace: e.toString()),
      );
    }
  }
}
