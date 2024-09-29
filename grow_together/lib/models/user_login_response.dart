class UserLoginResponse {
  final int userId;
  final String result;

  UserLoginResponse({required this.userId, required this.result});

  factory UserLoginResponse.fromJson(Map<String, dynamic> json) {
    return UserLoginResponse(
      userId: json['userId'] as int,
      result: json['result'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'result': result,
    };
  }
}