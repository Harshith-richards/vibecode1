import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../services/notification_service.dart';
import '../services/progress_service.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key, required this.notificationService});

  final NotificationService notificationService;

  @override
  Widget build(BuildContext context) {
    final progress = context.watch<ProgressService>();

    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        ListTile(
          title: const Text('Daily reminder time'),
          subtitle: Text(
            '${progress.reminderHour.toString().padLeft(2, '0')}:${progress.reminderMinute.toString().padLeft(2, '0')}',
          ),
          trailing: const Icon(Icons.schedule),
          onTap: () async {
            final now = TimeOfDay(
              hour: progress.reminderHour,
              minute: progress.reminderMinute,
            );
            final selected = await showTimePicker(context: context, initialTime: now);
            if (selected == null || !context.mounted) return;
            await context.read<ProgressService>().updateReminder(selected.hour, selected.minute);
            await notificationService.scheduleDailyReminder(
              hour: selected.hour,
              minute: selected.minute,
            );
          },
        ),
      ],
    );
  }
}
