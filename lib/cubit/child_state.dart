part of 'child_cubit.dart';

abstract class ChildState extends Equatable {
  const ChildState();

  @override
  List<Object> get props => [];
}

class ChildInitial extends ChildState {}

class ChildLoading extends ChildState {}

class ChildCreated extends ChildState {}

class ChildDeleted extends ChildState {}

class ChildUpdated extends ChildState {}

class ChildrenLoaded extends ChildState {
  final List<Child> children;

  ChildrenLoaded(this.children);

  @override
  List<Object> get props => [children];
}

class ChildError extends ChildState {
  final String message;

  const ChildError(this.message);

  @override
  List<Object> get props => [message];
}
