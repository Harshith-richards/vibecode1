import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../services/progress_service.dart';

class AnalyticsScreen extends StatelessWidget {
  const AnalyticsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final service = context.watch<ProgressService>();
    final weekData = service.weeklyCompletion;
    final dayData = service.dailyMockCompletion;
    final snapshot = service.snapshot;

    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        const Text('Weekly Completion', style: TextStyle(fontWeight: FontWeight.w700)),
        SizedBox(
          height: 220,
          child: BarChart(
            BarChartData(
              titlesData: FlTitlesData(
                bottomTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                leftTitles: AxisTitles(sideTitles: SideTitles(showTitles: true, reservedSize: 28)),
                topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
              ),
              barGroups: weekData.entries
                  .map(
                    (e) => BarChartGroupData(
                      x: e.key,
                      barRods: [
                        BarChartRodData(toY: e.value * 100, color: Colors.cyanAccent),
                      ],
                    ),
                  )
                  .toList(),
            ),
          ),
        ),
        const SizedBox(height: 18),
        const Text('Tasks Completed per Day', style: TextStyle(fontWeight: FontWeight.w700)),
        SizedBox(
          height: 220,
          child: LineChart(
            LineChartData(
              titlesData: FlTitlesData(show: false),
              lineBarsData: [
                LineChartBarData(
                  isCurved: true,
                  color: Colors.tealAccent,
                  spots: dayData.entries
                      .map((e) => FlSpot(e.key.toDouble(), e.value.toDouble()))
                      .toList(),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 18),
        Card(
          color: const Color(0xFF111827),
          child: ListTile(
            title: const Text('Study Streak'),
            subtitle: Text('${snapshot.streak} days'),
            trailing: Text('${(snapshot.completionRatio * 100).round()}%'),
          ),
        ),
      ],
    );
  }
}
