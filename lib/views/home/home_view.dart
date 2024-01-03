import 'package:codingjr_todo/controllers/controllers.dart';
import 'package:codingjr_todo/models/models.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'widgets/widgets.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView>
    with SingleTickerProviderStateMixin {
  late final TodoController _todoController;
  late final TabController _tabController;

  // Method called when a new Todo is added
  void onAdd(String title, String note) {
    final todo = Todo.empty.copyWith(title: title, note: note);

    _todoController.addTodo(todo);
  }

  @override
  void initState() {
    super.initState();

    // Initializing TodoController and TabController in the state
    _todoController = Get.find<TodoController>();
    _tabController = TabController(
      length: 2,
      vsync: this,
    );
  }

  @override
  void dispose() {
    // Disposing controllers and deleting instances when the state is disposed
    // free up all the resources.
    _todoController.dispose();
    _tabController.dispose();

    Get.deleteAll();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final textStyle = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Todo',
          style: textStyle.headlineMedium,
        ),
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            _PendingTodosCount(),
            _CompletedTodosCount(),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: const [
          PendingTodosList(),
          CompletedTodosList(),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => showAdaptiveDialog(
          context: context,
          builder: (context) {
            return AddTodoDialog(onAdd: onAdd);
          },
        ),
        child: const Icon(Icons.add),
      ),
    );
  }
}

// Widget representing the count of pending todos as a Tab
class _PendingTodosCount extends GetView<TodoController> {
  const _PendingTodosCount();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.pendingTodos.isEmpty) {
        return const Tab(
          text: 'Pending',
        );
      }

      return Tab(text: 'Pending (${controller.pendingTodos.length})');
    });
  }
}

// Widget representing the count of completed todos as a Tab
class _CompletedTodosCount extends GetView<TodoController> {
  const _CompletedTodosCount();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.completedTodos.isEmpty) {
        return const Tab(text: 'Completed');
      }

      return Tab(text: 'Completed (${controller.completedTodos.length})');
    });
  }
}
