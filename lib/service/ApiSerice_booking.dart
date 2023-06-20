import 'dart:convert';
import 'package:front/models/modelo_booking.dart';
import 'package:front/models/modelo_token.dart';
import 'package:http/http.dart' as http;

class BookingService {
  String? token = ModeloToken.token;
  Future<http.Response> createBooking(
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

  Future<List<Booking>> fetchBookings(String apiUrl, String tutorId) async {
    try {
      final response = await http.get(
        Uri.parse('$apiUrl$tutorId'),
        headers: {
          "Content-Type": "application/json",
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        List<dynamic> jsonResponse = data['data'];
        if (jsonResponse != null) {
          return jsonResponse.map((item) => Booking.fromJson(item)).toList();
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

  Future<http.Response> updateBookingStatus(
      String apiUrl, String bookingId, int status) async {
    var requestBody = {'bookingCompleted': status};
    var body = json.encode(requestBody);
    var response = await http.put(
      Uri.parse('$apiUrl$bookingId'),
      headers: {
        "Content-Type": "application/json",
        'Authorization': 'Bearer $token',
      },
      body: body,
    );
    return response;
  }

  Future<http.Response> updateBookingStatus2(
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
