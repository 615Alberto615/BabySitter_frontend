part of 'telefonos_cubit.dart';

abstract class TelefonoState extends Equatable {
  const TelefonoState();

  @override
  List<Object> get props => [];
}

class TelefonoInitial extends TelefonoState {}

class TelefonoLoading extends TelefonoState {}

class TelefonoCreated extends TelefonoState {}

class TelefonoDeleted extends TelefonoState {}

class TelefonoLoaded extends TelefonoState {
  final List<telfono> telefonos;

  const TelefonoLoaded(this.telefonos);

  @override
  List<Object> get props => [telefonos];
}

class TelefonoError extends TelefonoState {
  final String message;

  const TelefonoError(this.message);

  @override
  List<Object> get props => [message];
}
