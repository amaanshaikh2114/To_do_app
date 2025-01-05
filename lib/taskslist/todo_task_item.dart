import 'package:flutter/material.dart';
import 'package:todo_app/models/checkable_todo_task.dart';

class TodoTaskItem extends StatefulWidget {
  const TodoTaskItem({
    required this.task,
    super.key,
  });

  final CheckableTodoTask task;

  @override
  State<TodoTaskItem> createState() {
    return _TodoTaskItemState();
  }
}

class _TodoTaskItemState extends State<TodoTaskItem> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: Container(
        decoration: const BoxDecoration(
            color: Color.fromARGB(255, 212, 199, 231),
            borderRadius: BorderRadius.all(Radius.circular(10))),
        height: 54,
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Row(
            children: [
              const SizedBox(
                width: 8,
              ),
              Icon(priorityIcons[widget.task.priority]),
              const SizedBox(
                width: 16,
              ),
              Text(
                widget.task.title,
                style: const TextStyle(fontSize: 16),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
