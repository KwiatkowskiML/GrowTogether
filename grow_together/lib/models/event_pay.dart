class EventPay {
  String eventName;
  double eventAmount;

  EventPay({required this.eventName, required this.eventAmount});

  // Convert EventPay object to JSON
  Map<String, dynamic> toJson() => {
    'eventName': eventName,
    'eventAmount': eventAmount,
  };

  // Parse JSON to create an EventPay object
  factory EventPay.fromJson(Map<String, dynamic> json) {
    return EventPay(
      eventName: json['eventName'],
      eventAmount: (json['eventAmount'] as num).toDouble(), // Ensure it's a double
    );
  }
}
