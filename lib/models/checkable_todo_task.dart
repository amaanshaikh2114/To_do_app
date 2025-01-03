import 'package:flutter/material.dart';

enum TaskPriority { urgent, normal, low }

const priorityIcons = {
  TaskPriority.low: Icons.low_priority,
  TaskPriority.normal: Icons.list,
  TaskPriority.urgent: Icons.notifications_active,
};

class CheckableTodoTask extends StatefulWidget {
  const CheckableTodoTask({
    required this.title,
    required this.priority,
    super.key,
  });

  final String title;
  final TaskPriority priority;

  @override
  State<CheckableTodoTask> createState() {
    return _CheckableTodoTaskState();
  }
}

class _CheckableTodoTaskState extends State<CheckableTodoTask> {
  var _done = false;

  void _setDone(bool? isChecked) {
    setState(() {
      _done = isChecked ?? false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Row(
            children: [
              Checkbox(value: _done, onChanged: _setDone),
              const SizedBox(
                width: 8,
              ),
              Icon(priorityIcons[widget.priority]),
              const SizedBox(
                width: 16,
              ),
              Text(widget.title),
            ],
          ),
        ),
      ),
    );
  }
}
