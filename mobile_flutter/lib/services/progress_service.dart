import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/progress.dart';
import '../models/week.dart';
import '../utils/roadmap_data.dart';

class ProgressService extends ChangeNotifier {
  static const _prefsKey = 'task_progress_map';
  static const _studyTimeKey = 'study_time_minutes';
  static const _reminderHourKey = 'reminder_hour';
  static const _reminderMinuteKey = 'reminder_minute';

  ProgressService() {
    weeks = buildRoadmapData();
  }

  late List<WeekPlan> weeks;
  int studyTimeMinutes = 90;
  int reminderHour = 19;
  int reminderMinute = 0;

  Future<void> initialize() async {
    await _loadLocalProgress();
    notifyListeners();
  }

  Future<void> _loadLocalProgress() async {
    final prefs = await SharedPreferences.getInstance();
    final raw = prefs.getString(_prefsKey);
    studyTimeMinutes = prefs.getInt(_studyTimeKey) ?? 90;
    reminderHour = prefs.getInt(_reminderHourKey) ?? 19;
    reminderMinute = prefs.getInt(_reminderMinuteKey) ?? 0;

    if (raw == null) return;
    final decoded = Map<String, dynamic>.from(jsonDecode(raw));

    for (final week in weeks) {
      for (final day in week.days) {
        for (final task in day.tasks) {
          task.completed = decoded[task.id] as bool? ?? false;
        }
      }
    }
  }

  Future<void> _saveLocalProgress() async {
    final prefs = await SharedPreferences.getInstance();
    final map = <String, bool>{};

    for (final week in weeks) {
      for (final day in week.days) {
        for (final task in day.tasks) {
          map[task.id] = task.completed;
        }
      }
    }

    await prefs.setString(_prefsKey, jsonEncode(map));
    await prefs.setInt(_studyTimeKey, studyTimeMinutes);
    await prefs.setInt(_reminderHourKey, reminderHour);
    await prefs.setInt(_reminderMinuteKey, reminderMinute);
  }

  Future<void> toggleTask(String taskId, bool value) async {
    for (final week in weeks) {
      for (final day in week.days) {
        for (final task in day.tasks) {
          if (task.id == taskId) {
            task.completed = value;
            await _saveLocalProgress();
            notifyListeners();
            return;
          }
        }
      }
    }
  }

  Future<void> updateReminder(int hour, int minute) async {
    reminderHour = hour;
    reminderMinute = minute;
    await _saveLocalProgress();
    notifyListeners();
  }

  ProgressSnapshot get snapshot {
    final totalTasks = weeks.fold(0, (sum, w) => sum + w.totalTasks);
    final completedTasks = weeks.fold(0, (sum, w) => sum + w.completedTasks);
    final completedWeeks = weeks.where((w) => w.isCompleted).length;

    return ProgressSnapshot(
      completedTasks: completedTasks,
      totalTasks: totalTasks,
      completedWeeks: completedWeeks,
      totalWeeks: weeks.length,
      streak: _calculateStreak(),
      studyTimeToday: Duration(minutes: studyTimeMinutes),
    );
  }

  int _calculateStreak() {
    final ratio = snapshotUnsafeRatio;
    if (ratio == 1) return 10;
    if (ratio > 0.7) return 7;
    if (ratio > 0.3) return 3;
    return 1;
  }

  double get snapshotUnsafeRatio {
    final totalTasks = weeks.fold(0, (sum, w) => sum + w.totalTasks);
    if (totalTasks == 0) return 0;
    final completedTasks = weeks.fold(0, (sum, w) => sum + w.completedTasks);
    return completedTasks / totalTasks;
  }

  Map<int, double> get weeklyCompletion => {
        for (var i = 0; i < weeks.length; i++) i + 1: weeks[i].completionRatio,
      };

  Map<int, int> get dailyMockCompletion {
    final result = <int, int>{};
    var dayIndex = 1;
    for (final week in weeks) {
      for (final day in week.days) {
        result[dayIndex] = day.completedTasks;
        dayIndex++;
      }
    }
    return result;
  }
}
