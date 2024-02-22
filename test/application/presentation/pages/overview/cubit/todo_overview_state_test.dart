import 'package:flutter_test/flutter_test.dart';
import 'package:todo_app/application/app/presentation/pages/overview/cubit/to_do_overview_cubit.dart';
import 'package:todo_app/domain/entities/todo_collection.dart';
import 'package:todo_app/domain/entities/todo_color.dart';
import 'package:todo_app/domain/entities/unique_id.dart';

void main() {
  group('ToDoOverviewLoadedState', () {
    test('props are correctly set', () {
      final collections = [
        ToDoCollection(
          id: CollectionId.fromUniqueString('1'),
          title: 'Work',
          color: ToDoColor(colorIndex: 0),
        ),
        ToDoCollection(
          id: CollectionId.fromUniqueString('2'),
          title: 'Groceries',
          color: ToDoColor(colorIndex: 1),
        ),
      ];
      final state1 = ToDoOverviewLoadedState(collections: collections);
      final state2 = ToDoOverviewLoadedState(collections: collections);

      // The two states with the same collections should be equal
      expect(state1, state2);

      // The hashCode should be the same for equal objects
      expect(state1.hashCode, state2.hashCode);

      // Modifying collections should change the state
      final modifiedCollections = [
        ToDoCollection(
          id: CollectionId.fromUniqueString('3'),
          title: 'Code',
          color: ToDoColor(colorIndex: 3),
        ),
      ];
      final modifiedState =
          ToDoOverviewLoadedState(collections: modifiedCollections);

      expect(modifiedState, isNot(equals(state1)));
      expect(modifiedState.hashCode, isNot(equals(state1.hashCode)));
    });
  });
}
