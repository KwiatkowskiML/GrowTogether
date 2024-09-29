import 'package:grow_together/models/event.dart';

class AllEventsResponse {
  List<Event> events;
  String result;

  AllEventsResponse({required this.events, required this.result});

  // Convert AllEventsResponse object to JSON
  Map<String, dynamic> toJson() => {
    'events': events.map((event) => event.toJson()).toList(), // Convert each EventModel to JSON
    'result': result,
  };

  // Parse JSON to create an AllEventsResponse object
  factory AllEventsResponse.fromJson(Map<String, dynamic> json) {
    var eventList = json['events'] as List;
    List<Event> events = eventList.map((eventJson) => Event.fromJson(eventJson)).toList();

    return AllEventsResponse(
      events: events,
      result: json['result'],
    );
  }
}
