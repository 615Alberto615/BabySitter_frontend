import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:front/models/modelo_child.dart';
import 'package:front/models/modelo_regla.dart';
import 'package:front/models/modelo_telfono.dart';
import 'package:front/service/ApiService_med.dart';
import 'package:front/service/ApiService_reglas.dart';
import 'package:equatable/equatable.dart';
import 'package:front/service/ApiService_telefonos.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
part 'med_state.dart';

class MedCubit extends Cubit<MedState> {
  final MedService _telefonoservice;
  MedCubit(this._telefonoservice) : super(MedInitial());

  Future<void> fetchMed(String apiUrl, String parentId) async {
    emit(MedLoading());
    try {
      MedicalForm medForm = await _telefonoservice.fetchMed(apiUrl, parentId);
      emit(MedLoaded(medForm));
    } catch (e) {
      emit(MedError('Error loading children: $e'));
    }
  }
}
