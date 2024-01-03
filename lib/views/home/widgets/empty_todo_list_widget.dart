import 'package:flutter/material.dart';

class EmptyTodoList extends StatelessWidget {
  const EmptyTodoList({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('Your todo list is empty'),
    );
  }
}
