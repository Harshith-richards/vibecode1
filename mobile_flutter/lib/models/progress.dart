class ProgressSnapshot {
  final int completedTasks;
  final int totalTasks;
  final int completedWeeks;
  final int totalWeeks;
  final int streak;
  final Duration studyTimeToday;

  const ProgressSnapshot({
    required this.completedTasks,
    required this.totalTasks,
    required this.completedWeeks,
    required this.totalWeeks,
    required this.streak,
    required this.studyTimeToday,
  });

  double get completionRatio => totalTasks == 0 ? 0 : completedTasks / totalTasks;
}
