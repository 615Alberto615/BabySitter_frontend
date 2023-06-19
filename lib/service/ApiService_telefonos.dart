import 'dart:convert';

import 'package:front/models/modelo_telfono.dart';
import 'package:front/models/modelo_token.dart';
import 'package:http/http.dart' as http;

class TelefonoService {
  String? token = ModeloToken.token;

  Future<http.Response> createTelefono(
      String apiUrl, Map<String, dynamic> requestBody) async {
    var body = json.encode(requestBody);
    var response = await http.post(
      Uri.parse(apiUrl),
      headers: {
        "Content-Type": "application/json",
        'Authorization': 'Bearer $token',
      },
      body: body,
    );
    return response;
  }

  Future<http.Response> deleteTelefono(String apiUrl, String tutorId) async {
    var response = await http.delete(
      Uri.parse('$apiUrl$tutorId'),
      headers: {
        "Content-Type": "application/json",
        'Authorization': 'Bearer $token',
      },
    );
    return response;
  }

  Future<List<telfono>> fetchTelefono(String apiUrl, String parentId) async {
    try {
      final response = await http.get(
        Uri.parse('$apiUrl$parentId'),
        headers: {
          "Content-Type": "application/json",
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        // Si el servidor devuelve una respuesta OK, entonces parseamos el JSON.
        var data = json.decode(response.body);
        List<dynamic> jsonResponse =
            data['data']; // 'data' es la clave de la lista en la respuesta
        if (jsonResponse != null) {
          return jsonResponse.map((item) => telfono.fromJson(item)).toList();
        } else {
          // manejar la situación cuando 'data' es null
          print('Error: el campo "data" es null');
          return [];
        }
      } else {
        // Si la respuesta no es OK, lanzamos un error.
        print(
            'Error: la respuesta del servidor no es 200 OK, es ${response.statusCode}');
        return [];
      }
    } catch (e) {
      // manejar cualquier excepción lanzada durante la solicitud de red
      print('Error: se produjo una excepción durante la solicitud de red: $e');
      return [];
    }
  }
}
