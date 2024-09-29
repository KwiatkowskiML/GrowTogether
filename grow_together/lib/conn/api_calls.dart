import 'package:grow_together/models/all_events_response.dart';
import 'package:grow_together/models/command_response.dart';
import 'package:grow_together/models/user_event_pays_response.dart';
import 'package:grow_together/models/user_login.dart';
import 'package:grow_together/models/user_login_response.dart';
import 'package:grow_together/models/user_request.dart';

import '../models/event.dart';
import '../models/event_pay.dart';
import '../models/user_events_response.dart';
import 'api_settings.dart';

const String backendUrl = "";

class ApiCalls {
  static final ApiCalls _instance = ApiCalls._internal();

  factory ApiCalls() {
    return _instance;
  }

  ApiCalls._internal();

  static Future<void> deployEvent(Event event) async {
    try {
      var result = await ApiSettings.client
          .postRequest(ApiSettings.endpoints.addEvent, event.toJson());

      CommandResponse response = CommandResponse.fromJson(result);

      if (response.result != "SUCCESS") {
        throw Exception("Error occurred on backend: ${response.result}");
      }
    } catch (e) {
      throw Exception("Error occurred sending event add request: $e");
    }
  }

  static Future<List<Event>> getEvents() async {
    try {
      var result =
          await ApiSettings.client.getRequest(ApiSettings.endpoints.getEvents);

      AllEventsResponse responseParsed = AllEventsResponse.fromJson(result);

      if (responseParsed.result != "SUCCESS") {
        throw Exception("Error occurred on backend: ${responseParsed.result}");
      }

      return responseParsed.events;
    } catch (e) {
      throw Exception("Error occurred sending event add request: $e");
    }
  }

  static Future<void> payEvent(EventPay eventPay) async {
    try {
      var result = await ApiSettings.client
          .postRequest(ApiSettings.endpoints.payEvent, eventPay.toJson());

      CommandResponse response = CommandResponse.fromJson(result);

      if (response.result != "SUCCESS") {
        throw Exception("Error occurred on backend: ${response.result}");
      }
    } catch (e) {
      throw Exception("Error occurred sending event add request: $e");
    }
  }

  static Future<int> LoginUser(UserLogin login) async {
    try {
      var result = await ApiSettings.client
          .postRequest(ApiSettings.endpoints.login, login.toJson());

      UserLoginResponse response = UserLoginResponse.fromJson(result);

      if (response.result != "SUCCESS") {
        throw Exception("Error occurred on backend: ${response.result}");
      }

      return response.userId;
    } catch (e) {
      throw Exception("Error occurred sending event add request: $e");
    }
  }

  static Future<int> RegisterUser(UserLogin login) async {
    try {
      var result = await ApiSettings.client
          .postRequest(ApiSettings.endpoints.register, login.toJson());

      UserLoginResponse response = UserLoginResponse.fromJson(result);

      if (response.result != "SUCCESS") {
        throw Exception("Error occurred on backend: ${response.result}");
      }

      return response.userId;
    } catch (e) {
      throw Exception("Error occurred sending event add request: $e");
    }
  }

  static Future<List<EventPay>> GetUserPays(UserRequest request) async {
    try {
      var result = await ApiSettings.client
          .postRequest(ApiSettings.endpoints.getUserPays, request.toJson());

      UserEventPaysResponse responseParsed = UserEventPaysResponse.fromJson(result);

      if (responseParsed.result != "SUCCESS") {
        throw Exception("Error occurred on backend: ${responseParsed.result}");
      }

      return responseParsed.userEventPays;
    } catch (e) {
      throw Exception("Error occurred sending event add request: $e");
    }
  }

  static Future<List<Event>> GetUserEvent(UserRequest request) async {
    try {
      var result = await ApiSettings.client
          .postRequest(ApiSettings.endpoints.getUserEvents, request.toJson());

      UserEventsResponse responseParsed = UserEventsResponse.fromJson(result);

      if (responseParsed.result != "SUCCESS") {
        throw Exception("Error occurred on backend: ${responseParsed.result}");
      }

      return responseParsed.userEvents;
    } catch (e) {
      throw Exception("Error occurred sending event add request: $e");
    }
  }
}
