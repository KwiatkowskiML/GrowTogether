class UserLogin {
  final String userMail;
  final String userPassword;

  UserLogin({required this.userMail, required this.userPassword});

  factory UserLogin.fromJson(Map<String, dynamic> json) {
    return UserLogin(
      userMail: json['userMail'] as String,
      userPassword: json['userPassword'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userMail': userMail,
      'userPassword': userPassword,
    };
  }
}