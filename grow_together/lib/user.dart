class UserSingleton {
  static final UserSingleton _instance = UserSingleton._internal();

  UserSingleton._internal();

  factory UserSingleton() {
    return _instance;
  }

  String? _email;
  String? _token;

  String? get email => _email;

  String? get token => _token;

  Future<void> login_user(
      {required String email, required String password}) async {
    print('Email: $email, Password: $password');
    throw Exception('Login failed');
  }

  Future<void> register_user(
      {required String email, required String password}) async {
    print("Email: $email, Password: $password");
  }

  void logout() {
    _email = null;
    _token = null;
  }

  bool isLogged() {
    return _token != null;
  }
}
