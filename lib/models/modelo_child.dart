class Child {
  final int childId;
  final String tutorId;
  final String childName;
  final String childBirthdate;
  final String childPhoneEmergency;
  final int childGender;
  final String childStatus;

  Child({
    required this.childId,
    required this.tutorId,
    required this.childName,
    required this.childBirthdate,
    required this.childPhoneEmergency,
    required this.childGender,
    required this.childStatus,
  });

  factory Child.fromJson(Map<String, dynamic> json) {
    return Child(
      childId: json['childId'] as int? ?? 0,
      tutorId: json['tutorId'] as String? ?? '',
      childName: json['childName'] as String? ?? '',
      childBirthdate: json['childBirthdate'] as String? ?? '',
      childPhoneEmergency: json['childPhoneEmergency'] as String? ?? '',
      childGender: json['childGender'] as int? ?? 0,
      childStatus: json['childStatus'] as String? ?? '',
    );
  }
}

class MedicalForm {
  String allergieType;
  String medication;
  String medicationUbication;

  MedicalForm({
    required this.allergieType,
    required this.medication,
    required this.medicationUbication,
  });

  factory MedicalForm.fromJson(Map<String, dynamic> json) {
    return MedicalForm(
      allergieType: json['allergieType'],
      medication: json['medication'],
      medicationUbication: json['medicationUbication'],
    );
  }
}
