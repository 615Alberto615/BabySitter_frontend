// babysitter_cubit.dart
import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:front/cubit/LocationLoaded.dart';

import '../service/ApiService_babysitter.dart';
import 'babysitter_state.dart';

class BabysitterCubit extends Cubit<BabysitterState> {
  final BabysitterService babysitterService;
  BabysitterCubit(this.babysitterService) : super(BabysitterInitial());

  void getAllBabysitters(String apiUrl) async {
    emit(BabysitterLoading());
    try {
      final babysitters = await babysitterService.getAllBabysitters(apiUrl);
      emit(BabysitterLoaded(babysitters));
    } catch (e) {
      emit(BabysitterError(
          "Couldn't fetch data. Is the device online? Error: $e"));
    }
  }

  void getLocationByTutorId(int id) async {
    emit(BabysitterLoading());
    try {
      final location = await babysitterService.getLocationByTutorId(id);
      emit(LocationLoaded(location));
    } catch (e) {
      emit(BabysitterError(
          "Couldn't fetch data. Is the device online? Error: $e"));
    }
  }
}
