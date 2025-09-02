import 'package:equatable/equatable.dart';
import 'package:foodigo/features/HomeData/feature_product_model.dart';
import '../home_data_model.dart';

abstract class HomeDataState extends Equatable {
  const HomeDataState();

  @override
  List<Object?> get props => [];
}

class HomeDataInitial extends HomeDataState {
  const HomeDataInitial();

  @override
  List<Object> get props => [];
}

class HomeDataLoading extends HomeDataState {}

class HomeDataLoaded extends HomeDataState {
  final HomeModel data;

  const HomeDataLoaded(this.data);

  @override
  List<Object?> get props => [data];
}

class SearchDataLoaded extends HomeDataState {
  final FeaturedProducts data;

  const SearchDataLoaded(this.data);

  @override
  List<Object?> get props => [data];
}

class HomeDataError extends HomeDataState {
  final String message;
  final int statusCode;

  const HomeDataError(this.message, this.statusCode);

  @override
  List<Object?> get props => [message, statusCode];
}
