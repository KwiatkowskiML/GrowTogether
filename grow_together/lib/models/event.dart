class Event {
  String eventTitle;
  String eventOwnerName;
  int? eventOwnerId; // Nullable
  double eventGoal;
  double eventCurrentMoney;
  int eventContributorsNumber;
  double eventLat;
  double eventLon;
  String eventDesc;
  DateTime eventStartDate;
  DateTime eventEndDate;
  String eventOwnerContactMail;
  String eventBenefitDesc;

  Event({
    required this.eventTitle,
    required this.eventOwnerName,
    this.eventOwnerId,
    required this.eventGoal,
    required this.eventCurrentMoney,
    required this.eventContributorsNumber,
    required this.eventLat,
    required this.eventLon,
    required this.eventDesc,
    required this.eventStartDate,
    required this.eventEndDate,
    required this.eventOwnerContactMail,
    required this.eventBenefitDesc,
  });

  // Convert the Event object to a JSON-compatible map
  Map<String, dynamic> toJson() => {
    'eventTitle': eventTitle,
    'eventOwnerName': eventOwnerName,
    'eventOwnerId': eventOwnerId,
    'eventGoal': eventGoal,
    'eventCurrentMoney': eventCurrentMoney,
    'eventContributorsNumber': eventContributorsNumber,
    'eventLat': eventLat,
    'eventLon': eventLon,
    'eventDesc': eventDesc,
    'eventStartDate': eventStartDate.toIso8601String(), // Convert DateTime to String
    'eventEndDate': eventEndDate.toIso8601String(),     // Convert DateTime to String
    'eventOwnerContactMail': eventOwnerContactMail,
    'eventBenefitDesc': eventBenefitDesc,
  };

  // Parse a JSON map and create an Event object
  factory Event.fromJson(Map<String, dynamic> json) {
    return Event(
      eventTitle: json['eventTitle'],
      eventOwnerName: json['eventOwnerName'],
      eventOwnerId: json['eventOwnerId'], // Nullable, can be null
      eventGoal: (json['eventGoal'] as num).toDouble(), // Ensures conversion to double
      eventCurrentMoney: (json['eventCurrentMoney'] as num).toDouble(), // Ensures conversion to double
      eventContributorsNumber: json['eventContributorsNumber'],
      eventLat: (json['eventLat'] as num).toDouble(), // Ensures conversion to double
      eventLon: (json['eventLon'] as num).toDouble(), // Ensures conversion to double
      eventDesc: json['eventDesc'],
      eventStartDate: DateTime.parse(json['eventStartDate']), // Convert String to DateTime
      eventEndDate: DateTime.parse(json['eventEndDate']),     // Convert String to DateTime
      eventOwnerContactMail: json['eventOwnerContactMail'],
      eventBenefitDesc: json['eventBenefitDesc'],
    );
  }
}
