import 'package:codingjr_todo/controllers/controllers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PendingTodosList extends GetView<TodoController> {
  const PendingTodosList({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final todos = controller.pendingTodos;

      return switch (todos.isEmpty) {
        false => ListView.builder(
            itemCount: todos.length,
            itemBuilder: (context, index) {
              final todo = todos.elementAt(index);

              return CheckboxListTile(
                value: todo.isDone,
                key: Key(todo.id),
                title: Text(todo.title),
                subtitle: Text(todo.note),
                secondary: IconButton(
                  onPressed: () => controller.deleteTodo(todo.id),
                  icon: const Icon(
                    Icons.delete_forever,
                    color: Colors.redAccent,
                  ),
                ),
                onChanged: (bool? value) {
                  if (value != null && value) {
                    controller.markTodoAsCompleted(todo);
                  }
                },
              );
            },
          ),
        _ => const Center(
            child: Text('You do not have any pending Todos.'),
          ),
      };
    });
  }
}
