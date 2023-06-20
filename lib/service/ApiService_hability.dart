import 'dart:convert';

import 'package:front/models/modelo_hability.dart';
import 'package:front/models/modelo_token.dart';
import 'package:http/http.dart' as http;

class HabilityService {
  String? token = ModeloToken.token;

  Future<hability> fetchHabilityById(String apiUrl, int id) async {
    var response = await http.get(
      Uri.parse('$apiUrl$id'),
      headers: {
        "Content-Type": "application/json",
        'Authorization': 'Bearer $token',
      },
    );
    if (response.statusCode == 200) {
      return hability.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load Activity');
    }
  }

  Future<hability> fetchHabilityByTutorId(String apiUrl, int id) async {
    var response = await http.get(
      Uri.parse('$apiUrl/tutor/$id'),
      headers: {
        "Content-Type": "application/json",
        'Authorization': 'Bearer $token',
      },
    );
    if (response.statusCode == 200) {
      return hability.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load Activity');
    }
  }

  Future<http.Response> updateHability(
      String apiUrl, int id, Map<String, dynamic> requestBody) async {
    var body = json.encode(requestBody);
    var response = await http.put(
      Uri.parse('$apiUrl$id'),
      headers: {
        "Content-Type": "application/json",
        'Authorization': 'Bearer $token',
      },
      body: body,
    );
    return response;
  }
}
