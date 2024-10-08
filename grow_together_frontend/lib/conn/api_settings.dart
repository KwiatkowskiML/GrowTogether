import './api_client.dart';
import './api_client_interface.dart';

class Endpoints {
  const Endpoints();

  final String addEvent = "/events/add";
  final String getEvents = "/events/get_all";
  final String payEvent = "/events/pay";
  final String register = "/users/register";
  final String login = "/users/login";
  final String getUserEvents = "/users/get_events";
  final String getUserPays = "/users/get_pays";
}

class Urls {
  const Urls();

  final String apiUrl =
      'https://grow-backend-1049102182349.europe-west1.run.app';
  final String siteUrl = '';
}

class Requests {
  const Requests();

  final Map<String, String> defaultHeaders = const {
    'Content-Type': 'application/json',
  };
}

class ApiSettings {
  static const Endpoints endpoints = Endpoints();
  static const Urls urls = Urls();
  static const Requests requests = Requests();

  static IApiClient client = ApiClient(urls.apiUrl);
}
