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
}
