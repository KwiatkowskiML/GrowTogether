import 'package:flutter/material.dart';

class GoalProgressSection extends StatelessWidget {
  final double assembledAmount;
  final double totalGoalAmount;
  final int growersCount;

  const GoalProgressSection({
    Key? key,
    required this.assembledAmount,
    required this.totalGoalAmount,
    required this.growersCount,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Goal Progress',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              '$assembledAmount\$ Assembled',
              style: TextStyle(
                color: Colors.green,
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
            ),
            Text(
              '$totalGoalAmount\$ Needed',
              style: TextStyle(
                color: Colors.grey[600],
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
            ),
          ],
        ),
        SizedBox(height: 8),
        LinearProgressIndicator(
          value: assembledAmount / totalGoalAmount,
          backgroundColor: Colors.grey[300],
          color: Colors.purple,
          minHeight: 6,
        ),
        SizedBox(height: 8),
        Text(
          '$growersCount Growers',
          style: TextStyle(
            fontSize: 12,
            color: Colors.grey[600],
          ),
        ),
      ],
    );
  }
}
