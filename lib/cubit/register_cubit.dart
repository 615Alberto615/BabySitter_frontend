import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

import '../models/modelo_user.dart';
import '../service/UserService.dart';

part 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  final UserService userService;

  RegisterCubit({required this.userService}) : super(RegisterInitial());

  Future<void> createUser(User user) async {
    try {
      emit(RegisterLoading());
      final newUser = await userService.createUser(user);
      emit(RegisterSuccess(newUser as String));
    } catch (e) {
      emit(RegisterFailure(e.toString()));
    }
  }
}
