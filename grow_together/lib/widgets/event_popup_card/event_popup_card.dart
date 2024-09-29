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
    // Calculate scaling factor based on screen width
    double screenWidth = MediaQuery.of(context).size.width;
    double scaleFactor = (screenWidth / 375.0).clamp(1.0, 1.5);

    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0 * scaleFactor),
      ),
      elevation: 5,
      margin: EdgeInsets.all(16.0 * scaleFactor),
      child: Padding(
        padding: EdgeInsets.all(16.0 * scaleFactor),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            HeaderSection(
              avatarInitial: avatarInitial,
              eventTitle: eventTitle,
              eventOwnerName: eventOwnerName,
              eventOwnerEmail: eventOwnerEmail,
            ),
            SizedBox(height: 16 * scaleFactor),
            Text(
              eventDescription,
              style: TextStyle(
                fontSize: 14 * scaleFactor,
                color: Colors.grey[700],
              ),
            ),
            SizedBox(height: 16 * scaleFactor),
            GoalProgressSection(
              assembledAmount: assembledAmount,
              totalGoalAmount: totalGoalAmount,
              growersCount: growersCount,
            ),
            SizedBox(height: 16 * scaleFactor),
            BenefitsSection(benefitsText: benefitsText),
            SizedBox(height: 16 * scaleFactor),
            Expanded(child: Container()),
            ActionButtonsSection(eventName: eventTitle),
          ],
        ),
      ),
    );
  }
}
