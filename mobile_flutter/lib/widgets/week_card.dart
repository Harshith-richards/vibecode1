import 'package:flutter/material.dart';

import '../models/week.dart';
import 'day_card.dart';

class WeekCard extends StatelessWidget {
  const WeekCard({
    super.key,
    required this.week,
    required this.onToggleTask,
  });

  final WeekPlan week;
  final Future<void> Function(String taskId, bool value) onToggleTask;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: const Color(0xFF0F172A),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18),
        side: BorderSide(color: Colors.blueGrey.shade700),
      ),
      child: ExpansionTile(
        tilePadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        title: Text(week.title, style: const TextStyle(fontWeight: FontWeight.w700)),
        subtitle: Text(week.subtitle),
        trailing: Text('${(week.completionRatio * 100).round()}%'),
        childrenPadding: const EdgeInsets.fromLTRB(12, 0, 12, 12),
        children: [
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: week.tags
                .map((tag) => Chip(label: Text(tag), backgroundColor: const Color(0xFF1E293B)))
                .toList(),
          ),
          const SizedBox(height: 8),
          ...week.days
              .map((day) => DayCard(day: day, onToggleTask: onToggleTask))
              .toList(),
        ],
      ),
    );
  }
}
