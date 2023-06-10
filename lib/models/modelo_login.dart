class Login {
  final int userId;
  final int seRoleId;
  final String userEmail;
  final String userSecret;

  Login({
    required this.userId,
    required this.seRoleId,
    required this.userEmail,
    required this.userSecret,
  });

  factory Login.fromJson(Map<String, dynamic> json) {
    return Login(
      userId: json['data']['userId'],
      seRoleId: json['data']['seRoleId'],
      userEmail: json['data']['userEmail'],
      userSecret: json['data']['userSecret'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'seRoleId': seRoleId,
      'userEmail': userEmail,
      'userSecret': userSecret,
    };
  }
}
