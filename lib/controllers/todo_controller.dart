import 'dart:developer' as dev;

import 'package:codingjr_todo/db/todo_db.dart';
import 'package:codingjr_todo/models/models.dart';
import 'package:get/get.dart';
import 'package:codingjr_todo/constants.dart';

// Defining a GetX Controller for managing Todo-related operations
class TodoController extends GetxController {
  // Constructor that takes an optional TodoDB parameter or initializes it using Get.find
  TodoController({
    TodoDB? todoDB,
  }) : _todoDB = todoDB ?? Get.find<TodoDB>();

  // Private instance of TodoDB for database operations
  final TodoDB _todoDB;

  // Reactive lists for pending and completed Todos
  final pendingTodos = RxList<Todo>.empty();
  final completedTodos = RxList<Todo>.empty();

  // Lifecycle method executed when the controller is initialized
  @override
  void onInit() {
    super.onInit();

    // Fetching pending and completed Todos when the controller is initialized
    _fetchPendingTodos();
    _fetchCompletedTodos();
  }

  // Private method to fetch pending Todos from the database
  Future<void> _fetchPendingTodos() async {
    try {
      final result = await _todoDB.queryPendingTodos();
      final todos = result.map((todo) => Todo.fromJson(todo)).toList();

      // Adding fetched pending Todos to the reactive list
      pendingTodos.addAll(todos);
    } catch (e) {
      // Logging an error if an exception occurs during fetching
      dev.log('An error occurred while fetching todos');
    }
  }

  // Private method to fetch completed Todos from the database
  Future<void> _fetchCompletedTodos() async {
    try {
      final result = await _todoDB.queryCompletedTodos();
      final todos = result.map((todo) => Todo.fromJson(todo)).toList();

      // Adding fetched completed Todos to the reactive list
      completedTodos.addAll(todos);
    } catch (e) {
      // Logging an error if an exception occurs during fetching
      dev.log('An error occurred while fetching completed todos');
    }
  }

  // Method to add a new Todo to the database and the pending Todos list
  Future<void> addTodo(Todo todo) async {
    final newTodo = todo.copyWith(id: uuid.v8());

    try {
      await _todoDB.insertOne(newTodo);
      // Adding the new pending Todo to the reactive list
      pendingTodos.add(newTodo);
    } catch (e) {
      // Logging an error if an exception occurs during addition
      dev.log('An error occurred while adding todo');
    }
  }

  // Method to mark a Todo as completed and update the database and lists accordingly
  Future<void> markTodoAsCompleted(Todo todo) async {
    final completed = todo.copyWith(
      isDone: true,
      completedAt: DateTime.now(),
    );

    try {
      await _todoDB.updateTodo(completed);
      // Removing the completed Todo from pending and adding to completed Todos list
      pendingTodos.removeWhere((todo) => todo.id == completed.id);
      completedTodos.add(completed);
    } catch (e) {
      // Logging an error if an exception occurs during update
      dev.log('An error occurred while updating todo');
    }
  }

  // Method to mark a Todo as incomplete and update the database and lists accordingly
  Future<void> markTodoAsIncomplete(Todo todo) async {
    final pending = todo.copyWith(
      isDone: false,
      completedAt: DateTime.now(),
    );

    try {
      await _todoDB.updateTodo(pending);
      // Removing the pending Todo from completed and adding to pending Todos list
      completedTodos.removeWhere((todo) => todo.id == pending.id);
      pendingTodos.add(pending);
    } catch (e) {
      // Logging an error if an exception occurs during update
      dev.log('An error occurred while updating todo');
    }
  }

  // Method to delete a Todo by ID and update the database and lists accordingly
  Future<void> deleteTodo(String id) async {
    try {
      await _todoDB.delete(id);
      // Removing the deleted Todo from both pending and completed Todos lists
      pendingTodos.removeWhere((todo) => todo.id == id);
      completedTodos.removeWhere((todo) => todo.id == id);
    } catch (e) {
      // Logging an error if an exception occurs during deletion
      dev.log('An error occurred while removing todo');
    }
  }

  // Lifecycle method executed when the controller is closed
  @override
  void onClose() {
    // Clearing and closing the reactive lists when the controller is closed
    pendingTodos
      ..clear()
      ..close();

    completedTodos
      ..clear()
      ..close();

    super.onClose();
  }
}
