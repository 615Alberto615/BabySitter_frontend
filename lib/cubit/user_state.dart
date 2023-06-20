part of 'user_cubit.dart';

abstract class UsuarioState extends Equatable {
  const UsuarioState();

  @override
  List<Object> get props => [];
}

class UsuarioInitial extends UsuarioState {}

class UsuarioLoading extends UsuarioState {}

class UsuarioUpdated extends UsuarioState {}

class UsuarioLoaded extends UsuarioState {
  final List<usuario> usuarios;

  const UsuarioLoaded(this.usuarios);

  @override
  List<Object> get props => [usuarios];
}

class UsuarioError extends UsuarioState {
  final String message;

  const UsuarioError(this.message);

  @override
  List<Object> get props => [message];
}
