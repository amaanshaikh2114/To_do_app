import 'package:flutter/material.dart';
import 'package:todo_app/models/checkable_todo_task.dart';
import 'package:todo_app/taskslist/todo_task_item.dart';

// enum SortOption { ascending, descending, highPriority, lowPriority }

class TasksList extends StatelessWidget {
  const TasksList({super.key, required this.tasks, required this.onRemoveTask});

  final List<CheckableTodoTask> tasks;
  final void Function(CheckableTodoTask todoTask) onRemoveTask;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: tasks.length,
      itemBuilder: (ctx, index) => Dismissible(
        background: Container(
          color: const Color.fromARGB(255, 224, 62, 62),
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        ),
        onDismissed: (direction) {
          onRemoveTask(tasks[index]);
        },
        key: ValueKey(tasks[index]),
        child: TodoTaskItem(
          task: tasks[index],
        ),
      ),
    ); // ListView is used for lists of indefinite length
  }
}
