class Regla {
  final int tutorRulesId;
  final int tutor;
  final String rulesHome;

  Regla({
    required this.tutorRulesId,
    required this.tutor,
    required this.rulesHome,
  });

  factory Regla.fromJson(Map<String, dynamic> json) {
    return Regla(
      tutorRulesId: json['tutorRulesId'] as int? ?? 0,
      tutor: json['tutor'] as int? ?? 0,
      rulesHome: json['rulesHome'] as String? ?? '',
    );
  }
}
