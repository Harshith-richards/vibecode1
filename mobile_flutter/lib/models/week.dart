import 'day.dart';

class WeekPlan {
  final String id;
  final String title;
  final String subtitle;
  final String phase;
  final List<String> tags;
  final List<DayPlan> days;

  WeekPlan({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.phase,
    required this.tags,
    required this.days,
  });

  int get totalTasks => days.fold(0, (sum, d) => sum + d.tasks.length);
  int get completedTasks =>
      days.fold(0, (sum, d) => sum + d.tasks.where((t) => t.completed).length);

  double get completionRatio => totalTasks == 0 ? 0 : completedTasks / totalTasks;
  bool get isCompleted => completionRatio == 1;
}
