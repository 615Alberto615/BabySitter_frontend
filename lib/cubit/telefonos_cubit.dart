import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:front/models/modelo_regla.dart';
import 'package:front/models/modelo_telfono.dart';
import 'package:front/service/ApiService_reglas.dart';
import 'package:equatable/equatable.dart';
import 'package:front/service/ApiService_telefonos.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
part 'telefonos_state.dart';

class TelefonoCubit extends Cubit<TelefonoState> {
  final TelefonoService _telefonoservice;
  TelefonoCubit(this._telefonoservice) : super(TelefonoInitial());

  Future<void> fetchTelefono(String apiUrl, String parentId) async {
    emit(TelefonoLoading());
    try {
      List<telfono> telefonos =
          await _telefonoservice.fetchTelefono(apiUrl, parentId);
      emit(TelefonoLoaded(telefonos));
    } catch (e) {
      emit(TelefonoError('Error loading children: $e'));
    }
  }

  Future<bool> createTelefono(
      String apiUrl, Map<String, dynamic> requestBody) async {
    emit(TelefonoLoading());
    try {
      var body = json.encode(requestBody);
      var response = await _telefonoservice.createTelefono(apiUrl, requestBody);

      if (response.statusCode == 200) {
        emit(TelefonoCreated());
        return true;
      } else {
        emit(TelefonoError('Error creating child'));
        return false;
      }
    } catch (_) {
      emit(TelefonoError('Error creating child'));
      return false;
    }
  }

  Future<bool> deleteTelefono(String apiUrl, String tutorId) async {
    emit(TelefonoLoading());
    try {
      var response = await _telefonoservice.deleteTelefono(apiUrl, tutorId);

      if (response.statusCode == 200) {
        emit(TelefonoDeleted());
        return true;
      } else {
        emit(TelefonoError('Error deleting child'));
        return false;
      }
    } catch (_) {
      emit(TelefonoError('Error deleting child'));
      return false;
    }
  }
}
