import 'package:flutter/material.dart';
import 'package:todo_app/models/checkable_todo_task.dart';
import 'package:todo_app/taskslist/todo_task_item.dart';

class TasksList extends StatefulWidget {
  const TasksList({super.key, required this.tasks, required this.onRemoveTask});

  final List<CheckableTodoTask> tasks;
  final void Function(CheckableTodoTask todoTask) onRemoveTask;
  @override
  State<TasksList> createState() => _TasksListState();
}

class _TasksListState extends State<TasksList> {
  String? selectedOption;

  List<CheckableTodoTask> get _orderedTasks {
    final sortedTasks = List.of(widget.tasks);
    if (selectedOption == 'Ascending' || selectedOption == 'Descending') {
      sortedTasks.sort((a, b) {
        final bComesAfterA =
            a.title.toLowerCase().compareTo((b.title.toLowerCase()));
        return selectedOption == 'Ascending' ? bComesAfterA : -bComesAfterA;
      });
    } else if (selectedOption == 'Low Priority') {
      sortedTasks.sort((a, b) => b.priority.index.compareTo(a.priority.index));
    } else if (selectedOption == 'High Priority') {
      sortedTasks.sort((a, b) => a.priority.index.compareTo(b.priority.index));
    }
    return sortedTasks;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        DropdownButton<String>(
          hint: const Text(
            'Sort by',
            style: TextStyle(fontSize: 18),
          ),
          value: selectedOption,
          items: ['Ascending', 'Descending', 'High Priority', 'Low Priority']
              .map((String option) {
            return DropdownMenuItem<String>(
              value: option,
              child: Text(
                option,
                style: const TextStyle(fontSize: 18),
              ),
            );
          }).toList(),
          onChanged: (String? newValue) {
            if (newValue != null) {
              setState(() {
                selectedOption = newValue;
              });
            }
          },
        ),
        Expanded(
          // getter _orderedTasks gets called everytime it is accessed
          child: ListView.builder(
            itemCount: _orderedTasks.length,
            itemBuilder: (ctx, index) => Dismissible(
              background: Container(
                color: const Color.fromARGB(255, 224, 62, 62),
                margin:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              ),
              onDismissed: (direction) {
                widget.onRemoveTask(_orderedTasks[index]);
              },
              key: ValueKey(_orderedTasks[index]),
              child: TodoTaskItem(
                task: _orderedTasks[index],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
