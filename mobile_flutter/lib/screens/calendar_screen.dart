import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';

import '../services/progress_service.dart';

class CalendarScreen extends StatefulWidget {
  const CalendarScreen({super.key});

  @override
  State<CalendarScreen> createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  DateTime selectedDay = DateTime.now();

  @override
  Widget build(BuildContext context) {
    final service = context.watch<ProgressService>();

    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        TableCalendar(
          firstDay: DateTime.utc(2020, 1, 1),
          lastDay: DateTime.utc(2030, 12, 31),
          focusedDay: selectedDay,
          selectedDayPredicate: (day) => isSameDay(day, selectedDay),
          onDaySelected: (selected, _) => setState(() => selectedDay = selected),
          calendarBuilders: CalendarBuilders(
            markerBuilder: (_, day, __) {
              final seed = day.day % 3;
              final color = seed == 0
                  ? Colors.redAccent
                  : seed == 1
                      ? Colors.amber
                      : Colors.greenAccent;
              return Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  width: 8,
                  height: 8,
                  margin: const EdgeInsets.only(bottom: 4),
                  decoration: BoxDecoration(color: color, shape: BoxShape.circle),
                ),
              );
            },
          ),
        ),
        const SizedBox(height: 16),
        Card(
          color: const Color(0xFF111827),
          child: ListTile(
            title: Text('Selected date: ${selectedDay.toLocal().toString().split(' ').first}'),
            subtitle: Text('Total completed tasks: ${service.snapshot.completedTasks}'),
          ),
        ),
      ],
    );
  }
}
