import 'dart:convert';

import 'package:front/models/modelo_child.dart';
import 'package:front/models/modelo_telfono.dart';
import 'package:front/models/modelo_token.dart';
import 'package:http/http.dart' as http;

class MedService {
  String? token = ModeloToken.token;

  Future<MedicalForm> fetchMed(String apiUrl, String parentId) async {
    try {
      final response = await http.get(
        Uri.parse('$apiUrl$parentId'),
        headers: {
          "Content-Type": "application/json",
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        Map<String, dynamic> jsonResponse = data['data'];
        if (jsonResponse != null) {
          return MedicalForm.fromJson(jsonResponse);
        } else {
          print('Error: el campo "data" es null');
          throw Exception('El campo "data" es null');
        }
      } else {
        print(
            'Error: la respuesta del servidor no es 200 OK, es ${response.statusCode}');
        throw Exception('Respuesta del servidor: ${response.statusCode}');
      }
    } catch (e) {
      print('Error: se produjo una excepción durante la solicitud de red: $e');
      throw Exception('Excepción durante la solicitud de red');
    }
  }
}
