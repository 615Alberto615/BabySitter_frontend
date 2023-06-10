import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:http/http.dart' as http;

import '../models/modelo_child.dart';
import '../service/ApiService_child.dart';

part 'child_state.dart';

class ChildCubit extends Cubit<ChildState> {
  final ChildService _childService;

  ChildCubit(this._childService) : super(ChildInitial());

  Future<void> fetchChildren(String apiUrl, String parentId) async {
    emit(ChildLoading());
    try {
      List<Child> children =
          await _childService.fetchChildren(apiUrl, parentId);
      emit(ChildrenLoaded(children));
    } catch (e) {
      emit(ChildError('Error loading children: $e'));
    }
  }

  Future<bool> createChild(
      String apiUrl, Map<String, dynamic> requestBody) async {
    emit(ChildLoading());
    try {
      var body = json.encode(requestBody);
      var response = await _childService.createChild(apiUrl, requestBody);

      if (response.statusCode == 200) {
        emit(ChildCreated());
        return true;
      } else {
        emit(ChildError('Error creating child'));
        return false;
      }
    } catch (_) {
      emit(ChildError('Error creating child'));
      return false;
    }
  }
}
