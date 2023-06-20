class hability {
  final int babysitterAbilityId;
  final int babysitterId;
  final bool abilityKnowledgeChildDevelopment;
  final bool abilityEmpeathyAndPatience;
  final bool abilityEfectiveCommunication;
  final bool abilityOrganizationalSkills;
  final bool abilityFlexibilityAndAdaptability;
  final bool abilityFirstAid;
  final bool abilityCulturalSensitivity;
  final bool abilityConflictsResolution;
  final bool abilityCreativity;
  final bool abilitySpecialNeeds;
  final bool abilityCrefulObservation;
  final bool abilityTasteForTeaching;
  final bool abilityNone;

  hability({
    required this.babysitterAbilityId,
    required this.babysitterId,
    required this.abilityKnowledgeChildDevelopment,
    required this.abilityEmpeathyAndPatience,
    required this.abilityEfectiveCommunication,
    required this.abilityOrganizationalSkills,
    required this.abilityFlexibilityAndAdaptability,
    required this.abilityFirstAid,
    required this.abilityCulturalSensitivity,
    required this.abilityConflictsResolution,
    required this.abilityCreativity,
    required this.abilitySpecialNeeds,
    required this.abilityCrefulObservation,
    required this.abilityTasteForTeaching,
    required this.abilityNone,
  });

  factory hability.fromJson(Map<String, dynamic> json) {
    return hability(
      babysitterAbilityId: json['babysitterAbilityId'] ?? 0,
      babysitterId: json['babysitterId'] ?? 0,
      abilityKnowledgeChildDevelopment:
          json['abilityKnowledgeChildDevelopment'] ?? false,
      abilityEmpeathyAndPatience: json['abilityEmpeathyAndPatience'] ?? false,
      abilityEfectiveCommunication:
          json['abilityEfectiveCommunication'] ?? false,
      abilityOrganizationalSkills: json['abilityOrganizationalSkills'] ?? false,
      abilityFlexibilityAndAdaptability:
          json['abilityFlexibilityAndAdaptability'] ?? false,
      abilityFirstAid: json['abilityFirstAid'] ?? false,
      abilityCulturalSensitivity: json['abilityCulturalSensitivity'] ?? false,
      abilityConflictsResolution: json['abilityConflictsResolution'] ?? false,
      abilityCreativity: json['abilityCreativity'] ?? false,
      abilitySpecialNeeds: json['abilitySpecialNeeds'] ?? false,
      abilityCrefulObservation: json['abilityCrefulObservation'] ?? false,
      abilityTasteForTeaching: json['abilityTasteForTeaching'] ?? false,
      abilityNone: json['abilityNone'] ?? false,
    );
  }
}
