import 'package:codingjr_todo/views/views.dart';
import 'package:flutter/material.dart';

class CodingJrTodoApp extends StatelessWidget {
  const CodingJrTodoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CodingJr Todo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF2A9D8F),
        ),
      ),
      home: const HomeView(),
    );
  }
}
