part of 'med_cubit.dart';

abstract class MedState extends Equatable {
  const MedState();

  @override
  List<Object> get props => [];
}

class MedInitial extends MedState {}

class MedLoading extends MedState {}

class MedLoaded extends MedState {
  final List<MedicalForm> telefonos;

  const MedLoaded(this.telefonos);

  @override
  List<Object> get props => [telefonos];
}

class MedError extends MedState {
  final String message;

  const MedError(this.message);

  @override
  List<Object> get props => [message];
}
