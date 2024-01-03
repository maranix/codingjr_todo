import 'package:codingjr_todo/app.dart';
import 'package:codingjr_todo/controllers/controllers.dart';
import 'package:codingjr_todo/db/todo_db.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await _initServices();

  runApp(const CodingJrTodoApp());
}

// Function to initialize services, specifically TodoDB and TodoController
Future<void> _initServices() async {
  // Creating an instance of TodoDB and initializing the database
  final todoDB = TodoDB();
  await todoDB.init();

  // Registering TodoDB as a lazy singleton service with GetX
  Get.lazyPut(() => todoDB);

  // Registering TodoController as a lazy singleton service with GetX
  Get.lazyPut(() => TodoController());
}
