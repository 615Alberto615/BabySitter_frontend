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
  String medicalAllergieType;
  String medicalMedication;
  String medicalMedicationUbication;

  MedicalForm({
    required this.medicalAllergieType,
    required this.medicalMedication,
    required this.medicalMedicationUbication,
  });

  factory MedicalForm.fromJson(Map<String, dynamic> json) {
    return MedicalForm(
      medicalAllergieType: json['medicalAllergieType'] as String? ?? '',
      medicalMedication: json['medicalMedication'] as String? ?? '',
      medicalMedicationUbication:
          json['medicalMedicationUbication'] as String? ?? '',
    );
  }
}
