import 'dart:convert';

class ResponseDto<T> {
  final String? code;
  final T? data;
  final String? message;

  ResponseDto({
    required this.code,
    required this.data,
    required this.message,
  });

  factory ResponseDto.fromJson(String str) =>
      ResponseDto.fromMap(json.decode(utf8.decode(str.runes.toList())));

  factory ResponseDto.fromMap(Map<String, dynamic> json) => ResponseDto(
        code: json["code"],
        data: json["data"],
        message: json["message"],
      );
}
