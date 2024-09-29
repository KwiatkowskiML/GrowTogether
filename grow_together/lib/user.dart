import 'package:grow_together/conn/api_calls.dart';
import 'package:grow_together/models/user_login.dart';

class UserSingleton {
  static final UserSingleton _instance = UserSingleton._internal();

  UserSingleton._internal();

  factory UserSingleton() {
    return _instance;
  }

  String? _email;
  int? _token;

  String? get email => _email;

  int? get token => _token;

  Future<void> login_user(
      {required String email, required String password}) async {
    int id = await ApiCalls.LoginUser(
        UserLogin(userMail: email, userPassword: password));

    _email = email;
    _token = id;
  }

  Future<void> register_user(
      {required String email, required String password}) async {
    int id = await ApiCalls.RegisterUser(
        UserLogin(userMail: email, userPassword: password));

    _email = email;
    _token = id;
  }

  void logout() {
    _email = null;
    _token = null;
  }

  bool isLogged() {
    return _token != null;
  }
}
