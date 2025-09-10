import 'package:equatable/equatable.dart';
import 'package:foodigo/features/checkout/model/checkout_response_model.dart';

import '../../../data/errors/errors_model.dart';

abstract class CheckoutState extends Equatable {
  const CheckoutState();
}

class CheckoutStateInitial extends CheckoutState {
  const CheckoutStateInitial();

  @override
  List<Object?> get props => [];
}

class CheckoutStateLoading extends CheckoutState {
  @override
  List<Object?> get props => [];
}

class CheckoutStateInitialLoaded extends CheckoutState {
  final CheckoutResponseModel checkoutResponseModel;

  const CheckoutStateInitialLoaded({required this.checkoutResponseModel});

  @override
  List<Object?> get props => [checkoutResponseModel];
}

class CheckoutStateError extends CheckoutState {
  final String message;
  final int statusCode;

  const CheckoutStateError(this.message, this.statusCode);

  @override
  List<Object?> get props => [message, statusCode];
}

class CheckoutStateSuccess extends CheckoutState {
  final CheckoutResponseModel checkoutResponseModel;

  const CheckoutStateSuccess(this.checkoutResponseModel);

  @override
  List<Object> get props => [checkoutResponseModel];
}

class CheckoutStateFormValidate extends CheckoutState {
  final Errors errors;

  const CheckoutStateFormValidate(this.errors);

  @override
  List<Object?> get props => [errors];
}
