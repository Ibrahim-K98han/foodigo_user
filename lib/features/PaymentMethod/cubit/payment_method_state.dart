import 'package:equatable/equatable.dart';
import '../model/payment_method_response_model.dart';

abstract class PaymentState extends Equatable {
  const PaymentState();

  @override
  List<Object?> get props => [];
}

class PaymentInitial extends PaymentState {
  const PaymentInitial();
}

class PaymentLoading extends PaymentState {
  const PaymentLoading();
}

class PaymentLoaded extends PaymentState {
  final PaymentMethodModel payment;

  const PaymentLoaded(this.payment);

  @override
  List<Object?> get props => [payment];
}

class PaymentError extends PaymentState {
  final String message;
  final int statusCode;

  PaymentError(this.message, this.statusCode);

  @override
  List<Object?> get props => [message, statusCode];
}
