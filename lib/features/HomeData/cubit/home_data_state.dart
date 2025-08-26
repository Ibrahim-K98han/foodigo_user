import 'package:foodigo/features/HomeData/home_data_model.dart';


abstract class HomeDataState {}

class HomeDataInitial extends HomeDataState {}

class HomeDataLoading extends HomeDataState {}

class HomeDataLoaded extends HomeDataState {
  final HomeModel data;

  HomeDataLoaded(this.data);
}

class HomeDataError extends HomeDataState {
  final String message;
  final int statusCode;

  HomeDataError(this.message, this.statusCode);
}
