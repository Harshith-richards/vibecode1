import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../services/progress_service.dart';
import '../widgets/week_card.dart';

class RoadmapScreen extends StatelessWidget {
  const RoadmapScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final progressService = context.watch<ProgressService>();

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: progressService.weeks.length,
      itemBuilder: (context, index) {
        final week = progressService.weeks[index];
        return Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: WeekCard(
            week: week,
            onToggleTask: progressService.toggleTask,
          ),
        );
      },
    );
  }
}
