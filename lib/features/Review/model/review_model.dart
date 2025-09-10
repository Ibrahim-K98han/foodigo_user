// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:equatable/equatable.dart';

class ReviewModel extends Equatable {
  final List<Review>? review;

  const ReviewModel({
    this.review,
  });

  ReviewModel copyWith({
    List<Review>? review,
  }) {
    return ReviewModel(
      review: review ?? this.review,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'review': review?.map((x) => x.toMap()).toList(),
    };
  }

  factory ReviewModel.fromMap(Map<String, dynamic> map) {
    return ReviewModel(
      review: map['data'] != null
          ? List<Review>.from(
              (map['data'] as List)
                  .map((x) => Review.fromMap(x as Map<String, dynamic>)),
            )
          : [],
    );
  }

  String toJson() => json.encode(toMap());

  factory ReviewModel.fromJson(String source) =>
      ReviewModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;

  @override
  List<Object> get props => [review!];
}

class Review extends Equatable {
  final int id;
  final String userId;
  final String orderId;
  final String productId;
  final String review;
  final String rating;
  final String status;
  final String createdAt;
  final String updatedAt;
  final String restaurantId;
  final Product? product;

  const Review({
    required this.id,
    required this.userId,
    required this.orderId,
    required this.productId,
    required this.review,
    required this.rating,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    required this.restaurantId,
    this.product,
  });

  Review copyWith({
    int? id,
    String? userId,
    String? orderId,
    String? productId,
    String? review,
    String? rating,
    String? status,
    String? createdAt,
    String? updatedAt,
    String? restaurantId,
    Product? product,
  }) {
    return Review(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      orderId: orderId ?? this.orderId,
      productId: productId ?? this.productId,
      review: review ?? this.review,
      rating: rating ?? this.rating,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      restaurantId: restaurantId ?? this.restaurantId,
      product: product ?? this.product,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'user_id': userId,
      'order_id': orderId,
      'product_id': productId,
      'review': review,
      'rating': rating,
      'status': status,
      'created_at': createdAt,
      'updated_at': updatedAt,
      'restaurant_id': restaurantId,
      'product': product?.toMap(),
    };
  }

  factory Review.fromMap(Map<String, dynamic> map) {
    return Review(
      id: map['id'] ?? 0,
      userId: map['user_id'] ?? '',
      orderId: map['order_id'] ?? '',
      productId: map['product_id'] ?? '',
      review: map['review'] ?? '',
      rating: map['rating'] ?? '',
      status: map['status'] ?? '',
      createdAt: map['created_at'] ?? '',
      updatedAt: map['updated_at'] ?? '',
      restaurantId: map['restaurant_id'] ?? '',
      product: map['product'] != null
          ? Product.fromMap(map['product'] as Map<String, dynamic>)
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Review.fromJson(String source) =>
      Review.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;

  @override
  List<Object> get props {
    return [
      id,
      userId,
      orderId,
      productId,
      review,
      rating,
      status,
      createdAt,
      updatedAt,
      restaurantId,
      product!,
    ];
  }
}

class Product extends Equatable {
  final int id;
  final String slug;
  final String image;
  final String categoryId;
  final String restaurantId;
  final String price;
  final String offerPrice;
  final String status;
  final String addonItems;
  final String createdAt;
  final String updatedAt;
  final String isFeatured;
  final String name;
  final String shortDescription;
  final String size;

  const Product({
    required this.id,
    required this.slug,
    required this.image,
    required this.categoryId,
    required this.restaurantId,
    required this.price,
    required this.offerPrice,
    required this.status,
    required this.addonItems,
    required this.createdAt,
    required this.updatedAt,
    required this.isFeatured,
    required this.name,
    required this.shortDescription,
    required this.size,
  });

  Product copyWith({
    int? id,
    String? slug,
    String? image,
    String? categoryId,
    String? restaurantId,
    String? price,
    String? offerPrice,
    String? status,
    String? addonItems,
    String? createdAt,
    String? updatedAt,
    String? isFeatured,
    String? name,
    String? shortDescription,
    String? size,
  }) {
    return Product(
      id: id ?? this.id,
      slug: slug ?? this.slug,
      image: image ?? this.image,
      categoryId: categoryId ?? this.categoryId,
      restaurantId: restaurantId ?? this.restaurantId,
      price: price ?? this.price,
      offerPrice: offerPrice ?? this.offerPrice,
      status: status ?? this.status,
      addonItems: addonItems ?? this.addonItems,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      isFeatured: isFeatured ?? this.isFeatured,
      name: name ?? this.name,
      shortDescription: shortDescription ?? this.shortDescription,
      size: size ?? this.size,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'slug': slug,
      'image': image,
      'category_id': categoryId,
      'restaurant_id': restaurantId,
      'price': price,
      'offer_price': offerPrice,
      'status': status,
      'addon_items': addonItems,
      'created_at': createdAt,
      'updated_at': updatedAt,
      'is_featured': isFeatured,
      'name': name,
      'short_description': shortDescription,
      'size': size,
    };
  }

  factory Product.fromMap(Map<String, dynamic> map) {
    return Product(
      id: map['id'] ?? 0,
      slug: map['slug'] ?? '',
      image: map['image'] ?? '',
      categoryId: map['category_id'] ?? '',
      restaurantId: map['restaurant_id'] ?? '',
      price: map['price'] ?? '',
      offerPrice: map['offer_price'] ?? '',
      status: map['status'] ?? '',
      addonItems: map['addon_items'] ?? '',
      createdAt: map['created_at'] ?? '',
      updatedAt: map['updated_at'] ?? '',
      isFeatured: map['is_featured'] ?? '',
      name: map['name'] ?? '',
      shortDescription: map['short_description'] ?? '',
      size: map['size'] ?? '',
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
      slug,
      image,
      categoryId,
      restaurantId,
      price,
      offerPrice,
      status,
      addonItems,
      createdAt,
      updatedAt,
      isFeatured,
      name,
      shortDescription,
      size,
    ];
  }
}
