import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:front/models/modelo_regla.dart';
import 'package:front/models/modelo_user.dart';
import 'package:front/models/modelo_usuario.dart';
import 'package:front/models/modelo_usuario.dart';
import 'package:front/models/modelo_usuario.dart';
import 'package:front/models/modelo_usuario.dart';
import 'package:front/service/ApiService_User.dart';
import 'package:front/service/ApiService_reglas.dart';
import 'package:equatable/equatable.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
part 'user_state.dart';

class UsuarioCubit extends Cubit<UsuarioState> {
  final UsuarioService _reglasservice;

  UsuarioCubit(this._reglasservice) : super(UsuarioInitial());

  Future<void> fetchUsuario(String apiUrl, String parentId) async {
    emit(UsuarioLoading());
    try {
      List<usuario> usuarios =
          await _reglasservice.fetchUsuario(apiUrl, parentId);
      print('Usuarios cargados: $usuarios');
      emit(UsuarioLoaded(usuarios));
    } catch (e) {
      emit(UsuarioError('Error loading children: $e'));
    }
  }

  Future<bool> updateUsuario(
      String apiUrl, String childId, Map<String, dynamic> requestBody) async {
    emit(UsuarioLoading());
    try {
      var response =
          await _reglasservice.updateUsuario(apiUrl, childId, requestBody);

      if (response.statusCode == 200) {
        emit(UsuarioUpdated());
        return true;
      } else {
        emit(UsuarioError('Error updating child'));
        return false;
      }
    } catch (_) {
      emit(UsuarioError('Error updating child'));
      return false;
    }
  }
}
