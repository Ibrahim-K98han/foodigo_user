import 'package:foodigo/features/HomeData/feature_product_model.dart';

abstract class ProductDetailsState {}

class ProductDetailsInitial extends ProductDetailsState {}

class ProductDetailsLoading extends ProductDetailsState {}

class ProductDetailsLoaded extends ProductDetailsState {
  final FeaturedProducts data;

  ProductDetailsLoaded(this.data);
}

class ProductDetailsError extends ProductDetailsState {
  final String message;
  final int statusCode;

  ProductDetailsError(this.message, this.statusCode);
}
