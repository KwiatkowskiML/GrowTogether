import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:grow_together/models/fundraising_event.dart';

class FundraisingEventForm extends StatefulWidget {
  final String eventOwnerId;
  final double eventLat;
  final double eventLon;

  FundraisingEventForm({
    required this.eventOwnerId,
    required this.eventLat,
    required this.eventLon,
  });

  @override
  _FundraisingEventFormState createState() => _FundraisingEventFormState();
}

class _FundraisingEventFormState extends State<FundraisingEventForm> {
  final _formKey = GlobalKey<FormState>();

  // Controllers for each field
  TextEditingController _eventTitleController = TextEditingController();
  TextEditingController _eventOwnerNameController = TextEditingController();
  TextEditingController _eventGoalController = TextEditingController();
  TextEditingController _eventDescController = TextEditingController();
  TextEditingController _eventOwnerContactMailController =
      TextEditingController();
  TextEditingController _eventBenefitDescController = TextEditingController();

  DateTime? _eventStartDate;
  DateTime? _eventEndDate;

  // Function to pick a date using DatePicker
  Future<void> _selectDate(BuildContext context, DateTime? initialDate,
      Function(DateTime) onDateSelected) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: initialDate ?? DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != initialDate) {
      onDateSelected(picked);
    }
  }

  // Function to handle form submission
  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      // Create a new instance of the model with the gathered data
      FundraisingEvent formData = FundraisingEvent(
        eventTitle: _eventTitleController.text,
        eventOwnerName: _eventOwnerNameController.text,
        eventOwnerId: widget.eventOwnerId,
        eventGoal: _eventGoalController.text,
        eventLat: widget.eventLat,
        eventLon: widget.eventLon,
        eventDesc: _eventDescController.text,
        eventStartDate: _eventStartDate,
        eventEndDate: _eventEndDate,
        eventOwnerContactMail: _eventOwnerContactMailController.text,
        eventBenefitDesc: _eventBenefitDescController.text,
      );

      // Call another function with the gathered data
      _sendData(formData);
    }
  }

  // Dummy function to handle form data submission
  void _sendData(FundraisingEvent formData) {
    print('Form submitted with the following data:');
    print(formData.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Create Fundraising Event"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextFormField(
                  controller: _eventTitleController,
                  decoration: InputDecoration(labelText: 'Event Title'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter an event title';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _eventOwnerNameController,
                  decoration: InputDecoration(labelText: 'Event Owner Name'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter the owner\'s name';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _eventGoalController,
                  decoration: InputDecoration(
                      labelText:
                          'Event Goal (e.g. Raise funds for new equipment)'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please describe the event goal';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _eventDescController,
                  decoration: InputDecoration(labelText: 'Event Description'),
                  maxLines: 3,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please provide a description of the event';
                    }
                    return null;
                  },
                ),
                ListTile(
                  title: Text(_eventStartDate == null
                      ? 'Select Event Start Date'
                      : 'Event Start Date: ${DateFormat('yyyy-MM-dd').format(_eventStartDate!)}'),
                  trailing: Icon(Icons.calendar_today),
                  onTap: () => _selectDate(context, _eventStartDate, (date) {
                    setState(() {
                      _eventStartDate = date;
                    });
                  }),
                ),
                ListTile(
                  title: Text(_eventEndDate == null
                      ? 'Select Event End Date'
                      : 'Event End Date: ${DateFormat('yyyy-MM-dd').format(_eventEndDate!)}'),
                  trailing: Icon(Icons.calendar_today),
                  onTap: () => _selectDate(context, _eventEndDate, (date) {
                    setState(() {
                      _eventEndDate = date;
                    });
                  }),
                ),
                TextFormField(
                  controller: _eventOwnerContactMailController,
                  decoration: InputDecoration(labelText: 'Owner Contact Email'),
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please provide a contact email';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _eventBenefitDescController,
                  decoration: InputDecoration(
                      labelText:
                          'Benefit Description (e.g., discounts on services as rewards)'),
                  maxLines: 3,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please describe the benefits for supporters';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 20),
                Align(
                  alignment: Alignment.bottomRight,
                  child: ElevatedButton(
                    onPressed: _submitForm,
                    child: Text('Submit Event'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
