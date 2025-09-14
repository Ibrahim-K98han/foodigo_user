// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'package:equatable/equatable.dart';
import 'package:foodigo/features/Cart/model/cart_model.dart';
import '../cubit/add_cart_state.dart';

class AddCartStateModel extends Equatable {
  final int productId;
  final String size; // e.g., "Medium,15"
  final int qty;
  final List<int> addons; // list of addon IDs
  final Map<String, int> addonsQty; // addon ID -> quantity
  final AddCartState addCartState;
  final List<CartItems> cartItems;

  const AddCartStateModel({
    this.productId = 0,
    this.size = '',
    this.qty = 1,
    this.addons = const [],
    this.addonsQty = const {},
    this.addCartState = const AddCartInitial(),
    this.cartItems = const [],
  });

  AddCartStateModel copyWith({
    int? productId,
    String? size,
    int? qty,
    List<int>? addons,
    Map<String, int>? addonsQty,
    AddCartState? addCartState,
    List<CartItems>? cartItems,
  }) {
    return AddCartStateModel(
      productId: productId ?? this.productId,
      size: size ?? this.size,
      qty: qty ?? this.qty,
      addons: addons ?? this.addons,
      addonsQty: addonsQty ?? this.addonsQty,
      addCartState: addCartState ?? this.addCartState,
      cartItems: cartItems ?? this.cartItems,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'product_id': productId,
      'size': size,
      'qty': qty,
      'addons': addons,
      'addons_qty': addonsQty.map((key, value) => MapEntry(key, value)),
      'cart_items': cartItems.map((x) => x.toMap()).toList(),
    };
  }

  factory AddCartStateModel.fromMap(Map<String, dynamic> map) {
    return AddCartStateModel(
      productId: map['product_id'] ?? 0,
      size: map['size'] ?? '',
      qty: map['qty'] ?? 0,
      addons: (map['addons'] as List<dynamic>?)
              ?.map((x) => int.tryParse(x.toString()) ?? 0)
              .toList() ??
          [],
      addonsQty: (map['addons_qty'] != null)
          ? Map<String, int>.from(map['addons_qty'] as Map)
          : {},
      cartItems: (map['cart_items'] as List<dynamic>?)
              ?.map((x) => CartItems.fromMap(x as Map<String, dynamic>))
              .toList() ??
          [],
    );
  }

  String toJson() => json.encode(toMap());

  factory AddCartStateModel.fromJson(String source) =>
      AddCartStateModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  List<Object> get props =>
      [productId, size, qty, addons, addonsQty, addCartState, cartItems];
}
