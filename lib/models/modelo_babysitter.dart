class Babysitter {
  final int babysitterId;
  final int seLocationId;
  final String userName;
  final String userLastName;
  final String userEmail;
  final String userAddres;
  final String babysitterCi;
  final String babysitterExtension;
  final String babysitterPhoneContact;
  final String babysitterDescription;
  final bool babysitterVerify;

  Babysitter({
    required this.babysitterId,
    required this.seLocationId,
    required this.userName,
    required this.userLastName,
    required this.userEmail,
    required this.userAddres,
    required this.babysitterCi,
    required this.babysitterExtension,
    required this.babysitterPhoneContact,
    required this.babysitterDescription,
    required this.babysitterVerify,
  });

  factory Babysitter.fromJson(Map<String, dynamic> json) {
    return Babysitter(
      babysitterId: json['babysitterId'] as int? ?? 0,
      seLocationId: json['seLocationId'] as int? ?? 0,
      userName: json['userName'] as String? ?? '',
      userLastName: json['userLastName'] as String? ?? '',
      userEmail: json['userEmail'] as String? ?? '',
      userAddres: json['userAddres'] as String? ?? '',
      babysitterCi: json['babysitterCi'] as String? ?? '',
      babysitterExtension: json['babysitterExtension'] as String? ?? '',
      babysitterPhoneContact: json['babysitterPhoneContact'] as String? ?? '',
      babysitterDescription: json['babysitterDescription'] as String? ?? '',
      babysitterVerify: json['babysitterVerify'] as bool? ?? false,
    );
  }
}
