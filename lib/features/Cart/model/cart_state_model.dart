// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'package:equatable/equatable.dart';

import '../cubit/cart_state.dart';

class CartStateModel extends Equatable {
  final int qty;
  final CartState cartState;

  const CartStateModel({
    this.qty = 1,
    this.cartState = const CartInitial(),
  });

  CartStateModel copyWith({
    int? qty,
    CartState? cartState,
  }) {
    return CartStateModel(
      qty: qty ?? this.qty,
      cartState: cartState ?? this.cartState,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'qty': qty,
    };
  }

  factory CartStateModel.fromMap(Map<String, dynamic> map) {
    return CartStateModel(
      qty: map['qty'] ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory CartStateModel.fromJson(String source) =>
      CartStateModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  List<Object> get props => [qty, cartState];
}
