import 'package:equatable/equatable.dart';
import 'package:foodigo/features/SingleRestaurant/model/single_restaurant_model.dart';
import 'package:foodigo/features/restaurant_features/Products/model/product_model.dart';
import 'package:meta/meta.dart';
import 'package:foodigo/features/add_to_cart/model/add_cart_response_model.dart';
import 'package:foodigo/features/restaurant_features/StoreProduct/model/store_product_response_model.dart';
import '../../../../data/errors/errors_model.dart';
import '../model/edit_product_model.dart';

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

class StoreProductLoading extends StoreProductState {
  const StoreProductLoading();
}

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

class StoreProductSuccess extends StoreProductState {
  // final StoreProductResponseModel response;
  final String message;
  const StoreProductSuccess(this.message);

  @override
  List<Object> get props => [message];
}

class StoreProductFormValidate extends StoreProductState {
  final Errors errors;

  const StoreProductFormValidate(this.errors);

  @override
  List<Object?> get props => [errors];
}

///Get Edit Product

class EditProductInitial extends StoreProductState {
  const EditProductInitial();
}

class EditProductLoading extends StoreProductState {}

class EditProductLoaded extends StoreProductState {
  final ProductData response;

  const EditProductLoaded(this.response);

  @override
  List<Object?> get props => [response];
}

class EditProductError extends StoreProductState {
  final String message;
  final int statusCode;

  const EditProductError(this.message, this.statusCode);

  @override
  List<Object?> get props => [message, statusCode];
}

class EditProductSuccess extends StoreProductState {
  // final Products response;
  final String message;

  const EditProductSuccess(this.message);

  @override
  List<Object> get props => [message];
}

class EditProductFormValidate extends StoreProductState {
  final Errors errors;

  const EditProductFormValidate(this.errors);

  @override
  List<Object?> get props => [errors];
}

///Store Product Update

class StoreProductUpdateInitial extends StoreProductState {
  const StoreProductUpdateInitial();
}

class StoreProductUpdateLoading extends StoreProductState {}

class StoreProductUpdateLoaded extends StoreProductState {
  final StoreProductResponseModel response;

  const StoreProductUpdateLoaded(this.response);

  @override
  List<Object?> get props => [response];
}

class StoreProductUpdateError extends StoreProductState {
  final String message;
  final int statusCode;

  const StoreProductUpdateError(this.message, this.statusCode);

  @override
  List<Object?> get props => [message, statusCode];
}

class StoreProductUpdateFormValidate extends StoreProductState {
  final Errors errors;

  const StoreProductUpdateFormValidate(this.errors);

  @override
  List<Object?> get props => [errors];
}

class StoreProductUpdateSuccess extends StoreProductState {
  final StoreProductResponseModel response;

  const StoreProductUpdateSuccess(this.response);

  @override
  List<Object> get props => [response];
}

/// ---------- Delete Store Product ----------

class DeleteStoreProductLoading extends StoreProductState {}

class DeleteStoreProError extends StoreProductState {
  final String message;
  final int statusCode;

  const DeleteStoreProError(this.message, this.statusCode);

  @override
  List<Object?> get props => [message, statusCode];
}

class CartDeleteSuccess extends StoreProductState {
  final StoreProductResponseModel response;

  const CartDeleteSuccess(this.response);

  @override
  List<Object> get props => [response];
}
