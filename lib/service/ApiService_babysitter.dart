import 'dart:convert';
import 'package:front/models/modelo_token.dart';
import 'package:http/http.dart' as http;

import '../models/LocationDto.dart';
import '../models/modelo_babysitter.dart';

class BabysitterService {
  String? token = ModeloToken.token;
  Future<List<Babysitter>> getAllBabysitters(String apiUrl) async {
    try {
      final response = await http.get(
        Uri.parse(apiUrl),
        headers: {
          "Content-Type": "application/json",
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        List<dynamic> jsonResponse = data['data'];
        if (jsonResponse != null) {
          return jsonResponse.map((item) => Babysitter.fromJson(item)).toList();
        } else {
          print('Error: el campo "data" es null');
          return [];
        }
      } else {
        print(
            'Error: la respuesta del servidor no es 200 OK, es ${response.statusCode}');
        return [];
      }
    } catch (e) {
      print('Error: se produjo una excepción durante la solicitud de red: $e');
      return [];
    }
  }

  Future<LocationDto> getLocationByTutorId(int id) async {
    try {
      final response = await http.get(
        Uri.parse('http://10.0.2.2:8080/api/v1/tutor/location/$id'),
        headers: {
          "Content-Type": "application/json",
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        var data = json.decode(response.body)['data'];
        if (data != null) {
          return LocationDto.fromJson(data);
        } else {
          throw Exception('Error: el campo "data" es null');
        }
      } else {
        throw Exception(
            'Error: la respuesta del servidor no es 200 OK, es ${response.statusCode}');
      }
    } catch (e) {
      throw Exception(
          'Error: se produjo una excepción durante la solicitud de red: $e');
    }
  }
}
