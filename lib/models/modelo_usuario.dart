class usuario {
  final String userName;
  final String userLastname;
  final String userEmail;
  final String userPhone;
  final String userAddress;
  final String userSecret;
  final bool userStatus;

  usuario({
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
