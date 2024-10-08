import 'package:flutter/material.dart';
import 'package:grow_together/conn/api_calls.dart';
import 'package:intl/intl.dart';
import 'package:grow_together/models/event.dart';

class EventCreationForm extends StatefulWidget {
  final int? eventOwnerId;
  final double eventLat;
  final double eventLon;
  final VoidCallback? onEventCreated;

  const EventCreationForm({
    super.key,
    required this.eventOwnerId,
    required this.eventLat,
    required this.eventLon,
    this.onEventCreated,
  });

  @override
  _EventCreationFormState createState() => _EventCreationFormState();
}

class _EventCreationFormState extends State<EventCreationForm> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _eventTitleController = TextEditingController();
  final TextEditingController _eventOwnerNameController =
      TextEditingController();
  final TextEditingController _eventGoalController = TextEditingController();
  final TextEditingController _eventDescController = TextEditingController();
  final TextEditingController _eventOwnerContactMailController =
      TextEditingController();
  final TextEditingController _eventBenefitDescController =
      TextEditingController();

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
      Event formData = Event(
        eventTitle: _eventTitleController.text,
        eventOwnerName: _eventOwnerNameController.text,
        eventOwnerId: widget.eventOwnerId,
        eventGoal: double.tryParse(_eventGoalController.text) ?? 0.0,
        eventCurrentMoney: 0.0, // Default to 0
        eventContributionsNumber: 0, // Default to 0
        eventLat: widget.eventLat,
        eventLon: widget.eventLon,
        eventDesc: _eventDescController.text,
        eventStartDate: _eventStartDate ?? DateTime.now(),
        eventEndDate: _eventEndDate ?? DateTime.now(),
        eventOwnerContactMail: _eventOwnerContactMailController.text,
        eventBenefitDesc: _eventBenefitDescController.text,
      );

      _sendData(formData);
    }
  }

  void _sendData(Event formData) async {
    await ApiCalls.deployEvent(formData);

    // Call the onEventCreated callback
    if (widget.onEventCreated != null) {
      widget.onEventCreated!();
    }

    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context) => SuccessScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Create Fundraising Event"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 16),

                // Section for Event Details
                Text(
                  'Event Details',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 16),
                buildAnimatedCard(
                  child: Column(
                    children: [
                      _buildTextField(_eventTitleController, 'Event Title',
                          'Please enter an event title'),
                      SizedBox(height: 16),
                      _buildTextField(_eventOwnerNameController,
                          'Event Owner Name', 'Please enter the owner\'s name'),
                      SizedBox(height: 16),
                      _buildNumberField(_eventGoalController,
                          'Event Goal (e.g., amount to be raised)'),
                      SizedBox(height: 16),
                      _buildMultilineField(_eventDescController,
                          'Event Description', 'Please provide a description'),
                    ],
                  ),
                ),

                SizedBox(height: 24),

                // Date Pickers for Start and End Dates
                Text(
                  'Event Duration',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 16),
                buildAnimatedCard(
                  child: Column(
                    children: [
                      ListTile(
                        title: Text(_eventStartDate == null
                            ? 'Select Event Start Date'
                            : 'Event Start Date: ${DateFormat('yyyy-MM-dd').format(_eventStartDate!)}'),
                        trailing: Icon(Icons.calendar_today),
                        onTap: () =>
                            _selectDate(context, _eventStartDate, (date) {
                          setState(() {
                            _eventStartDate = date;
                          });
                        }),
                      ),
                      Divider(height: 0, thickness: 1),
                      ListTile(
                        title: Text(_eventEndDate == null
                            ? 'Select Event End Date'
                            : 'Event End Date: ${DateFormat('yyyy-MM-dd').format(_eventEndDate!)}'),
                        trailing: Icon(Icons.calendar_today),
                        onTap: () =>
                            _selectDate(context, _eventEndDate, (date) {
                          setState(() {
                            _eventEndDate = date;
                          });
                        }),
                      ),
                    ],
                  ),
                ),

                SizedBox(height: 24),

                // Contact information and benefits description
                Text(
                  'Owner & Contact Information',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 16),
                buildAnimatedCard(
                  child: Column(
                    children: [
                      _buildTextField(
                          _eventOwnerContactMailController,
                          'Owner Contact Email',
                          'Please provide a contact email'),
                      SizedBox(height: 16),
                      _buildMultilineField(
                          _eventBenefitDescController,
                          'Benefit Description',
                          'Please describe the benefits for supporters'),
                    ],
                  ),
                ),

                SizedBox(height: 24),

                // Hero animation for submit button
                Align(
                  alignment: Alignment.center,
                  child: Hero(
                    tag: 'submit-button',
                    child: ElevatedButton(
                      onPressed: _submitForm,
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 32, vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: Text('Submit Event'),
                    ),
                  ),
                ),
                SizedBox(height: 16),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Animated card for modern feel
  Widget buildAnimatedCard({required Widget child}) {
    return AnimatedOpacity(
      opacity: 1.0,
      duration: Duration(milliseconds: 500),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        elevation: 4,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: child,
        ),
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String label,
      String validationMessage) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return validationMessage;
        }
        return null;
      },
    );
  }

  Widget _buildNumberField(TextEditingController controller, String label) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      keyboardType: TextInputType.number,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter a valid number';
        }
        return null;
      },
    );
  }

  Widget _buildMultilineField(TextEditingController controller, String label,
      String validationMessage) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      maxLines: 3,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return validationMessage;
        }
        return null;
      },
    );
  }
}

// Success screen with timeout to navigate back
class SuccessScreen extends StatefulWidget {
  @override
  _SuccessScreenState createState() => _SuccessScreenState();
}

class _SuccessScreenState extends State<SuccessScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 1), () {
      Navigator.of(context).pop();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Hero(
          tag: 'submit-button',
          child: Material(
            type: MaterialType.transparency,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.check_circle,
                  color: Colors.green,
                  size: 100,
                ),
                SizedBox(height: 20),
                Text(
                  'Event Created Successfully!',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
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
