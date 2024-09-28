import 'package:flutter/material.dart';

class ActionButtonsSection extends StatelessWidget {
  const ActionButtonsSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        TextButton(
          onPressed: () {
            // Handle Cancel button action
          },
          child: Text('Cancel'),
          style: TextButton.styleFrom(
            foregroundColor: Colors.grey[700],
          ),
        ),
        ElevatedButton(
          onPressed: () {
            // Handle Grow! button action
          },
          child: Text('Grow!'),
          style: ElevatedButton.styleFrom(
            foregroundColor: Colors.white,
            backgroundColor: Colors.purple,
          ),
        ),
      ],
    );
  }
}
