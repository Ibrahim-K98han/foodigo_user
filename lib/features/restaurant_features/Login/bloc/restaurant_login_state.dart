import 'package:equatable/equatable.dart';
import 'package:foodigo/features/Login/model/user_response_model.dart';
import 'package:foodigo/features/restaurant_features/Login/model/restaurant_login_response_model.dart';

import '../../../../data/errors/errors_model.dart';

abstract class RestaurantLoginState extends Equatable {
  const RestaurantLoginState();
}

class RestaurantLoginStateInitial extends RestaurantLoginState {
  const RestaurantLoginStateInitial();

  @override
  List<Object?> get props => [];
}

class RestaurantLoginStateLoading extends RestaurantLoginState {
  @override
  List<Object?> get props => [];
}

class RestaurantLoginStateLogoutLoading extends RestaurantLoginState {
  @override
  List<Object?> get props => [];
}

class RestaurantLoginStateLogoutLoaded extends RestaurantLoginState {
  final String message;
  final int statusCode;

  const RestaurantLoginStateLogoutLoaded(this.message, this.statusCode);

  @override
  List<Object?> get props => [message, statusCode];
}

class RestaurantLoginStateLogoutError extends RestaurantLoginState {
  final String message;
  final int statusCode;

  const RestaurantLoginStateLogoutError(this.message, this.statusCode);

  @override
  List<Object?> get props => [message, statusCode];
}

class RestaurantLoginStateLoaded extends RestaurantLoginState {
  final RestaurantLoginResponse restaurantLoginResponse;

  const RestaurantLoginStateLoaded({required this.restaurantLoginResponse});

  @override
  List<Object?> get props => [restaurantLoginResponse];
}

class RestaurantLoginStateError extends RestaurantLoginState {
  final String message;
  final int statusCode;

  const RestaurantLoginStateError(
      {required this.message, required this.statusCode});

  @override
  List<Object?> get props => [message, statusCode];
}

class RestaurantLoginStateFormValidate extends RestaurantLoginState {
  final Errors errors;

  const RestaurantLoginStateFormValidate(this.errors);

  @override
  List<Object?> get props => [errors];
}
