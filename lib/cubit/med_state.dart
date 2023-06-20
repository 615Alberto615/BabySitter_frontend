part of 'med_cubit.dart';

abstract class MedState extends Equatable {
  const MedState();

  @override
  List<Object?> get props => [];
}

class MedInitial extends MedState {}

class MedLoading extends MedState {}

class MedLoaded extends MedState {
  final MedicalForm medForm;

  const MedLoaded(this.medForm);

  @override
  List<Object?> get props => [medForm];
}

class MedError extends MedState {
  final String message;

  const MedError(this.message);

  @override
  List<Object?> get props => [message];
}
