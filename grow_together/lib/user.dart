import 'dart:async';
import 'package:grow_together/conn/api_calls.dart';
import 'package:grow_together/models/user_login.dart';

class UserSingleton {
  static final UserSingleton _instance = UserSingleton._internal();

  UserSingleton._internal() {
    _loginStatusController = StreamController<bool>.broadcast();
    _loginStatusController.add(false);
  }

  factory UserSingleton() {
    return _instance;
  }

  String? _email;
  int? _token;
  late StreamController<bool> _loginStatusController;

  String? get email => _email;
  int? get token => _token;
  Stream<bool> get loginStream => _loginStatusController.stream;

  Future<void> login_user({required String email, required String password}) async {
    try {
      int id = await ApiCalls.LoginUser(
          UserLogin(userMail: email, userPassword: password));

      _email = email;
      _token = id;
      _loginStatusController.add(true);
    } catch (e) {
      // Handle login error
      print('Login failed: $e');
      _loginStatusController.add(false);
    }
  }

  Future<void> register_user({required String email, required String password}) async {
    try {
      int id = await ApiCalls.RegisterUser(
          UserLogin(userMail: email, userPassword: password));

      _email = email;
      _token = id;
      _loginStatusController.add(true);
    } catch (e) {
      // Handle registration error
      print('Registration failed: $e');
      _loginStatusController.add(false);
    }
  }

  void logout() {
    _email = null;
    _token = null;
    _loginStatusController.add(false);
  }

  bool isLogged() {
    return _token != null;
  }

  void dispose() {
    _loginStatusController.close();
  }
}