// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:foodigo/features/HomeData/restaurant_model.dart';

class RestaurantDetailsModel extends Equatable {
  final Restaurants restaurant;
  final List<Categories> categories;

  const RestaurantDetailsModel({
    required this.restaurant,
    this.categories = const [],
  });

  RestaurantDetailsModel copyWith({
    Restaurants? restaurant,
    List<Categories>? categories,
  }) {
    return RestaurantDetailsModel(
      restaurant: restaurant ?? this.restaurant,
      categories: categories ?? this.categories,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'restaurant': restaurant.toMap(),
      'categories': categories.map((x) => x.toMap()).toList(),
    };
  }

  factory RestaurantDetailsModel.fromMap(Map<String, dynamic> map) {
    return RestaurantDetailsModel(
      restaurant: Restaurants.fromMap(map['restaurant'] ?? {}),
      categories: map['categories'] != null
          ? List<Categories>.from(
              (map['categories'] as List<dynamic>)
                  .map((x) => Categories.fromMap(x as Map<String, dynamic>)),
            )
          : [],
    );
  }

  String toJson() => json.encode(toMap());

  factory RestaurantDetailsModel.fromJson(String source) =>
      RestaurantDetailsModel.fromMap(json.decode(source));

  @override
  bool get stringify => true;

  @override
  List<Object> get props => [restaurant, categories];
}

class Categories extends Equatable {
  final int id;
  final String slug;
  final String status;
  final String createdAt;
  final String updatedAt;
  final String icon;
  final int filteredProductsCount;
  final String name;
  final List<Products> products;

  const Categories({
    required this.id,
    required this.slug,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    required this.icon,
    required this.filteredProductsCount,
    required this.name,
    this.products = const [],
  });

  Categories copyWith({
    int? id,
    String? slug,
    String? status,
    String? createdAt,
    String? updatedAt,
    String? icon,
    int? filteredProductsCount,
    String? name,
    List<Products>? products,
  }) {
    return Categories(
      id: id ?? this.id,
      slug: slug ?? this.slug,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      icon: icon ?? this.icon,
      filteredProductsCount:
          filteredProductsCount ?? this.filteredProductsCount,
      name: name ?? this.name,
      products: products ?? this.products,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'slug': slug,
      'status': status,
      'created_at': createdAt,
      'updated_at': updatedAt,
      'icon': icon,
      'filtered_products_count': filteredProductsCount,
      'name': name,
      'products': products.map((x) => x.toMap()).toList(),
    };
  }

  factory Categories.fromMap(Map<String, dynamic> map) {
    return Categories(
      id: map['id'] ?? 0,
      slug: map['slug'] ?? '',
      status: map['status'] ?? '',
      createdAt: map['created_at'] ?? '',
      updatedAt: map['updated_at'] ?? '',
      icon: map['icon'] ?? '',
      filteredProductsCount: map['filtered_products_count'] is int
          ? map['filtered_products_count'] as int
          : int.tryParse(map['filtered_products_count'].toString()) ?? 0,
      name: map['name'] ?? '',
      products: map['products'] != null
          ? List<Products>.from(
              (map['products'] as List<dynamic>)
                  .map((x) => Products.fromMap(x as Map<String, dynamic>)),
            )
          : [],
    );
  }

  String toJson() => json.encode(toMap());

  factory Categories.fromJson(String source) =>
      Categories.fromMap(json.decode(source));

  @override
  bool get stringify => true;

  @override
  List<Object> get props => [
        id,
        slug,
        status,
        createdAt,
        updatedAt,
        icon,
        filteredProductsCount,
        name,
        products,
      ];
}

class Products extends Equatable {
  final int id;
  final String slug;
  final String image;
  final int categoryId;
  final int restaurantId;
  final int price;
  final int offerPrice;
  final String status;
  final String addonItems;
  final String createdAt;
  final String updatedAt;
  final String isFeatured;
  final String reviewsAvgRating;
  final int reviewsCount;
  final String name;
  final String shortDescription;
  final String size;

  const Products({
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
    required this.reviewsAvgRating,
    required this.reviewsCount,
    required this.name,
    required this.shortDescription,
    required this.size,
  });

  Products copyWith({
    int? id,
    String? slug,
    String? image,
    int? categoryId,
    int? restaurantId,
    int? price,
    int? offerPrice,
    String? status,
    String? addonItems,
    String? createdAt,
    String? updatedAt,
    String? isFeatured,
    String? reviewsAvgRating,
    int? reviewsCount,
    String? name,
    String? shortDescription,
    String? size,
  }) {
    return Products(
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
      reviewsAvgRating: reviewsAvgRating ?? this.reviewsAvgRating,
      reviewsCount: reviewsCount ?? this.reviewsCount,
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
      'reviews_avg_rating': reviewsAvgRating,
      'reviews_count': reviewsCount,
      'name': name,
      'short_description': shortDescription,
      'size': size,
    };
  }

  factory Products.fromMap(Map<String, dynamic> map) {
    return Products(
      id: map['id'] ?? 0,
      slug: map['slug'] ?? '',
      image: map['image'] ?? '',
      categoryId: map['category_id'] is int
          ? map['category_id'] as int
          : int.tryParse(map['category_id'].toString()) ?? 0,
      restaurantId: map['restaurant_id'] is int
          ? map['restaurant_id'] as int
          : int.tryParse(map['restaurant_id'].toString()) ?? 0,
      price: map['price'] is int
          ? map['price'] as int
          : int.tryParse(map['price'].toString()) ?? 0,
      offerPrice: map['offer_price'] is int
          ? map['offer_price'] as int
          : int.tryParse(map['offer_price'].toString()) ?? 0,
      status: map['status'] ?? '',
      addonItems: map['addon_items'] ?? '',
      createdAt: map['created_at'] ?? '',
      updatedAt: map['updated_at'] ?? '',
      isFeatured: map['is_featured'] ?? '',
      reviewsAvgRating: map['reviews_avg_rating'] ?? '',
      reviewsCount: map['reviews_count'] is int
          ? map['reviews_count'] as int
          : int.tryParse(map['reviews_count'].toString()) ?? 0,
      name: map['name'] ?? '',
      shortDescription: map['short_description'] ?? '',
      size: map['size'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory Products.fromJson(String source) =>
      Products.fromMap(json.decode(source));

  @override
  bool get stringify => true;

  @override
  List<Object> get props => [
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
        reviewsAvgRating,
        reviewsCount,
        name,
        shortDescription,
        size,
      ];
}
