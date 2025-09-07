import 'package:foodigo/features/Cart/model/cart_model.dart';
import 'package:foodigo/features/PaymentMethod/model/payment_method_response_model.dart';

abstract class PaymentMethodState {
  const PaymentMethodState();
}

class PaymentMethodStateInitial extends PaymentMethodState {
  const PaymentMethodStateInitial();

  List<Object?> get props => [];
}

class PaymentMethodStateLoading extends PaymentMethodState {}

class PaymentMethodStateLoaded extends PaymentMethodState {
  final PaymentMethodResponseModel paymentMethodResponseModel;

  PaymentMethodStateLoaded(this.paymentMethodResponseModel);
}

class PaymentMethodStateError extends PaymentMethodState {
  final String message;
  final int statusCode;

  PaymentMethodStateError(this.message, this.statusCode);
}
