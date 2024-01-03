import 'dart:developer' as dev;

import 'package:codingjr_todo/db/todo_db.dart';
import 'package:codingjr_todo/models/models.dart';
import 'package:get/get.dart';
import 'package:codingjr_todo/constants.dart';

final class PendingTodoController extends GetxController {
  PendingTodoController({
    TodoDB? todoDB,
  }) : _todoDB = todoDB ?? Get.find<TodoDB>();

  final TodoDB _todoDB;

  final data = RxList<Todo>.empty();

  @override
  void onInit() {
    super.onInit();

    _fetchPendingTodos();
  }

  Future<void> _fetchPendingTodos() async {
    try {
      final result = await _todoDB.queryPendingTodos();
      final todos = result.map((todo) => Todo.fromJson(todo)).toList();

      data.addAll(todos);
    } catch (e) {
      dev.log('An error occurred while fetching todos');
    }
  }

  Future<void> addTodo(Todo todo) async {
    final newTodo = todo.copyWith(id: uuid.v8());

    try {
      await _todoDB.insertOne(newTodo);
      data.add(newTodo);
    } catch (e) {
      dev.log('An error occurred while add todo');
    }
  }

  Future<void> markTodoAsCompleted(Todo todo) async {
    final completed = todo.copyWith(
      isDone: true,
      completedAt: DateTime.now(),
    );

    try {
      await _todoDB.updateTodo(completed);
      data.removeWhere((todo) => todo.id == completed.id);
    } catch (e) {
      dev.log('An error occurred while updating todo');
    }
  }

  Future<void> updateTodo(Todo todo) async {
    final updated = todo.copyWith(updatedAt: DateTime.now());
    final idx = data.indexWhere((todo) => todo.id == updated.id);

    try {
      await _todoDB.updateTodo(updated);

      if (idx != -1) {
        data[idx] = updated;
      }
    } catch (e) {
      dev.log('An error occurred while updating todo');
    }
  }

  Future<void> deleteTodo(String id) async {
    try {
      await _todoDB.delete(id);
      data.removeWhere((todo) => todo.id == id);
    } catch (e) {
      dev.log('An error occurred while removing todo');
    }
  }

  @override
  void onClose() {
    data
      ..clear()
      ..close();

    super.onClose();
  }
}

final class CompletedTodoController extends GetxController {
  CompletedTodoController({
    TodoDB? todoDB,
  }) : _todoDB = todoDB ?? Get.find<TodoDB>();

  final TodoDB _todoDB;

  final data = RxList<Todo>.empty();

  @override
  void onInit() async {
    super.onInit();

    await _fetchCompletedTodos();
  }

  Future<void> _fetchCompletedTodos() async {
    try {
      final result = await _todoDB.queryCompletedTodos();
      final todos = result.map((todo) => Todo.fromJson(todo)).toList();

      data.addAll(todos);
    } catch (e) {
      dev.log('An error occurred while fetching completed todos');
    }
  }

  Future<void> updateCompletedTodos() async {
    try {
      final todos = await _fetchCompletedTodos();
    } catch (e) {
      dev.log('An error occurred while updating todos');
    }
  }

  Future<void> deleteTodo(String id) async {
    try {
      await _todoDB.delete(id);
    } catch (e) {
      dev.log('An error occurred while deleting todo');
    }
  }

  @override
  void onClose() {
    data
      ..clear()
      ..close();

    super.onClose();
  }
}
