class LocationDto {
  final int id;

  LocationDto({required this.id});

  factory LocationDto.fromJson(Map<String, dynamic> json) {
    return LocationDto(
      id: json['seLocationId'],
    );
  }
}
