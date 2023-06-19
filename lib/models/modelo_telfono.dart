class telfono {
  final int tutorEmergencyContactId;
  final int tutorId;
  final String nameContact;
  final String phoneContact;

  telfono({
    required this.tutorEmergencyContactId,
    required this.tutorId,
    required this.nameContact,
    required this.phoneContact,
  });

  factory telfono.fromJson(Map<String, dynamic> json) {
    return telfono(
      tutorEmergencyContactId: json['tutorEmergencyContactId'] as int? ?? 0,
      tutorId: json['tutorId'] as int? ?? 0,
      nameContact: json['nameContact'] as String? ?? '',
      phoneContact: json['phoneContact'] as String? ?? '',
    );
  }
}
