import 'package:foodigo/features/SingleRestaurant/model/single_restaurant_model.dart';

abstract class SingleRestaurantState {}

class SingleRestaurantInitial extends SingleRestaurantState {}

class SingleRestaurantLoading extends SingleRestaurantState {}

class SingleRestaurantLoaded extends SingleRestaurantState {
  final RestaurantDetailsModel restaurantDetailsModel;

  SingleRestaurantLoaded(this.restaurantDetailsModel);
}

class SingleRestaurantError extends SingleRestaurantState {
  final String message;
  final int statusCode;

  SingleRestaurantError(this.message, this.statusCode);
}
