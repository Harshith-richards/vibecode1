import 'package:flutter/material.dart';

import '../models/day.dart';
import 'task_tile.dart';

class DayCard extends StatelessWidget {
  const DayCard({
    super.key,
    required this.day,
    required this.onToggleTask,
  });

  final DayPlan day;
  final Future<void> Function(String taskId, bool value) onToggleTask;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: const Color(0xFF111B2F),
      margin: const EdgeInsets.only(top: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      child: ExpansionTile(
        title: Text('${day.label} • ${day.title}'),
        subtitle: Text('${day.completedTasks}/${day.tasks.length} tasks done'),
        children: day.tasks
            .map(
              (task) => TaskTile(
                task: task,
                onChanged: (v) => onToggleTask(task.id, v ?? false),
              ),
            )
            .toList(),
      ),
    );
  }
}
