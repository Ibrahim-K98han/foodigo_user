import 'package:equatable/equatable.dart';
import 'package:foodigo/features/add_to_cart/model/add_cart_response_model.dart';

import '../../../data/errors/errors_model.dart';

abstract class AddCartState extends Equatable {
  const AddCartState();
}

class AddCartInitial extends AddCartState {
  const AddCartInitial();

  @override
  List<Object?> get props => [];
}

class AddCartStateLoading extends AddCartState {
  @override
  List<Object?> get props => [];
}

class AddCartStateLoaded extends AddCartState {
  final AddCartResponseModel addCartResponseModel;

  const AddCartStateLoaded({required this.addCartResponseModel});

  @override
  List<Object?> get props => [addCartResponseModel];
}

class AddCartStateError extends AddCartState {
  final String message;
  final int statusCode;

  const AddCartStateError(this.message, this.statusCode);

  @override
  List<Object?> get props => [message, statusCode];
}

class AddCartStateSuccess extends AddCartState {
  final AddCartResponseModel responseModel;

  const AddCartStateSuccess(this.responseModel);

  @override
  List<Object> get props => [responseModel];
}

class AddCartStateFormValidate extends AddCartState {
  final Errors errors;

  const AddCartStateFormValidate(this.errors);

  @override
  List<Object?> get props => [errors];
}

///Update Cart
class UpdateCartStateLoading extends AddCartState {
  @override
  List<Object?> get props => [];
}

class UpdateCartStateFormValidate extends AddCartState {
  final Errors errors;

  const UpdateCartStateFormValidate(this.errors);

  @override
  List<Object?> get props => [errors];
}

class UpdateCartStateError extends AddCartState {
  final String message;
  final int statusCode;

  const UpdateCartStateError(this.message, this.statusCode);

  @override
  List<Object?> get props => [message, statusCode];
}

class UpdateCartStateSuccess extends AddCartState {
  final AddCartResponseModel responseModel;

  const UpdateCartStateSuccess(this.responseModel);

  @override
  List<Object> get props => [responseModel];
}