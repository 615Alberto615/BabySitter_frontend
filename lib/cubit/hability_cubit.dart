import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:equatable/equatable.dart';
import 'package:front/models/modelo_activiy.dart';
import 'package:front/models/modelo_hability.dart';
import 'dart:convert';

import 'package:front/service/ApiService_activity.dart';
import 'package:front/service/ApiService_hability.dart';

part 'hability_state.dart';

class HabilityCubit extends Cubit<HabilityState> {
  final HabilityService _activityService;

  HabilityCubit(this._activityService) : super(HabilityInitial());

  Future<void> fetchActivityById(String apiUrl, int id) async {
    emit(HabilityLoading());
    try {
      hability habilidades =
          await _activityService.fetchHabilityById(apiUrl, id);
      emit(ActivityLoaded(habilidades));
    } catch (e) {
      emit(ActivityError('Error loading activity: $e'));
    }
  }

  Future<void> fetchHabilityByTutorId(String apiUrl, int id) async {
    emit(HabilityLoading());
    try {
      hability activity =
          await _activityService.fetchHabilityByTutorId(apiUrl, id);
      emit(ActivityLoaded(activity));
    } catch (e) {
      emit(ActivityError('Error loading activity: $e'));
    }
  }

  Future<bool> updateHability(
      String apiUrl, int id, Map<String, dynamic> requestBody) async {
    emit(HabilityLoading());
    try {
      var response =
          await _activityService.updateHability(apiUrl, id, requestBody);

      if (response.statusCode == 200) {
        emit(HabilityUpdated());
        return true;
      } else {
        emit(ActivityError('Error updating activity'));
        return false;
      }
    } catch (_) {
      emit(ActivityError('Error updating activity'));
      return false;
    }
  }
}
