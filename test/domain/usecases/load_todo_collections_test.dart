import 'package:either_dart/either.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:todo_app/core/use_case.dart';
import 'package:todo_app/domain/entities/todo_collection.dart';
import 'package:todo_app/domain/entities/todo_color.dart';
import 'package:todo_app/domain/entities/unique_id.dart';
import 'package:todo_app/domain/failures/failures.dart';
import 'package:todo_app/domain/repositories/todo_repository.dart';
import 'package:todo_app/domain/usecases/load_todo_collections.dart';

// Create a mock implementation of the 'ToDoRepository' interface for testing
class MockToDoRepository extends Mock implements ToDoRepository {}

void main() {
  late LoadToDoCollections useCase;
  late MockToDoRepository mockToDoRepository;

  // Set up the test enviroment
  setUp(() {
    mockToDoRepository = MockToDoRepository();
    useCase = LoadToDoCollections(toDoRepository: mockToDoRepository);
  });

  // Define the list of todo collections for testing purposes
  final todoCollectionList = [
    ToDoCollection(
        id: CollectionId.fromUniqueString('1'),
        title: 'Work',
        color: ToDoColor(colorIndex: 0)),
    ToDoCollection(
        id: CollectionId.fromUniqueString('2'),
        title: 'Groceries',
        color: ToDoColor(colorIndex: 1)),
  ];

  // Test case: should load todo collections from the repository
  test("should load todo collections from the repository", () async {
    // Arrange: Define the behavior of the mock repository method
    when(mockToDoRepository.readToDoCollections())
        .thenAnswer((_) async => Right(todoCollectionList));

    // Act: Call the use case
    final result = await useCase.call(NoParams());

    // Assert: Verify the result and interactions with the mock repository
    expect(
        result, Right(todoCollectionList)); // Check if the result is expected
    verify(mockToDoRepository
        .readToDoCollections()); // Verify that the method was called
    verifyNoMoreInteractions(
        mockToDoRepository); // Verify no additional interactions occurred
  });

  // Test case: should return a failure when an exception occurs
  test('should return a failure when an exception occurs', () async {
    // Arrange: Define the behavior of the mock repository method to throw an exception
    when(mockToDoRepository.readToDoCollections())
        .thenThrow(Exception('Server Error'));

    // Act: Call the use case
    final result = await useCase(NoParams());

    // Assert: Verify the result and interactions with the mock repository
    expect(
        result,
        Left(ServerFailure(
            stackTrace:
                'Exception: Server Error'))); // Check if the failure is returned
    verify(mockToDoRepository
        .readToDoCollections()); // Verify that the method was called
    verifyNoMoreInteractions(
        mockToDoRepository); // Verify no additional interactions occurred
  });
}
