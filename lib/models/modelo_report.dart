class Report {
  final int tutorId;
  final int babysitterId;
  final String reportBabysitterDeclaration;
  final String reportBabysitterDate;

  Report({
    required this.tutorId,
    required this.babysitterId,
    required this.reportBabysitterDeclaration,
    required this.reportBabysitterDate,
  });

  factory Report.fromJson(Map<String, dynamic> json) {
    return Report(
      tutorId: json['tutorId'] as int? ?? 0,
      babysitterId: json['babysitterId'] as int? ?? 0,
      reportBabysitterDeclaration:
          json['reportBabysitterDeclaration'] as String? ?? '',
      reportBabysitterDate: json['reportBabysitterDate'] as String? ?? '',
    );
  }
}
