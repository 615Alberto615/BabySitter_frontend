part of 'review_cubit.dart';

abstract class ReviewState extends Equatable {
  const ReviewState();

  @override
  List<Object> get props => [];
}

class ReviewInitial extends ReviewState {}

class ReviewLoading extends ReviewState {}

class ReviewCreated extends ReviewState {}

class ReviewDeleted extends ReviewState {}

class ReviewLoaded extends ReviewState {
  final List<Review> review;

  const ReviewLoaded(this.review);

  @override
  List<Object> get props => [review];
}

class ReviewError extends ReviewState {
  final String message;

  const ReviewError(this.message);

  @override
  List<Object> get props => [message];
}

// review_state.dart
class ReviewAverageLoaded extends ReviewState {
  final double averageReview;

  ReviewAverageLoaded(this.averageReview);
}
