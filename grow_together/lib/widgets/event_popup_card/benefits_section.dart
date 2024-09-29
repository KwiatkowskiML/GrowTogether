import 'package:flutter/material.dart';

class BenefitsSection extends StatelessWidget {
  final String benefitsText;

  const BenefitsSection({
    super.key,
    required this.benefitsText,
  });

  @override
  Widget build(BuildContext context) {
    // Calculate scaling factor based on screen width
    double screenWidth = MediaQuery.of(context).size.width;
    double scaleFactor = (screenWidth / 375.0).clamp(1.0, 1.5);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Benefits',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16 * scaleFactor,
          ),
        ),
        SizedBox(height: 8 * scaleFactor),
        Text(
          benefitsText,
          style: TextStyle(
            fontSize: 14 * scaleFactor,
            color: Colors.grey[700],
          ),
        ),
      ],
    );
  }
}
