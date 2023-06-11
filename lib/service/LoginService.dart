import 'dart:convert';

import 'package:http/http.dart' as http;

class LoginService {
  Future<Map<String, dynamic>> login(String email, String password) async {
    final url =
        'http://10.0.2.2:8080/api/v1/user/login'; // Reemplaza con la URL de tu API

    print('Request URL: $url');
    print(email);
    print(password);
    final response = await http.post(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/json', // Agrega este encabezado
      },
      body: json.encode({
        'email': email,
        'secret': password,
      }),
    );
    print('Response: ${response.body}');

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      print(jsonData);

      if (jsonData['code'] == 200) {
        return jsonData;
      } else {
        throw Exception(jsonData['message']);
      }
    } else {
      print("Error en la solicitud:");
      throw Exception('Error en la solicitud');
    }
  }
}
