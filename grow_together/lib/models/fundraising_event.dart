class FundraisingEvent {
  final String eventTitle;
  final String eventOwnerName;
  final String eventOwnerId;
  final String eventGoal;
  final double eventLat;
  final double eventLon;
  final String eventDesc;
  final DateTime? eventStartDate;
  final DateTime? eventEndDate;
  final String eventOwnerContactMail;
  final String eventBenefitDesc;

  FundraisingEvent({
    required this.eventTitle,
    required this.eventOwnerName,
    required this.eventOwnerId,
    required this.eventGoal,
    required this.eventLat,
    required this.eventLon,
    required this.eventDesc,
    required this.eventStartDate,
    required this.eventEndDate,
    required this.eventOwnerContactMail,
    required this.eventBenefitDesc,
  });

  Map<String, dynamic> toMap() {
    return {
      'eventTitle': eventTitle,
      'eventOwnerName': eventOwnerName,
      'eventOwnerId': eventOwnerId,
      'eventGoal': eventGoal,
      'eventLat': eventLat,
      'eventLon': eventLon,
      'eventDesc': eventDesc,
      'eventStartDate': eventStartDate?.toIso8601String(),
      'eventEndDate': eventEndDate?.toIso8601String(),
      'eventOwnerContactMail': eventOwnerContactMail,
      'eventBenefitDesc': eventBenefitDesc,
    };
  }

  @override
  String toString() {
    return 'FundraisingEvent(eventTitle: $eventTitle, eventOwnerName: $eventOwnerName, eventOwnerId: $eventOwnerId, eventGoal: $eventGoal, eventLat: $eventLat, eventLon: $eventLon, eventDesc: $eventDesc, eventStartDate: $eventStartDate, eventEndDate: $eventEndDate, eventOwnerContactMail: $eventOwnerContactMail, eventBenefitDesc: $eventBenefitDesc)';
  }
}
