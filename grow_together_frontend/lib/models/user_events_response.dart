import 'package:grow_together/models/event.dart';

class UserEventsResponse {
  final List<Event> userEvents;
  final String result;

  UserEventsResponse({required this.userEvents, required this.result});

  factory UserEventsResponse.fromJson(Map<String, dynamic> json) {
    return UserEventsResponse(
      userEvents: (json['userEvents'] as List<dynamic>)
          .map((e) => Event.fromJson(e as Map<String, dynamic>))
          .toList(),
      result: json['result'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userEvents': userEvents.map((e) => e.toJson()).toList(),
      'result': result,
    };
  }
}