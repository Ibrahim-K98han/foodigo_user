import 'package:equatable/equatable.dart';
import 'package:foodigo/data/errors/errors_model.dart';

import '../model/restaurant_profile_model.dart';

abstract class RestaurantProfileState extends Equatable {
  const RestaurantProfileState();

  @override
  List<Object?> get props => [];
}

class RestaurantProfileInitial extends RestaurantProfileState {
  const RestaurantProfileInitial();

  @override
  List<Object?> get props => [];
}

class RestaurantProfileLoading extends RestaurantProfileState {
  const RestaurantProfileLoading();

  @override
  List<Object?> get props => [];
}

class RestaurantProfileLoaded extends RestaurantProfileState {
  final RestaurantProfileModel restaurantProfileModel;

  const RestaurantProfileLoaded(this.restaurantProfileModel);

  @override
  List<Object?> get props => [restaurantProfileModel];
}

class RestaurantProfileSuccess extends RestaurantProfileState {
  final RestaurantProfileModel restaurantProfileModel;

  const RestaurantProfileSuccess(this.restaurantProfileModel);

  @override
  List<Object?> get props => [restaurantProfileModel];
}

class RestaurantProfileError extends RestaurantProfileState {
  final String message;
  final int statusCode;

  const RestaurantProfileError(this.message, this.statusCode);

  @override
  List<Object?> get props => [message, statusCode];
}

class RestaurantProfileValidateStateError extends RestaurantProfileState {
  final Errors errors;

  const RestaurantProfileValidateStateError(this.errors);

  @override
  List<Object> get props => [errors];
}

///Update Profile

class UpdateRestaurantProfileLoading extends RestaurantProfileState {}

class UpdateRestaurantProfileError extends RestaurantProfileState {
  final String message;
  final int statusCode;

  const UpdateRestaurantProfileError(this.message, this.statusCode);

  @override
  List<Object?> get props => [message, statusCode];
}

class UpdateRestaurantProfileLoaded extends RestaurantProfileState {
  final String message;

  const UpdateRestaurantProfileLoaded(this.message);

  @override
  List<Object?> get props => [message];
}
