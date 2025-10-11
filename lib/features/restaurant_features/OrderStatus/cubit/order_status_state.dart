// import 'package:equatable/equatable.dart';
// import 'package:foodigo/features/restaurant_features/Order/model/res_order_model.dart';
//
// import '../model/order_status_model.dart';
//
// abstract class OrderStatusState extends Equatable {
//   const OrderStatusState();
//
//   @override
//   List<Object?> get props => [];
// }
//
// class OrderStatusInitial extends OrderStatusState {
//   const OrderStatusInitial();
//
//   @override
//   List<Object?> get props => [];
// }
//
// class OrderStatusLoading extends OrderStatusState {
//   const OrderStatusLoading();
//
//   @override
//   List<Object?> get props => [];
// }
//
// class OrderStatusLoaded extends OrderStatusState {
//   final ResOrderModel resOrderModel;
//
//   const OrderStatusLoaded(this.resOrderModel);
//
//   @override
//   List<Object?> get props => [resOrderModel];
// }
//
// class OrderStatusSuccess extends OrderStatusState {
//   final OrderStatusModel resOrderModel;
//
//   const OrderStatusSuccess(this.resOrderModel);
//
//   @override
//   List<Object?> get props => [resOrderModel];
// }
//
// class OrderStatusError extends OrderStatusState {
//   final String message;
//   final int statusCode;
//
//   const OrderStatusError(this.message, this.statusCode);
//
//   @override
//   List<Object?> get props => [message, statusCode];
// }


import 'package:equatable/equatable.dart';
import '../model/order_status_model.dart';

abstract class OrderStatusState extends Equatable {
  const OrderStatusState();

  @override
  List<Object?> get props => [];
}

class OrderStatusInitial extends OrderStatusState {
  const OrderStatusInitial();
}

class OrderStatusLoading extends OrderStatusState {
  const OrderStatusLoading();
}

class OrderStatusSuccess extends OrderStatusState {
  final OrderStatusModel orderStatusModel;
  final String message;

  const OrderStatusSuccess(this.orderStatusModel, {this.message = ''});

  @override
  List<Object?> get props => [orderStatusModel, message];
}

class OrderStatusError extends OrderStatusState {
  final String message;
  final int statusCode;

  const OrderStatusError(this.message, this.statusCode);

  @override
  List<Object?> get props => [message, statusCode];
}