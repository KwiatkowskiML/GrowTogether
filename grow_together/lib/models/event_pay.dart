class EventPay {
  String eventName;
  double eventAmount;
  int userId;

  EventPay(
      {required this.eventName,
      required this.eventAmount,
      required this.userId});

  // Convert EventPay object to JSON
  Map<String, dynamic> toJson() => {
        'eventName': eventName,
        'eventAmount': eventAmount,
        'userId': userId,
      };

  // Parse JSON to create an EventPay object
  factory EventPay.fromJson(Map<String, dynamic> json) {
    return EventPay(
      eventName: json['eventName'],
      eventAmount: (json['eventAmount'] as num).toDouble(),
      // Ensure it's a double
      userId: (json['userId'] as num).toInt(), // Ensure it's an int
    );
  }
}
