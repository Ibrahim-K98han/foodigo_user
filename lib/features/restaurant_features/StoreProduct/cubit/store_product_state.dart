import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:foodigo/features/add_to_cart/model/add_cart_response_model.dart';
import 'package:foodigo/features/restaurant_features/StoreProduct/model/store_product_response_model.dart';
import '../../../../data/errors/errors_model.dart';

@immutable
abstract class StoreProductState extends Equatable {
  const StoreProductState();

  @override
  List<Object?> get props => [];
}

/// ---------- Product States ----------
class StoreProductInitial extends StoreProductState {
  const StoreProductInitial();
}

class StoreProductLoading extends StoreProductState {}

class StoreProductLoaded extends StoreProductState {
  final StoreProductResponseModel response;

  const StoreProductLoaded(this.response);

  @override
  List<Object?> get props => [response];
}

class StoreProductError extends StoreProductState {
  final String message;
  final int statusCode;

  const StoreProductError(this.message, this.statusCode);

  @override
  List<Object?> get props => [message, statusCode];
}

class StoreProductFormValidate extends StoreProductState {
  final Errors errors;

  const StoreProductFormValidate(this.errors);

  @override
  List<Object?> get props => [errors];
}

/// ---------- Update Cart States ----------
class UpdateCartLoading extends StoreProductState {}

class UpdateCartError extends StoreProductState {
  final String message;
  final int statusCode;

  const UpdateCartError(this.message, this.statusCode);

  @override
  List<Object?> get props => [message, statusCode];
}

class UpdateCartFormValidate extends StoreProductState {
  final Errors errors;

  const UpdateCartFormValidate(this.errors);

  @override
  List<Object?> get props => [errors];
}

class UpdateCartSuccess extends StoreProductState {
  final AddCartResponseModel response;

  const UpdateCartSuccess(this.response);

  @override
  List<Object> get props => [response];
}
