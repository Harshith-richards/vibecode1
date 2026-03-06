import 'package:flutter/material.dart';

import '../models/task.dart';

class TaskTile extends StatelessWidget {
  const TaskTile({
    super.key,
    required this.task,
    required this.onChanged,
  });

  final Task task;
  final ValueChanged<bool?> onChanged;

  @override
  Widget build(BuildContext context) {
    return CheckboxListTile(
      dense: true,
      value: task.completed,
      onChanged: onChanged,
      activeColor: Colors.tealAccent.shade400,
      checkColor: Colors.black,
      title: Text(
        task.title,
        style: TextStyle(
          color: Colors.white,
          decoration: task.completed ? TextDecoration.lineThrough : null,
          decorationColor: Colors.white70,
        ),
      ),
      controlAffinity: ListTileControlAffinity.leading,
    );
  }
}
