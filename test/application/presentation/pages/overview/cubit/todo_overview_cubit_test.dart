import 'package:either_dart/either.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:mockito/mockito.dart';
import 'package:todo_app/application/app/presentation/pages/overview/cubit/to_do_overview_cubit.dart';
import 'package:todo_app/core/use_case.dart';
import 'package:todo_app/domain/usecases/load_todo_collections.dart';

class MockLoadToDoCollections extends Mock implements LoadToDoCollections {}

void main() {
  group('ToDoOverviewCubit', () {
    late ToDoOverviewCubit toDoOverviewCubit;
    late MockLoadToDoCollections mockLoadToDoCollections;

    setUp(() {
      mockLoadToDoCollections = MockLoadToDoCollections();
      toDoOverviewCubit =
          ToDoOverviewCubit(loadToDoCollections: mockLoadToDoCollections);
    });

    tearDown(() {
      toDoOverviewCubit.close();
    });

    blocTest<ToDoOverviewCubit, ToDoOverviewState>(
      'emits [ToDoOverviewLoadingState, ToDoOverviewLoadedState] when readToDoCollections is called successfully',
      build: () {
        when(mockLoadToDoCollections.call(NoParams()))
            .thenAnswer((_) async => const Right([]));
        return toDoOverviewCubit;
      },
      act: (cubit) => cubit.readToDoCollections(),
      expect: () => [
        ToDoOverviewLoadingState(),
        const ToDoOverviewLoadedState(collections: []),
      ],
    );

    blocTest<ToDoOverviewCubit, ToDoOverviewState>(
      'emits [ToDoOverviewLoadingState, ToDoOverviewErrorState] when readToDoCollections encounters an error',
      build: () {
        when(mockLoadToDoCollections.call(NoParams())).thenThrow(Exception());
        return toDoOverviewCubit;
      },
      act: (cubit) => cubit.readToDoCollections(),
      expect: () => [
        ToDoOverviewLoadingState(),
        ToDoOverviewErrorState(),
      ],
    );
  });
}
