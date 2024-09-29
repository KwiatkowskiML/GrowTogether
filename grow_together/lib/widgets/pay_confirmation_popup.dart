import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:grow_together/conn/api_calls.dart';
import 'package:grow_together/models/event_pay.dart';

class PayConfirmationPopUp extends StatelessWidget {
  const PayConfirmationPopUp({
    super.key,
    required GlobalKey<FormState> formKey,
    required TextEditingController controller,
    required String eventName
  }) : _formKey = formKey, _controller = controller, _eventName = eventName;

  final GlobalKey<FormState> _formKey;
  final TextEditingController _controller;
  final String _eventName;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width / 4,
      height: 170,
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextFormField(
                  controller: _controller,
                  keyboardType:
                      TextInputType.numberWithOptions(decimal: true),
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(
                        RegExp(r'^\d*\.?\d*$')),
                  ],
                  decoration: InputDecoration(
                    labelText: 'Enter the amount you want to pay:',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter an amount';
                    }
                    if (double.tryParse(value) == null) {
                      return 'Please enter a valid number';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: const Text("Cancel"),
                    ),
                    ElevatedButton(
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          double amount = double.parse(_controller.text);
                          var eventPay = EventPay(
                              eventName: _eventName, eventAmount: amount);
                          try {
                            await ApiCalls.payEvent(eventPay);
                            Navigator.of(context)
                                .pop(); 
                            Navigator.of(context)
                                .pop(); 
                          } catch (e) {
                            print(e);
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                  content: Text('Error occurred: $e')),
                            );
                            Navigator.of(context)
                                .pop(); 
                            Navigator.of(context)
                                .pop(); 
                          }
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: Colors.purple,
                      ),
                      child: const Text("Confirm"),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
