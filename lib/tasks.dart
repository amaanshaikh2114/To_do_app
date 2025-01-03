import 'package:flutter/material.dart';
import 'package:todo_app/models/checkable_todo_task.dart';
import 'package:todo_app/new_task.dart';
import 'package:todo_app/taskslist/tasks_list.dart';

class Tasks extends StatefulWidget {
  const Tasks({super.key});

  @override
  State<StatefulWidget> createState() {
    return _TasksState();
  }
}

class _TasksState extends State<Tasks> {
  final List<CheckableTodoTask> _listedCheckableTodos = [
    const CheckableTodoTask(
      title: 'Flutter Course',
      priority: TaskPriority.normal,
    ),
    const CheckableTodoTask(
      title: 'Learn Web',
      priority: TaskPriority.urgent,
    ),
    const CheckableTodoTask(
      title: 'Check AI/ML',
      priority: TaskPriority.low,
    ),
  ];

  void _showAddTaskSheet() {
    showModalBottomSheet(
      isScrollControlled: true, //pulls the modal to the top
      useSafeArea: true,
      context: context,
      builder: (context) => NewTask(onAddTask: _addTask),
    );
  }

  void _addTask(CheckableTodoTask todoTask) {
    setState(() {
      _listedCheckableTodos.add(todoTask);
    });
  }

  void _removeTask(CheckableTodoTask task) {
    final taskIndex = _listedCheckableTodos.indexOf(task);
    setState(() {
      _listedCheckableTodos.remove(task);
    });
    // removes corresponding snackbars immediately on multiple deletions
    ScaffoldMessenger.of(context).clearSnackBars();
    // logic for bottom snackbars for undo deletion
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: const Duration(seconds: 3),
        content: const Text("Task deleted"),
        action: SnackBarAction(
          label: 'UNDO',
          onPressed: () {
            setState(() {
              _listedCheckableTodos.insert(taskIndex, task);
            });
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Widget mainContent = const Center(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 40.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              Icons.add_box_outlined,
              size: 50.0, // Increased icon size
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              'No tasks found. Try adding some!!',
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );

    if (_listedCheckableTodos.isNotEmpty) {
      mainContent = TasksList(
        tasks: _listedCheckableTodos,
        onRemoveTask: _removeTask,
      );
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 231, 115, 6),
        title: const Text(
          'To-do app',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
          ),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: mainContent,
            // child: Padding(
            //   padding: const EdgeInsets.all(8.0),
            //   child: ListView(
            //     children: [
            //       for (final task in _listedCheckableTodos)
            //         CheckableTodoTask(
            //           key: ValueKey(task.title), //ObjectKey(todo)
            //           title: task.title,
            //           priority: task.priority,
            //         ),
            //     ],
            //   ),
            // ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showAddTaskSheet,
        child: const Icon(Icons.add),
      ),
    );
  }
}
