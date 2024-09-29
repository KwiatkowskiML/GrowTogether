import 'package:flutter/material.dart';
import 'package:grow_together/widgets/pay_confirmation_popup.dart';


class ActionButtonsSection extends StatefulWidget {
  final String eventName;

  ActionButtonsSection({
    Key? key,
    required this.eventName,
  }) : super(key: key);

  @override
  _ActionButtonsSectionState createState() => _ActionButtonsSectionState();
}

class _ActionButtonsSectionState extends State<ActionButtonsSection> {
  final TextEditingController _controller = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
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
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: () async {
            _showPayPopUp(context, widget.eventName);
          },
          style: ElevatedButton.styleFrom(
            foregroundColor: Colors.white,
            backgroundColor: Colors.purple,
          ),
          child: const Text('Grow!'),
        ),
      ],
    );
  }

  Future<void> _showPayPopUp(BuildContext context, String eventName) async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: Colors.transparent,
          insetPadding: EdgeInsets.zero,
          child: PayConfirmationPopUp(formKey: _formKey, controller: _controller, eventName: eventName),
        );
      },
    );
  }
}

