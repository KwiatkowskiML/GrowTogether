import 'event_pay.dart';

class UserEventPaysResponse {
  final List<EventPay> userEventPays;
  final String result;

  UserEventPaysResponse({required this.userEventPays, required this.result});

  factory UserEventPaysResponse.fromJson(Map<String, dynamic> json) {
    return UserEventPaysResponse(
      userEventPays: (json['userEventPays'] as List<dynamic>)
          .map((e) => EventPay.fromJson(e as Map<String, dynamic>))
          .toList(),
      result: json['result'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userEventPays': userEventPays.map((e) => e.toJson()).toList(),
      'result': result,
    };
  }
}
