part of 'hability_cubit.dart';

abstract class HabilityState extends Equatable {
  const HabilityState();

  @override
  List<Object> get props => [];
}

class HabilityInitial extends HabilityState {}

class HabilityLoading extends HabilityState {}

class HabilityUpdated extends HabilityState {}

class HabilityLoaded extends HabilityState {
  final hability activity;

  const HabilityLoaded(this.activity);

  @override
  List<Object> get props => [activity];
}

class HabilityError extends HabilityState {
  final String message;

  const HabilityError(this.message);

  @override
  List<Object> get props => [message];
}
