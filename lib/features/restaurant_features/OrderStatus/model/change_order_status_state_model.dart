// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:foodigo/features/restaurant_features/OrderStatus/cubit/order_status_state.dart';

class ChangeOrderStatusStateModel extends Equatable {
  final String ordertatus;
  final OrderStatusState orderStatusState;
  const ChangeOrderStatusStateModel({
    this.ordertatus = '',
    this.orderStatusState = const OrderStatusInitial(),
  });

  ChangeOrderStatusStateModel copyWith({
    String? ordertatus,
    OrderStatusState? orderStatusState,
  }) {
    return ChangeOrderStatusStateModel(
      ordertatus: ordertatus ?? this.ordertatus,
      orderStatusState: orderStatusState ?? this.orderStatusState,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{'order_satus': ordertatus};
  }

  factory ChangeOrderStatusStateModel.fromMap(Map<String, dynamic> map) {
    return ChangeOrderStatusStateModel(ordertatus: map['order_status'] ?? '');
  }

  String toJson() => json.encode(toMap());

  factory ChangeOrderStatusStateModel.fromJson(String source) =>
      ChangeOrderStatusStateModel.fromMap(
        json.decode(source) as Map<String, dynamic>,
      );

  @override
  bool get stringify => true;

  @override
  List<Object> get props => [ordertatus, orderStatusState];
}
