part of 'report_cubit.dart';

abstract class ReportState extends Equatable {
  const ReportState();

  @override
  List<Object> get props => [];
}

class ReportInitial extends ReportState {}

class ReportLoading extends ReportState {}

class ReportCreated extends ReportState {}

class ReportDeleted extends ReportState {}

class ReportLoaded extends ReportState {
  final List<Report> report;

  const ReportLoaded(this.report);

  @override
  List<Object> get props => [report];
}

class ReportError extends ReportState {
  final String message;

  const ReportError(this.message);

  @override
  List<Object> get props => [message];
}

// review_state.dart
class ReviewAverageLoaded extends ReportState {
  final double averageReview;

  ReviewAverageLoaded(this.averageReview);
}
