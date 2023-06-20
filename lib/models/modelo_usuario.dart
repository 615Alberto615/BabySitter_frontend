class usuario {
  final int userId;
  final int seLocationId;
  final String userName;
  final String userLastname;
  final String userEmail;
  final String userPhone;
  final String userAddress;
  final String userSecret;
  final bool userStatus;

  usuario({
    required this.userId,
    required this.seLocationId,
    required this.userName,
    required this.userLastname,
    required this.userEmail,
    required this.userPhone,
    required this.userAddress,
    required this.userSecret,
    required this.userStatus,
  });

  factory usuario.fromJson(Map<String, dynamic> json) {
    return usuario(
      userId: json['userId'] ?? 0,
      seLocationId: json['seLocationId'] ?? 0,
      userName: json['userName'] ?? '',
      userLastname: json['userLastname'] ?? '',
      userEmail: json['userEmail'] ?? '',
      userPhone: json['userPhone'] ?? '',
      userAddress: json['userAddres'] ?? '',
      userSecret: json['userSecret'] ?? '',
      userStatus: json['userStatus'] ?? false,
    );
  }
}
