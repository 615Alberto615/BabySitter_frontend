class Regla {
  final int id;
  final int tutorId;
  final String regla;

  Regla({required this.id, required this.tutorId, required this.regla});

  factory Regla.fromJson(Map<String, dynamic> json) {
    return Regla(
      id: json['tutorRulesId'],
      tutorId: json['tutor'],
      regla: json['rulesHome'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'tutorRulesId': id,
      'tutor': tutorId,
      'rulesHome': regla,
    };
  }
}
