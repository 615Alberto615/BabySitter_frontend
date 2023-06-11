import '../models/modelo_babysitter.dart';

abstract class BabysitterState {}

class BabysitterInitial extends BabysitterState {}

class BabysitterLoading extends BabysitterState {}

class BabysitterLoaded extends BabysitterState {
  final List<Babysitter> babysitters;
  BabysitterLoaded(this.babysitters);
}

class BabysitterError extends BabysitterState {
  final String message;
  BabysitterError(this.message);
}
