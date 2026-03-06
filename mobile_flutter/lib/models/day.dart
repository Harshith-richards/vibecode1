import 'task.dart';

class DayPlan {
  final String id;
  final String label;
  final String title;
  final List<Task> tasks;

  DayPlan({
    required this.id,
    required this.label,
    required this.title,
    required this.tasks,
  });

  double get completionRatio {
    if (tasks.isEmpty) return 0;
    final done = tasks.where((t) => t.completed).length;
    return done / tasks.length;
  }

  int get completedTasks => tasks.where((t) => t.completed).length;
}
