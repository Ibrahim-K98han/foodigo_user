// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:equatable/equatable.dart';

class WishListModel extends Equatable {
  final bool status;
  final String message;
  final Data? data;

  const WishListModel({
    required this.status,
    required this.message,
    this.data,
  });

  WishListModel copyWith({
    bool? status,
    String? message,
    Data? data,
  }) {
    return WishListModel(
      status: status ?? this.status,
      message: message ?? this.message,
      data: data ?? this.data,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'status': status,
      'message': message,
      'data': data?.toMap(),
    };
  }

  factory WishListModel.fromMap(Map<String, dynamic> map) {
    return WishListModel(
      status: map['status'] as bool,
      message: map['message'] ?? '',
      data: map['data'] != null
          ? Data.fromMap(map['data'] as Map<String, dynamic>)
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory WishListModel.fromJson(String source) =>
      WishListModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;

  @override
  List<Object> get props => [status, message, data!];
}

class Data extends Equatable {
  final int totalItems;
  final List<WishlistItems>? wishlistItems;

  const Data({
    required this.totalItems,
    this.wishlistItems,
  });

  Data copyWith({
    int? totalItems,
    List<WishlistItems>? wishlistItems,
  }) {
    return Data(
      totalItems: totalItems ?? this.totalItems,
      wishlistItems: wishlistItems ?? this.wishlistItems,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'total_items': totalItems,
      'wishlist_items': wishlistItems?.map((x) => x.toMap()).toList(),
    };
  }

  factory Data.fromMap(Map<String, dynamic> map) {
    return Data(
      totalItems: map['total_items'] ?? 0,
      wishlistItems: map['wishlist_items'] != null
          ? List<WishlistItems>.from(
              (map['wishlist_items'] as List<dynamic>).map<WishlistItems?>(
                (x) => WishlistItems.fromMap(x as Map<String, dynamic>),
              ),
            )
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Data.fromJson(String source) =>
      Data.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;

  @override
  List<Object> get props => [totalItems, wishlistItems!];
}

class WishlistItems extends Equatable {
  final int wishlistId;
  final Product? product;
  final String addedAt;
  final String updatedAt;

  const WishlistItems({
    required this.wishlistId,
    this.product,
    required this.addedAt,
    required this.updatedAt,
  });

  WishlistItems copyWith({
    int? wishlistId,
    Product? product,
    String? addedAt,
    String? updatedAt,
  }) {
    return WishlistItems(
      wishlistId: wishlistId ?? this.wishlistId,
      product: product ?? this.product,
      addedAt: addedAt ?? this.addedAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'wishlist_id': wishlistId,
      'product': product?.toMap(),
      'added_at': addedAt,
      'updated_at': updatedAt,
    };
  }

  factory WishlistItems.fromMap(Map<String, dynamic> map) {
    return WishlistItems(
      wishlistId: map['wishlist_id'] ?? 0,
      product: map['product'] != null
          ? Product.fromMap(map['product'] as Map<String, dynamic>)
          : null,
      addedAt: map['added_at'] ?? '',
      updatedAt: map['updated_at'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory WishlistItems.fromJson(String source) =>
      WishlistItems.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;

  @override
  List<Object> get props => [wishlistId, product!, addedAt, updatedAt];
}

class Product extends Equatable {
  final int id;
  final String name;
  final String slug;
  final String shortDescription;
  final String specification;
  final String size;
  final String status;
  final String image;
  final int averageRating;
  final String totalReviews;
  final Category? category;

  const Product({
    required this.id,
    required this.name,
    required this.slug,
    required this.shortDescription,
    required this.specification,
    required this.size,
    required this.status,
    required this.image,
    required this.averageRating,
    required this.totalReviews,
    this.category,
  });

  Product copyWith({
    int? id,
    String? name,
    String? slug,
    String? shortDescription,
    String? specification,
    String? size,
    String? status,
    String? image,
    int? averageRating,
    String? totalReviews,
    Category? category,
  }) {
    return Product(
      id: id ?? this.id,
      name: name ?? this.name,
      slug: slug ?? this.slug,
      shortDescription: shortDescription ?? this.shortDescription,
      specification: specification ?? this.specification,
      size: size ?? this.size,
      status: status ?? this.status,
      image: image ?? this.image,
      averageRating: averageRating ?? this.averageRating,
      totalReviews: totalReviews ?? this.totalReviews,
      category: category ?? this.category,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'slug': slug,
      'short_description': shortDescription,
      'specification': specification,
      'size': size,
      'status': status,
      'image': image,
      'average_rating': averageRating,
      'total_reviews': totalReviews,
      'category': category?.toMap(),
    };
  }

  factory Product.fromMap(Map<String, dynamic> map) {
    return Product(
      id: map['id'] ?? 0,
      name: map['name'] ?? '',
      slug: map['slug'] ?? '',
      shortDescription: map['short_description'] ?? '',
      specification: map['specification'] ?? '',
      size: map['size'] ?? '',
      status: map['status'] ?? '',
      image: map['image'] ?? '',
      averageRating: map['average_rating'] != null
          ? double.parse(map['average_rating'].toString()).round()
          : 0,
      totalReviews: map['total_reviews'] ?? '',
      category: map['category'] != null
          ? Category.fromMap(map['category'] as Map<String, dynamic>)
          : null,
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
      shortDescription,
      specification,
      size,
      status,
      image,
      averageRating,
      totalReviews,
      category!,
    ];
  }
}

class Category extends Equatable {
  final int id;
  final String name;
  final String slug;

  const Category({
    required this.id,
    required this.name,
    required this.slug,
  });

  Category copyWith({
    int? id,
    String? name,
    String? slug,
  }) {
    return Category(
      id: id ?? this.id,
      name: name ?? this.name,
      slug: slug ?? this.slug,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'slug': slug,
    };
  }

  factory Category.fromMap(Map<String, dynamic> map) {
    return Category(
      id: map['id'] ?? 0,
      name: map['name'] ?? '',
      slug: map['slug'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory Category.fromJson(String source) =>
      Category.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;

  @override
  List<Object> get props => [id, name, slug];
}
