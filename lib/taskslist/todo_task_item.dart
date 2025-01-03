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
  var _done = false;

  void _setDone(bool? isChecked) {
    setState(() {
      _done = isChecked ?? false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Row(
            children: [
              Checkbox(value: _done, onChanged: _setDone),
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
