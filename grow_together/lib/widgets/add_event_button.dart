import 'package:flutter/material.dart';

class AddEventButton extends StatelessWidget {
  const AddEventButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 50,
      right: 15,
      left: 15,
      child: Container(
        child: Row(
          children: [
            SizedBox(
                width: 150,
                height: 70,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white, // Background color
                    shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(25), // Rounded corners
                    ),
                  ),
                  child: const Text('Add event'),
                  onPressed: () {
                    // Button press logic here
                  },
                ))
          ],
        ),
      ),
    );
  }
}
