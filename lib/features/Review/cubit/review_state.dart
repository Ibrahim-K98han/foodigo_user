import 'package:equatable/equatable.dart';
import 'package:foodigo/features/Review/model/review_model.dart';

abstract class ReviewState extends Equatable {
  const ReviewState();

  @override
  List<Object?> get props => [];
}

class ReviewInitial extends ReviewState {
  const ReviewInitial();

  @override
  List<Object?> get props => [];
}

class ReviewLoading extends ReviewState {
  const ReviewLoading();

  @override
  List<Object?> get props => [];
}

class ReviewLoaded extends ReviewState {
  final ReviewModel reviewModel;

  const ReviewLoaded(this.reviewModel);

  @override
  List<Object?> get props => [reviewModel];
}

class ReviewSuccess extends ReviewState {
  final ReviewModel reviewModel;

  const ReviewSuccess(this.reviewModel);

  @override
  List<Object?> get props => [reviewModel];
}

class ReviewError extends ReviewState {
  final String message;
  final int statusCode;

  const ReviewError(this.message, this.statusCode);

  @override
  List<Object?> get props => [message, statusCode];
}
