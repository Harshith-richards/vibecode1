import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../services/progress_service.dart';
import '../widgets/progress_chart.dart';

class HomeDashboardScreen extends StatelessWidget {
  const HomeDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final progress = context.watch<ProgressService>().snapshot;

    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [Color(0xFF0D1B3E), Color(0xFF111827)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: const Color(0xFF1E3A5F)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                '10 Week .NET Developer Roadmap',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.w800),
              ),
              const SizedBox(height: 8),
              Text(
                '${progress.completedWeeks}/${progress.totalWeeks} weeks completed',
                style: const TextStyle(color: Colors.white70),
              ),
              const SizedBox(height: 18),
              LinearProgressIndicator(
                value: progress.completionRatio,
                minHeight: 10,
                borderRadius: BorderRadius.circular(20),
              ),
              const SizedBox(height: 10),
              Text('${(progress.completionRatio * 100).round()}% total progress'),
            ],
          ),
        ),
        const SizedBox(height: 18),
        Row(
          children: [
            Expanded(
              child: _statCard('Tasks Completed', '${progress.completedTasks}/${progress.totalTasks}'),
            ),
            const SizedBox(width: 10),
            Expanded(child: _statCard('Weekly Streak', '${progress.streak} days')),
            const SizedBox(width: 10),
            Expanded(
              child: _statCard('Study Today', '${progress.studyTimeToday.inMinutes} min'),
            ),
          ],
        ),
        const SizedBox(height: 18),
        ProgressChart(
          completed: progress.completedTasks,
          remaining: progress.totalTasks - progress.completedTasks,
        ),
      ],
    );
  }

  Widget _statCard(String title, String value) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFF111827),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: const TextStyle(color: Colors.white70, fontSize: 12)),
          const SizedBox(height: 6),
          Text(value, style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 15)),
        ],
      ),
    );
  }
}
