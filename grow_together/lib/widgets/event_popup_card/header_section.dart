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
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            CircleAvatar(
              backgroundColor: Colors.purple,
              child: Text(
                avatarInitial,
                style: TextStyle(color: Colors.white),
              ),
            ),
            SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  eventTitle,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                SizedBox(height: 4),
                Row(
                  children: [
                    Text(
                      eventOwnerName,
                      style: TextStyle(color: Colors.grey[600], fontSize: 14),
                    ),
                    SizedBox(width: 5),
                    Text(
                      eventOwnerEmail,
                      style: TextStyle(color: Colors.grey[600], fontSize: 14),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
        Icon(Icons.more_vert, color: Colors.grey[600]),
      ],
    );
  }
}
