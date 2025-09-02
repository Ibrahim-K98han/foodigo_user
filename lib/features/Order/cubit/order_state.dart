import 'package:equatable/equatable.dart';
import 'package:foodigo/features/Order/model/order_model.dart';

abstract class OrderState extends Equatable {
  const OrderState();

  @override
  List<Object?> get props => [];
}

class OrderStateInitial extends OrderState {
  const OrderStateInitial();

  @override
  List<Object?> get props => [];
}

class OrderStateLoading extends OrderState {
  const OrderStateLoading();

  @override
  List<Object?> get props => [];
}

class OrderStateLoaded extends OrderState {
  final List<OrderModel> orders;

  const OrderStateLoaded(this.orders);

  @override
  List<Object?> get props => [orders];
}

class OrderStateSuccess extends OrderState {
  final List<OrderModel> orders;

  const OrderStateSuccess(this.orders);

  @override
  List<Object?> get props => [orders];
}

class OrderStateError extends OrderState {
  final String message;
  final int statusCode;

  const OrderStateError(this.message, this.statusCode);

  @override
  List<Object?> get props => [message, statusCode];
}
