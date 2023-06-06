// register_state.dart

part of 'register_cubit.dart';

@immutable
abstract class RegisterState {}

class RegisterInitial extends RegisterState {}

class RegisterLoading extends RegisterState {}

class RegisterSuccess extends RegisterState {
  final String role;

  RegisterSuccess(this.role);
}

class RegisterFailure extends RegisterState {
  final String error;

  RegisterFailure(this.error);
}
