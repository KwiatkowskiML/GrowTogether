import 'package:flutter/material.dart';
import 'package:grow_together/widgets/pay_confirmation_popup.dart';

class ActionButtonsSection extends StatefulWidget {
  final String eventName;
  final Function? payCallback;

  ActionButtonsSection({
    Key? key,
    required this.eventName,
    this.payCallback,
  }) : super(key: key);

  @override
  _ActionButtonsSectionState createState() => _ActionButtonsSectionState();
}

class _ActionButtonsSectionState extends State<ActionButtonsSection> {
  final TextEditingController _controller = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double scaleFactor = (screenWidth / 375.0).clamp(0.3, 1.5);

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          style: TextButton.styleFrom(
            foregroundColor: Colors.grey[700],
          ),
          child: Text(
            'Cancel',
            style: TextStyle(fontSize: 14 * scaleFactor),
          ),
        ),
        ElevatedButton(
          onPressed: () async {
            _showPayPopUp(context, widget.eventName, widget.payCallback);
          },
          style: ElevatedButton.styleFrom(
            foregroundColor: Colors.white,
            backgroundColor: Colors.purple,
          ),
          child: Text(
            'Grow!',
            style: TextStyle(fontSize: 14 * scaleFactor),
          ),
        ),
      ],
    );
  }

  Future<void> _showPayPopUp(
      BuildContext context, String eventName, Function? payCallback) async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: Colors.transparent,
          insetPadding: EdgeInsets.zero,
          child: PayConfirmationPopUp(
            onPay: payCallback,
            formKey: _formKey,
            controller: _controller,
            eventName: eventName,
          ),
        );
      },
    );
  }
}
