import 'dart:convert';

import 'package:front/models/modelo_activiy.dart';
import 'package:front/models/modelo_token.dart';
import 'package:http/http.dart' as http;

class ActivityService {
  String? token = ModeloToken.token;

  Future<Activity> fetchActivityById(String apiUrl, int id) async {
    var response = await http.get(
      Uri.parse('$apiUrl$id'),
      headers: {
        "Content-Type": "application/json",
        'Authorization': 'Bearer $token',
      },
    );
    if (response.statusCode == 200) {
      return Activity.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load Activity');
    }
  }

  Future<Activity> fetchActivityByTutorId(String apiUrl, int id) async {
    var response = await http.get(
      Uri.parse('$apiUrl$id'),
      headers: {
        "Content-Type": "application/json",
        'Authorization': 'Bearer $token',
      },
    );
    if (response.statusCode == 200) {
      Map<String, dynamic> jsonResponse = json.decode(response.body);
      if (jsonResponse['data'] != null) {
        return Activity.fromJson(jsonResponse['data']);
      } else {
        throw Exception('Failed to load Activity: No data field in response');
      }
    } else {
      throw Exception('Failed to load Activity');
    }
  }

  Future<http.Response> updateActivity(
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
