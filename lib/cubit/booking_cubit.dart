import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:front/models/modelo_booking.dart';
import 'package:front/service/ApiSerice_booking.dart';
import 'package:http/http.dart' as http;

part 'booking_state.dart';

class BookingCubit extends Cubit<BookingState> {
  final BookingService _bookingService;

  BookingCubit(this._bookingService) : super(BookingInitial());

  Future<void> fetchBookings(String apiUrl, String tutorId) async {
    emit(BookingLoading());
    try {
      List<Booking> bookings =
          await _bookingService.fetchBookings(apiUrl, tutorId);
      emit(BookingsLoaded(bookings));
    } catch (e) {
      emit(BookingError('Error loading bookings: $e'));
    }
  }

  Future<bool> createBooking(
      String apiUrl, Map<String, dynamic> requestBody) async {
    emit(BookingLoading());
    try {
      var body = json.encode(requestBody);
      var response = await _bookingService.createBooking(apiUrl, requestBody);

      if (response.statusCode == 200) {
        emit(BookingCreated());
        return true;
      } else {
        emit(BookingError('Error creating booking'));
        return false;
      }
    } catch (_) {
      emit(BookingError('Error creating booking'));
      return false;
    }
  }
}
