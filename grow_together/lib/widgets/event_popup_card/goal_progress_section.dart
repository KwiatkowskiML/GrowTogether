import 'package:flutter/material.dart';

class GoalProgressSection extends StatefulWidget {
  final double assembledAmount;
  final double totalGoalAmount;
  final int growersCount;

  const GoalProgressSection({
    super.key,
    required this.assembledAmount,
    required this.totalGoalAmount,
    required this.growersCount,
  });

  @override
  _GoalProgressSectionState createState() => _GoalProgressSectionState();
}

class _GoalProgressSectionState extends State<GoalProgressSection>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Color?> _colorAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat(reverse: true);

    _colorAnimation = ColorTween(
      begin: Colors.purple,
      end: Colors.deepPurpleAccent,
    ).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

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
              '${widget.assembledAmount}\$ Assembled',
              style: TextStyle(
                color: Colors.green,
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
            ),
            Text(
              '${widget.totalGoalAmount}\$ Needed',
              style: TextStyle(
                color: Colors.grey[600],
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
            ),
          ],
        ),
        SizedBox(height: 8),
        AnimatedBuilder(
          animation: _controller,
          builder: (context, child) {
            return LinearProgressIndicator(
              value: widget.assembledAmount / widget.totalGoalAmount,
              backgroundColor:
                  Colors.grey[300], // Keeps the background constant
              valueColor: AlwaysStoppedAnimation(_colorAnimation.value),
              minHeight: 6,
            );
          },
        ),
        SizedBox(height: 8),
        Text(
          '${widget.growersCount} Growers',
          style: TextStyle(
            fontSize: 12,
            color: Colors.grey[600],
          ),
        ),
      ],
    );
  }
}
