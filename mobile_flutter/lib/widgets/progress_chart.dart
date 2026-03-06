import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class ProgressChart extends StatelessWidget {
  const ProgressChart({
    super.key,
    required this.completed,
    required this.remaining,
  });

  final int completed;
  final int remaining;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 220,
      child: PieChart(
        PieChartData(
          sectionsSpace: 2,
          centerSpaceRadius: 42,
          sections: [
            PieChartSectionData(
              value: completed.toDouble(),
              color: Colors.tealAccent.shade400,
              title: 'Done\n$completed',
              titleStyle: const TextStyle(color: Colors.black, fontSize: 12),
            ),
            PieChartSectionData(
              value: remaining.toDouble(),
              color: Colors.blueGrey.shade700,
              title: 'Left\n$remaining',
              titleStyle: const TextStyle(color: Colors.white, fontSize: 12),
            ),
          ],
        ),
      ),
    );
  }
}
