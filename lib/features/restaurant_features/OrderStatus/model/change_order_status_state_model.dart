// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:foodigo/features/restaurant_features/OrderStatus/cubit/order_status_state.dart';

class ChangeOrderStatusStateModel extends Equatable {
  final String orderStatus;
  final OrderStatusState orderStatusState;
  const ChangeOrderStatusStateModel({
    this.orderStatus = '',
    this.orderStatusState = const OrderStatusInitial(),
  });

  ChangeOrderStatusStateModel copyWith({
    String? orderStatus,
    OrderStatusState? orderStatusState,
  }) {
    return ChangeOrderStatusStateModel(
      orderStatus: orderStatus ?? this.orderStatus,
      orderStatusState: orderStatusState ?? this.orderStatusState,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{'order_status': orderStatus};
  }

  factory ChangeOrderStatusStateModel.fromMap(Map<String, dynamic> map) {
    return ChangeOrderStatusStateModel(orderStatus: map['order_status'] ?? '');
  }

  String toJson() => json.encode(toMap());

  factory ChangeOrderStatusStateModel.fromJson(String source) =>
      ChangeOrderStatusStateModel.fromMap(
        json.decode(source) as Map<String, dynamic>,
      );

  @override
  bool get stringify => true;

  @override
  List<Object> get props => [orderStatus, orderStatusState];
}
