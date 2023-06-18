part of 'reglas_cubit.dart';

abstract class ReglasState extends Equatable {
  const ReglasState();

  @override
  List<Object> get props => [];
}

class ReglasInitial extends ReglasState {}

class ReglasLoading extends ReglasState {}

class ReglasLoaded extends ReglasState {
  final List<Regla> reglas;

  const ReglasLoaded(this.reglas);

  @override
  List<Object> get props => [reglas];
}

class ReglasError extends ReglasState {
  final String message;

  const ReglasError(this.message);

  @override
  List<Object> get props => [message];
}
