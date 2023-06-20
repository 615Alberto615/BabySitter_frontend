part of 'hability_cubit.dart';

abstract class HabilityState extends Equatable {
  const HabilityState();

  @override
  List<Object> get props => [];
}

class HabilityInitial extends HabilityState {}

class HabilityLoading extends HabilityState {}

class HabilityUpdated extends HabilityState {}

class ActivityLoaded extends HabilityState {
  final hability activity;

  const ActivityLoaded(this.activity);

  @override
  List<Object> get props => [activity];
}

class ActivityError extends HabilityState {
  final String message;

  const ActivityError(this.message);

  @override
  List<Object> get props => [message];
}
