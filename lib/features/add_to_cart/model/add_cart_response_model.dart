// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'package:equatable/equatable.dart';
import '../../Cart/model/cart_model.dart';

class AddCartResponseModel extends Equatable {
  final CartItem? cartItem;
  final CartSummary? cartSummary;
  final String message;

  const AddCartResponseModel({
    this.cartItem,
    this.cartSummary,
    this.message = '',
  });

  AddCartResponseModel copyWith({
    CartItem? cartItem,
    CartSummary? cartSummary,
    String? message,
  }) {
    return AddCartResponseModel(
      cartItem: cartItem ?? this.cartItem,
      cartSummary: cartSummary ?? this.cartSummary,
      message: message ?? this.message,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'cart_item': cartItem?.toMap(),
      'cart_summary': cartSummary?.toMap(),
      'message': message,
    };
  }

  factory AddCartResponseModel.fromMap(Map<String, dynamic> map) {
    return AddCartResponseModel(
      cartItem: map['data']?['cart_item'] != null
          ? CartItem.fromMap(map['data']['cart_item'] as Map<String, dynamic>)
          : null,
      cartSummary: map['data']?['cart_summary'] != null
          ? CartSummary.fromMap(
          map['data']['cart_summary'] as Map<String, dynamic>)
          : null,
      message: map['message'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory AddCartResponseModel.fromJson(String source) =>
      AddCartResponseModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  List<Object?> get props => [cartItem, cartSummary, message];
}

class CartItem extends Equatable {
  final int id;
  final int productId;
  final String size;
  final int qty;
  final String totalPrice;
  final Product? product;

  const CartItem({
    required this.id,
    required this.productId,
    required this.size,
    required this.qty,
    required this.totalPrice,
    this.product,
  });

  CartItem copyWith({
    int? id,
    int? productId,
    String? size,
    int? qty,
    String? totalPrice,
    Product? product,
  }) {
    return CartItem(
      id: id ?? this.id,
      productId: productId ?? this.productId,
      size: size ?? this.size,
      qty: qty ?? this.qty,
      totalPrice: totalPrice ?? this.totalPrice,
      product: product ?? this.product,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'product_id': productId,
      'size': size,
      'qty': qty,
      'total_Price': totalPrice,
      'product': product?.toMap(),
    };
  }

  factory CartItem.fromMap(Map<String, dynamic> map) {
    return CartItem(
      id: map['id'] ?? 0,
      productId: map['product_id'] ?? 0,
      size: map['size'] ?? '',
      qty: map['qty'] ?? 0,
      totalPrice: map['total_price'] ?? '',
      product: map['product'] != null
          ? Product.fromMap(map['product'] as Map<String, dynamic>)
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory CartItem.fromJson(String source) =>
      CartItem.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;

  @override
  List<Object> get props {
    return [
      id,
      productId,
      size,
      qty,
      totalPrice,
      product!,
    ];
  }
}

class Product extends Equatable {
  final String name;
  final String image;

  const Product({
    required this.name,
    required this.image,
  });

  Product copyWith({
    String? name,
    String? image,
  }) {
    return Product(
      name: name ?? this.name,
      image: image ?? this.image,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'image': image,
    };
  }

  factory Product.fromMap(Map<String, dynamic> map) {
    return Product(
      name: map['name'] ?? '',
      image: map['image'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory Product.fromJson(String source) =>
      Product.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;

  @override
  List<Object> get props => [name, image];
}

class CartSummary extends Equatable {
  final List<CartItems>? cartItems;
  final int subtotal;
  final int cartCount;
  final int totalItems;

  const CartSummary({
    this.cartItems,
    required this.subtotal,
    required this.cartCount,
    required this.totalItems,
  });

  CartSummary copyWith({
    List<CartItems>? cartItems,
    int? subtotal,
    int? cartCount,
    int? totalItems,
  }) {
    return CartSummary(
      cartItems: cartItems ?? this.cartItems,
      subtotal: subtotal ?? this.subtotal,
      cartCount: cartCount ?? this.cartCount,
      totalItems: totalItems ?? this.totalItems,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'cart_items': cartItems?.map((x) => x.toMap()).toList(),
      'subtotal': subtotal,
      'cart_count': cartCount,
      'total_items': totalItems,
    };
  }

  factory CartSummary.fromMap(Map<String, dynamic> map) {
    return CartSummary(
      cartItems: map['cart_items'] != null
          ? List<CartItems>.from(
        (map['cart_items'] as List<dynamic>).map<CartItems?>(
              (x) => CartItems.fromMap(x as Map<String, dynamic>),
        ),
      )
          : null,
      subtotal: map['subtotal'] ?? 0,
      cartCount: map['cart_count'] ?? 0,
      totalItems: map['total_items'] ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory CartSummary.fromJson(String source) =>
      CartSummary.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;

  @override
  List<Object> get props => [cartItems!, subtotal, cartCount, totalItems];
}
