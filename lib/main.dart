import 'package:codingjr_todo/db/todo_db.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

Future<void> main() async {
  await _initServices();

  runApp(const MaterialApp());
}

Future<void> _initServices() async {
  await Get.putAsync(() => TodoDB().init());
}
