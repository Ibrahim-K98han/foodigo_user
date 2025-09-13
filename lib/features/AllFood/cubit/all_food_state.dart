import 'package:equatable/equatable.dart';
import 'package:foodigo/features/AllFood/model/all_food_model.dart';

abstract class AllFoodState extends Equatable {
  const AllFoodState();

  @override
  List<Object> get props => [];
}

class AllFoodInitial extends AllFoodState {
  const AllFoodInitial();

  @override
  List<Object> get props => [];
}

class AllFoodLoading extends AllFoodState {}

class AllFoodLoaded extends AllFoodState {
  final List<Foods> allFood;

  const AllFoodLoaded(this.allFood);

  @override
  List<Object> get props => [allFood];
}


class AllFoodMoreLoaded extends AllFoodState {
  final List<Foods> allFood;

  const AllFoodMoreLoaded(this.allFood);

  @override
  List<Object> get props => [allFood];
}

class AllFoodError extends AllFoodState {
  final String message;
  final int statusCode;

  const AllFoodError(this.message, this.statusCode);

  @override
  List<Object> get props => [message, statusCode];
}

/// Get Search Attribute

class GetSearchAttributeStateLoading extends AllFoodState {}

class GetSearchAttributeStateLoaded extends AllFoodState {
  final AllFoodModel allFood;

  const GetSearchAttributeStateLoaded(this.allFood);

  @override
  List<Object> get props => [allFood];
}

class GetSearchAttributeStateError extends AllFoodState {
  final String message;
  final int statusCode;

  const GetSearchAttributeStateError(this.message, this.statusCode);

  @override
  List<Object> get props => [message, statusCode];
}
