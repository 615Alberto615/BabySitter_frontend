import 'dart:convert';

import 'package:front/models/modelo_regla.dart';
import 'package:front/models/modelo_token.dart';
import 'package:front/models/modelo_user.dart';
import 'package:front/models/modelo_usuario.dart';
import 'package:http/http.dart' as http;

class UsuarioService {
  String? token = ModeloToken.token;

  Future<List<usuario>> fetchUsuario(String apiUrl, String parentId) async {
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
        if (data['data'] is Map) {
          // Si 'data' es un único objeto de usuario, lo convertimos en un usuario y lo agregamos a una lista
          Map<String, dynamic> jsonUser = data['data'];
          return [usuario.fromJson(jsonUser)];
        } else {
          print('Error: el campo "data" no es un objeto de usuario');
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

  Future<http.Response> updateUsuario(
      String apiUrl, String childId, Map<String, dynamic> requestBody) async {
    var body = json.encode(requestBody);
    var response = await http.put(
      Uri.parse('$apiUrl$childId'),
      headers: {
        "Content-Type": "application/json",
        'Authorization': 'Bearer $token',
      },
      body: body,
    );
    return response;
  }
}
