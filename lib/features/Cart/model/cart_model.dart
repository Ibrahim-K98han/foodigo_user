// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'package:equatable/equatable.dart';
import 'package:foodigo/features/HomeData/category_model.dart';
import 'package:foodigo/features/HomeData/restaurant_model.dart';

class CartModel extends Equatable {
  final List<CartItems>? cartItems;
  final int subtotal;
  final int cartCount;
  final int totalItems;
  final String appliedCoupon;

  const CartModel({
    this.cartItems,
    required this.subtotal,
    required this.cartCount,
    required this.totalItems,
    required this.appliedCoupon,
  });

  CartModel copyWith({
    List<CartItems>? cartItems,
    int? subtotal,
    int? cartCount,
    int? totalItems,
    String? appliedCoupon,
  }) {
    return CartModel(
      cartItems: cartItems ?? this.cartItems,
      subtotal: subtotal ?? this.subtotal,
      cartCount: cartCount ?? this.cartCount,
      totalItems: totalItems ?? this.totalItems,
      appliedCoupon: appliedCoupon ?? this.appliedCoupon,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'cart_items': cartItems?.map((x) => x.toMap()).toList(),
      'subtotal': subtotal,
      'cart_count': cartCount,
      'total_items': totalItems,
      'applied_coupon': appliedCoupon,
    };
  }

  factory CartModel.fromMap(Map<String, dynamic> map) {
    return CartModel(
      cartItems: map['cart_items'] != null
          ? List<CartItems>.from(
              (map['cart_items'] ?? []).map((x) => CartItems.fromMap(x)))
          : null,
      subtotal: (map['subtotal'] ?? 0).toDouble().toInt(),
      cartCount: (map['cart_count'] ?? 0).toDouble().toInt(),
      totalItems: (map['total_items'] ?? 0).toDouble().toInt(),
      appliedCoupon: map['applied_coupon'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory CartModel.fromJson(String source) =>
      CartModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;

  @override
  List<Object> get props {
    return [
      cartItems!,
      subtotal,
      cartCount,
      totalItems,
      appliedCoupon,
    ];
  }
}

class CartItems extends Equatable {
  final int cartId;
  final int productId;
  final String size;
  final String sizePrice;
  final int qty;
  final Map<String, dynamic> addons;
  final String addonPrice;
  final String totalPrice;
  final Product? product;
  final Restaurants? restaurant;
  final String createdAt;
  final String updatedAt;

  const CartItems({
    required this.cartId,
    required this.productId,
    required this.size,
    required this.sizePrice,
    required this.qty,
    required this.addons,
    required this.addonPrice,
    required this.totalPrice,
    required this.product,
    required this.restaurant,
    required this.createdAt,
    required this.updatedAt,
  });

  CartItems copyWith({
    int? cartId,
    int? productId,
    String? size,
    String? sizePrice,
    int? qty,
    Map<String, dynamic>? addons,
    String? addonPrice,
    String? totalPrice,
    Product? product,
    Restaurants? restaurant,
    String? createdAt,
    String? updatedAt,
  }) {
    return CartItems(
      cartId: cartId ?? this.cartId,
      productId: productId ?? this.productId,
      size: size ?? this.size,
      sizePrice: sizePrice ?? this.sizePrice,
      qty: qty ?? this.qty,
      addons: addons ?? this.addons,
      addonPrice: addonPrice ?? this.addonPrice,
      totalPrice: totalPrice ?? this.totalPrice,
      product: product ?? this.product,
      restaurant: restaurant ?? this.restaurant,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  factory CartItems.fromMap(Map<String, dynamic> map) {
    return CartItems(
      cartId: map['id'] ?? map['cart_id'] ?? 0,
      productId: int.tryParse(map['product_id'].toString()) ?? 0,
      size: map['size'] ?? '',
      sizePrice: map['size_price'] ?? '0',
      qty: int.tryParse(map['qty'].toString()) ?? 0,
      addons: map['addons'] is Map
          ? map['addons'] as Map<String, dynamic>
          : <String, dynamic>{},
      addonPrice: map['addon_price'] ?? '0',
      totalPrice: map['total_price'] ?? '0',
      product: map['product'] != null
          ? Product.fromMap(map['product'] as Map<String, dynamic>)
          : null,
      restaurant: map['restaurant'] != null
          ? Restaurants.fromMap(map['restaurant'] as Map<String, dynamic>)
          : null,
      createdAt: map['created_at'] ?? '',
      updatedAt: map['updated_at'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': cartId,
      'product_id': productId,
      'size': size,
      'size_price': sizePrice,
      'qty': qty,
      'addons': addons,
      'addon_price': addonPrice,
      'total_price': totalPrice,
      'product': product?.toMap(),
      'restaurant': restaurant?.toMap(),
      'created_at': createdAt,
      'updated_at': updatedAt,
    };
  }

  @override
  List<Object?> get props => [
        cartId,
        productId,
        size,
        sizePrice,
        qty,
        addons,
        addonPrice,
        totalPrice,
        product,
        restaurant,
        createdAt,
        updatedAt,
      ];
}

class Addons extends Equatable {
  final int i1;
  final int i2;

  const Addons({
    required this.i1,
    required this.i2,
  });

  Addons copyWith({
    int? i1,
    int? i2,
  }) {
    return Addons(
      i1: i1 ?? this.i1,
      i2: i2 ?? this.i2,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'i1': i1,
      'i2': i2,
    };
  }

  factory Addons.fromMap(Map<String, dynamic> map) {
    return Addons(
      i1: map['i1'] ?? 0,
      i2: map['i2'] ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory Addons.fromJson(String source) =>
      Addons.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;

  @override
  List<Object> get props => [i1, i2];
}

class Product extends Equatable {
  final int id;
  final String name;
  final String slug;
  final String image;
  final String shortDescription;
  final Restaurants? restaurant;
  final Categories? category;

  // final String averageRating;
  final int totalReviews;

  const Product({
    required this.id,
    required this.name,
    required this.slug,
    required this.image,
    required this.shortDescription,
    this.restaurant,
    this.category,
    // required this.averageRating,
    required this.totalReviews,
  });

  Product copyWith({
    int? id,
    String? name,
    String? slug,
    String? image,
    String? shortDescription,
    Restaurants? restaurant,
    Categories? category,
    String? averageRating,
    int? totalReviews,
  }) {
    return Product(
      id: id ?? this.id,
      name: name ?? this.name,
      slug: slug ?? this.slug,
      image: image ?? this.image,
      shortDescription: shortDescription ?? this.shortDescription,
      restaurant: restaurant ?? this.restaurant,
      category: category ?? this.category,
      // averageRating: averageRating ?? this.averageRating,
      totalReviews: totalReviews ?? this.totalReviews,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'slug': slug,
      'image': image,
      'short_description': shortDescription,
      'restaurant': restaurant?.toMap(),
      'category': category?.toMap(),
      // 'average_rating': averageRating,
      'total_reviews': totalReviews,
    };
  }

  factory Product.fromMap(Map<String, dynamic> map) {
    return Product(
      id: map['id'] ?? 0,
      name: map['name'] ?? '',
      slug: map['slug'] ?? '',
      image: map['image'] ?? '',
      shortDescription: map['short_description'] ?? '',
      restaurant: map['restaurant'] != null
          ? Restaurants.fromMap(map['restaurant'] as Map<String, dynamic>)
          : null,
      category: map['category'] != null
          ? Categories.fromMap(map['category'] as Map<String, dynamic>)
          : null,
      // averageRating: map['average_rating'] ?? '',
      totalReviews: map['total_reviews'] is int
          ? map['total_reviews'] as int
          : int.tryParse(map['total_reviews'].toString()) ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory Product.fromJson(String source) =>
      Product.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;

  @override
  List<Object> get props {
    return [
      id,
      name,
      slug,
      image,
      shortDescription,
      restaurant!,
      category!,
      // averageRating,
      totalReviews,
    ];
  }
}
