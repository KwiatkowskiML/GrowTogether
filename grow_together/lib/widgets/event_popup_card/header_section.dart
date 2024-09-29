import 'package:flutter/material.dart';

class HeaderSection extends StatelessWidget {
  final String avatarInitial;
  final String eventTitle;
  final String eventOwnerName;
  final String eventOwnerEmail;

  const HeaderSection({
    super.key,
    required this.avatarInitial,
    required this.eventTitle,
    required this.eventOwnerName,
    required this.eventOwnerEmail,
  });

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double scaleFactor = (screenWidth / 375.0).clamp(0.3, 1.5);

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            CircleAvatar(
              radius: 20 * scaleFactor, // Adjust radius
              backgroundColor: Colors.purple,
              child: Text(
                avatarInitial,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16 * scaleFactor,
                ),
              ),
            ),
            SizedBox(width: 10 * scaleFactor),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  eventTitle,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18 * scaleFactor,
                  ),
                ),
                SizedBox(height: 4 * scaleFactor),
                Row(
                  children: [
                    Text(
                      eventOwnerName,
                      style: TextStyle(
                        color: Colors.grey[600],
                        fontSize: 14 * scaleFactor,
                      ),
                    ),
                    SizedBox(width: 5 * scaleFactor),
                    Text(
                      eventOwnerEmail,
                      style: TextStyle(
                        color: Colors.grey[600],
                        fontSize: 14 * scaleFactor,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
        Icon(Icons.more_vert, color: Colors.grey[600], size: 24 * scaleFactor),
      ],
    );
  }
}
