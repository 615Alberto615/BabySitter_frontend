import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:equatable/equatable.dart';
import 'package:front/models/modelo_activiy.dart';
import 'dart:convert';

import 'package:front/service/ApiService_activity.dart';
part 'activity_state.dart';

class ActivityCubit extends Cubit<ActivityState> {
  final ActivityService _activityService;

  ActivityCubit(this._activityService) : super(ActivityInitial());

  Future<void> fetchActivityById(String apiUrl, int id) async {
    emit(ActivityLoading());
    try {
      Activity activity = await _activityService.fetchActivityById(apiUrl, id);
      emit(ActivityLoaded(activity));
    } catch (e) {
      emit(ActivityError('Error loading activity: $e'));
    }
  }

  Future<void> fetchActivityByTutorId(String apiUrl, int id) async {
    emit(ActivityLoading());
    try {
      Activity activity =
          await _activityService.fetchActivityByTutorId(apiUrl, id);
      emit(ActivityLoaded(activity));
    } catch (e) {
      emit(ActivityError('Error loading activity: $e'));
    }
  }

  Future<bool> updateActivity(
      String apiUrl, int id, Map<String, dynamic> requestBody) async {
    emit(ActivityLoading());
    try {
      var response =
          await _activityService.updateActivity(apiUrl, id, requestBody);

      if (response.statusCode == 200) {
        emit(ActivityUpdated());
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
