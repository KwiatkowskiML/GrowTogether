class UserRequest {
  final int userId;

  UserRequest({required this.userId});

  factory UserRequest.fromJson(Map<String, dynamic> json) {
    return UserRequest(
      userId: json['userId'] as int,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
    };
  }
}