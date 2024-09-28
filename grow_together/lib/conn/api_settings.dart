import './api_client.dart';
import './api_client_interface.dart';

class Endpoints {
  const Endpoints();
  final String addEvent = "/events/add";
  final String getEvents = "/events/get_all";
  final String payEvent = "/events/pay";
}

class Urls {
  const Urls();
  final String apiUrl = '';
  final String siteUrl = '';

  String parseQrCode(String sessionId) {
    return '$siteUrl/#/session/$sessionId';
  }
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
