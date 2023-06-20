class Activity {
  final int childActivityId;
  final int tutorId;
  final bool activityTableGames;
  final bool activityArtsAndCrafts;
  final bool activityReadingOfBooks;
  final bool activityCookingAndPastry;
  final bool activityOutdoorActivities;
  final bool activityBlockConstruction;
  final bool activityRolePlays;
  final bool activityMusicAndDance;
  final bool activityExercisesAndYoga;
  final bool activityGardening;
  final bool activityConstructionOfFortresses;
  final bool activityMoviesAndTvShows;
  final bool activityNone;

  Activity({
    required this.childActivityId,
    required this.tutorId,
    required this.activityTableGames,
    required this.activityArtsAndCrafts,
    required this.activityReadingOfBooks,
    required this.activityCookingAndPastry,
    required this.activityOutdoorActivities,
    required this.activityBlockConstruction,
    required this.activityRolePlays,
    required this.activityMusicAndDance,
    required this.activityExercisesAndYoga,
    required this.activityGardening,
    required this.activityConstructionOfFortresses,
    required this.activityMoviesAndTvShows,
    required this.activityNone,
  });

  factory Activity.fromJson(Map<String, dynamic> json) {
    return Activity(
      childActivityId: json['childActivityId'] ?? 0,
      tutorId: json['tutorId'] ?? 0,
      activityTableGames: json['activityTableGames'] ?? false,
      activityArtsAndCrafts: json['activityArtsAndCrafts'] ?? false,
      activityReadingOfBooks: json['activityReadingOfBooks'] ?? false,
      activityCookingAndPastry: json['activityCookingAndPastry'] ?? false,
      activityOutdoorActivities: json['activityOutdoorActivities'] ?? false,
      activityBlockConstruction: json['activityBlockConstruction'] ?? false,
      activityRolePlays: json['activityRolePlays'] ?? false,
      activityMusicAndDance: json['activityMusicAndDance'] ?? false,
      activityExercisesAndYoga: json['activityExercisesAndYoga'] ?? false,
      activityGardening: json['activityGardening'] ?? false,
      activityConstructionOfFortresses:
          json['activityConstructionOfFortresses'] ?? false,
      activityMoviesAndTvShows: json['activityMoviesAndTvShows'] ?? false,
      activityNone: json['activityNone'] ?? false,
    );
  }
}
