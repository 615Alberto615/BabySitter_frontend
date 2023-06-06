import 'package:http/http.dart' as http;
import 'dart:convert';

import '../models/modelo_user.dart';

class UserService {
  final String baseUrl;

  UserService({required this.baseUrl});

  Future<User> createUser(User user) async {
    final response = await http.post(
      Uri.parse('$baseUrl/api/v1/user/babysitter/'),
      body: json.encode(user.toJson()),
      headers: {"Content-Type": "application/json"},
    );

    if (response.statusCode == 200) {
      return User.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to create user.');
    }
  }
}
