import 'package:foodigo/features/Cart/model/cart_model.dart';

abstract class CartState {
  const CartState();
}

class CartInitial extends CartState {
  const CartInitial();

  List<Object?> get props => [];
}

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

/// Increment product State
class CartIncrementLoading extends CartState {}

class CartIncrementSuccess extends CartState {
  final CartModel updatedCart;

  CartIncrementSuccess(this.updatedCart);
}

class CartIncrementError extends CartState {
  final String message;
  final int statusCode;

  CartIncrementError(this.message, this.statusCode);
}

class CartIncrementLoaded extends CartState {
  final CartModel cartModel;

  CartIncrementLoaded(this.cartModel);
}

/// Decrement product State
class CartDecrementLoading extends CartState {}

class CartDecrementSuccess extends CartState {
  final CartModel updatedCart;

  CartDecrementSuccess(this.updatedCart);
}

class CartDecrementError extends CartState {
  final String message;
  final int statusCode;

  CartDecrementError(this.message, this.statusCode);
}

class CartDecrementLoaded extends CartState {
  final CartModel cartModel;

  CartDecrementLoaded(this.cartModel);
}
