import 'package:flutter/material.dart';
import 'package:todo_app/domain/entities/todo_collection.dart';

class ToDoOverviewLoaded extends StatelessWidget {
  const ToDoOverviewLoaded({super.key, required this.collections});

  final List<ToDoCollection> collections;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: collections.length,
        itemBuilder: (context, index) {
          final item = collections[index];
          final colorScheme = Theme.of(context).colorScheme;

          return ListTile(
            tileColor: colorScheme.surface,
            selectedColor: item.color.color,
            iconColor: item.color.color,
            selectedTileColor: colorScheme.surfaceVariant,
            onTap: () => debugPrint(item.title),
            leading: const Icon(Icons.circle),
            title: Text(item.title),
          );
        });
  }
}