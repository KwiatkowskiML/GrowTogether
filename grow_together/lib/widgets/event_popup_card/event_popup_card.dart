import 'package:flutter/material.dart';
import 'header_section.dart';
import 'goal_progress_section.dart';
import 'benefits_section.dart';
import 'action_buttons_section.dart';

class EventPopupCard extends StatelessWidget {
  final String avatarInitial;
  final String eventTitle;
  final String eventOwnerName;
  final String eventOwnerEmail;
  final String eventDescription;
  final double assembledAmount;
  final double totalGoalAmount;
  final int growersCount;
  final String benefitsText;

  const EventPopupCard({
    super.key,
    required this.avatarInitial,
    required this.eventTitle,
    required this.eventOwnerName,
    required this.eventOwnerEmail,
    required this.eventDescription,
    required this.assembledAmount,
    required this.totalGoalAmount,
    required this.growersCount,
    required this.benefitsText,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      elevation: 5,
      margin: EdgeInsets.all(16.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            HeaderSection(
              avatarInitial: avatarInitial,
              eventTitle: eventTitle,
              eventOwnerName: eventOwnerName,
              eventOwnerEmail: eventOwnerEmail,
            ),
            SizedBox(height: 16),
            Text(
              eventDescription,
              style: TextStyle(fontSize: 14, color: Colors.grey[700]),
            ),
            SizedBox(height: 16),
            GoalProgressSection(
              assembledAmount: assembledAmount,
              totalGoalAmount: totalGoalAmount,
              growersCount: growersCount,
            ),
            SizedBox(height: 16),
            BenefitsSection(benefitsText: benefitsText),
            SizedBox(height: 16),
            Expanded(child: Container()),
            ActionButtonsSection(),
          ],
        ),
      ),
    );
  }
}
