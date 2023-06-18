import 'dart:convert';

import 'package:front/models/modelo_regla.dart';
import 'package:front/models/modelo_token.dart';
import 'package:http/http.dart' as http;

class ReglasService {
  final String baseUrl;
  String? token = ModeloToken.token;

  ReglasService({this.baseUrl = 'http://10.0.2.2:8080/api/v1/tutorRules'});

  Future<List<Regla>> fetchReglas(int tutorId) async {
    final response =
        await http.get(Uri.parse('$baseUrl/tutor/$tutorId'), headers: {
      "Content-Type": "application/json",
      'Authorization': 'Bearer $token',
    });
    if (response.statusCode == 200) {
      final Map<String, dynamic> responseBody = jsonDecode(response.body);
      final List<dynamic> reglasJson = responseBody['data'];
      return reglasJson.map((json) => Regla.fromJson(json)).toList();
    }
    throw Exception('Error fetching reglas');
  }

  Future<void> addRegla(String regla) async {
    final response = await http.post(
      Uri.parse(baseUrl),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode(<String, String>{
        'regla': regla,
      }),
    );
    if (response.statusCode != 200) {
      throw Exception('Error adding regla');
    }
  }

  Future<void> deleteRegla(int id) async {
    final response = await http.delete(
      Uri.parse('$baseUrl/$id'),
      headers: {
        "Content-Type": "application/json",
        'Authorization': 'Bearer $token',
      },
    );
    if (response.statusCode != 200) {
      throw Exception('Error deleting regla');
    }
  }
}
