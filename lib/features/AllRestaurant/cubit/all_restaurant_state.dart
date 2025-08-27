import 'package:foodigo/features/HomeData/restaurant_model.dart';

abstract class AllRestaurantState {}

class AllRestaurantInitial extends AllRestaurantState {}

class AllRestaurantLoading extends AllRestaurantState {}

class AllRestaurantLoaded extends AllRestaurantState {
  final List<Restaurants> restaurants;

  AllRestaurantLoaded(this.restaurants);
}

class AllRestaurantError extends AllRestaurantState {
  final String message;
  final int statusCode;

  AllRestaurantError(this.message, this.statusCode);
}
