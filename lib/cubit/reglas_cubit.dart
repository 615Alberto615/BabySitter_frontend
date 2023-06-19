import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:front/models/modelo_regla.dart';
import 'package:front/service/ApiService_reglas.dart';
import 'package:equatable/equatable.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
part 'reglas_state.dart';

class ReglasCubit extends Cubit<ReglasState> {
  final ReglasService _reglasservice;

  ReglasCubit(this._reglasservice) : super(ReglasInitial());

  Future<void> fetchReglas(String apiUrl, String parentId) async {
    emit(ReglasLoading());
    try {
      List<Regla> Reglas = await _reglasservice.fetchReglas(apiUrl, parentId);
      emit(ReglasLoaded(Reglas));
    } catch (e) {
      emit(ReglasError('Error loading children: $e'));
    }
  }

  Future<bool> createRegla(
      String apiUrl, Map<String, dynamic> requestBody) async {
    emit(ReglasLoading());
    try {
      var body = json.encode(requestBody);
      var response = await _reglasservice.createRegla(apiUrl, requestBody);

      if (response.statusCode == 200) {
        emit(ReglaCreated());
        return true;
      } else {
        emit(ReglasError('Error creating child'));
        return false;
      }
    } catch (_) {
      emit(ReglasError('Error creating child'));
      return false;
    }
  }

  Future<bool> deleteRegla(String apiUrl, String tutorId) async {
    emit(ReglasLoading());
    try {
      var response = await _reglasservice.deleteRegla(apiUrl, tutorId);

      if (response.statusCode == 200) {
        emit(ReglaDeleted());
        return true;
      } else {
        emit(ReglasError('Error deleting child'));
        return false;
      }
    } catch (_) {
      emit(ReglasError('Error deleting child'));
      return false;
    }
  }
}
