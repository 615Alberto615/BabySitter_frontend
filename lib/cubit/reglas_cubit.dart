import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:front/models/modelo_regla.dart';
import 'package:front/service/ApiService_reglas.dart';
import 'package:equatable/equatable.dart';
part 'reglas_state.dart';

class ReglasCubit extends Cubit<ReglasState> {
  final ReglasService _service;

  ReglasCubit(this._service) : super(ReglasInitial());

  Future<void> fetchReglas(int tutorId) async {
    emit(ReglasLoading());
    try {
      final reglas = await _service.fetchReglas(tutorId);
      emit(ReglasLoaded(reglas));
    } catch (e) {
      emit(ReglasError(e.toString()));
    }
  }

  Future<void> addRegla(String regla) async {
    try {
      await _service.addRegla(regla);
    } catch (e) {
      emit(ReglasError(e.toString()));
    }
  }
/*
  Future<void> deleteRegla(int id) async {
    try {
      await _service.deleteRegla(id);
      fetchReglas();
    } catch (e) {
      emit(ReglasError(e.toString()));
    }
  }*/
}
