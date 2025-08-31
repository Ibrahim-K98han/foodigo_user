import 'package:foodigo/features/Cart/model/cart_model.dart';

abstract class CartState {}

class CartInitial extends CartState {}

class CartLoading extends CartState {}

class CartLoaded extends CartState {
  final CartModel cartModel;

  CartLoaded(this.cartModel);
}

class CartError extends CartState {
  final String message;
  final int statusCode;

  CartError(this.message, this.statusCode);
}

/// Delete product State
class CartDeleteLoading extends CartState {}

class CartDeleteSuccess extends CartState {
  final CartModel updatedCart;
  CartDeleteSuccess(this.updatedCart);
}

class CartDeleteError extends CartState {
  final String message;
  final int statusCode;
  CartDeleteError(this.message, this.statusCode);
}
