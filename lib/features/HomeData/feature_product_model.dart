// // ignore_for_file: public_member_api_docs, sort_constructors_first
// import 'dart:convert';
//
// import 'package:equatable/equatable.dart';
//
// class FeaturedProducts extends Equatable {
//   final int id;
//   final String slug;
//   final String image;
//   final int categoryId;
//   final int restaurantId;
//   final int price;
//   final int offerPrice;
//   final String status;
//   // final String addonItems;
//   final List<FeatureAddons>? addons;
//   final String createdAt;
//   final String updatedAt;
//   final String isFeatured;
//   final String reviewsAvgRating;
//   final int reviewsCount;
//   final String name;
//   final String shortDescription;
//   final String size;
//
//   const FeaturedProducts({
//     required this.id,
//     required this.slug,
//     required this.image,
//     required this.categoryId,
//     required this.restaurantId,
//     required this.price,
//     required this.offerPrice,
//     required this.status,
//     // required this.addonItems,
//     required this.addons,
//     required this.createdAt,
//     required this.updatedAt,
//     required this.isFeatured,
//     required this.reviewsAvgRating,
//     required this.reviewsCount,
//     required this.name,
//     required this.shortDescription,
//     required this.size,
//   });
//
//   FeaturedProducts copyWith({
//     int? id,
//     String? slug,
//     String? image,
//     int? categoryId,
//     int? restaurantId,
//     int? price,
//     int? offerPrice,
//     String? status,
//     // String? addonItems,
//     String? addons,
//     String? createdAt,
//     String? updatedAt,
//     String? isFeatured,
//     String? reviewsAvgRating,
//     int? reviewsCount,
//     String? name,
//     String? shortDescription,
//     String? size,
//   }) {
//     return FeaturedProducts(
//       id: id ?? this.id,
//       slug: slug ?? this.slug,
//       image: image ?? this.image,
//       categoryId: categoryId ?? this.categoryId,
//       restaurantId: restaurantId ?? this.restaurantId,
//       price: price ?? this.price,
//       offerPrice: offerPrice ?? this.offerPrice,
//       status: status ?? this.status,
//       addons: addons ?? this.addons,
//       // addonItems: addonItems ?? this.addonItems,
//       createdAt: createdAt ?? this.createdAt,
//       updatedAt: updatedAt ?? this.updatedAt,
//       isFeatured: isFeatured ?? this.isFeatured,
//       reviewsAvgRating: reviewsAvgRating ?? this.reviewsAvgRating,
//       reviewsCount: reviewsCount ?? this.reviewsCount,
//       name: name ?? this.name,
//       shortDescription: shortDescription ?? this.shortDescription,
//       size: size ?? this.size,
//     );
//   }
//
//   Map<String, dynamic> toMap() {
//     return <String, dynamic>{
//       'id': id,
//       'slug': slug,
//       'image': image,
//       'category_id': categoryId,
//       'restaurant_id': restaurantId,
//       'price': price,
//       'offer_price': offerPrice,
//       'status': status,
//       // 'addon_items': addonItems,
//       'addons': addons,
//       'created_at': createdAt,
//       'updated_at': updatedAt,
//       'is_featured': isFeatured,
//       'reviews_avg_rating': reviewsAvgRating,
//       'reviews_count': reviewsCount,
//       'name': name,
//       'short_description': shortDescription,
//       'size': size,
//     };
//   }
//
//   // map['price'] != null ? double.parse(map['price'].toString()) : 0.0,
//   factory FeaturedProducts.fromMap(Map<String, dynamic> map) {
//     return FeaturedProducts(
//       id: map['id'] ?? 0,
//       slug: map['slug'] ?? '',
//       image: map['image'] ?? '',
//       categoryId: map['category_id'] is int ? map['category_id'] as int : int.tryParse(map['category_id'].toString()) ?? 0,
//       restaurantId: map['restaurant_id'] is int
//           ? map['restaurant_id'] as int
//           : int.tryParse(map['restaurant_id'].toString()) ?? 0,
//       price: map['price'] is int
//           ? map['price'] as int
//           : int.tryParse(map['price'].toString()) ?? 0,
//       offerPrice: map['offer_price'] is int
//           ? map['offer_price'] as int
//           : int.tryParse(map['offer_price'].toString()) ?? 0,
//       status: map['status'] ?? '',
//       // addonItems: map['addon_items'] ?? '',
//       addons: map['addons'] ?? '',
//       createdAt: map['created_at'] ?? '',
//       updatedAt: map['updated_at'] ?? '',
//       isFeatured: map['is_featured'] ?? '',
//       reviewsAvgRating: map['reviews_avg_rating'] ?? '',
//       reviewsCount: map['reviews_count'] is int
//           ? map['reviews_count'] as int
//           : int.tryParse(map['reviews_count'].toString()) ?? 0,
//       name: map['name'] ?? '',
//       shortDescription: map['short_description'] ?? '',
//       size: map['size'] ?? '',
//     );
//   }
//
//   String toJson() => json.encode(toMap());
//
//   factory FeaturedProducts.fromJson(String source) =>
//       FeaturedProducts.fromMap(json.decode(source) as Map<String, dynamic>);
//
//   @override
//   bool get stringify => true;
//
//   @override
//   List<Object> get props {
//     return [
//       id,
//       slug,
//       image,
//       categoryId,
//       restaurantId,
//       price,
//       offerPrice,
//       status,
//       // addonItems,
//       addons,
//       createdAt,
//       updatedAt,
//       isFeatured,
//       reviewsAvgRating,
//       reviewsCount,
//       name,
//       shortDescription,
//       size,
//     ];
//   }
// }
//
// class FeatureAddons extends Equatable {
//   final int id;
//   final String name;
//   final String price;
//   const FeatureAddons({
//     required this.id,
//     required this.name,
//     required this.price,
//   });
//
//   FeatureAddons copyWith({
//     int? id,
//     String? name,
//     String? price,
//   }) {
//     return FeatureAddons(
//       id: id ?? this.id,
//       name: name ?? this.name,
//       price: price ?? this.price,
//     );
//   }
//
//   Map<String, dynamic> toMap() {
//     return <String, dynamic>{
//       'id': id,
//       'name': name,
//       'price': price,
//     };
//   }
//
//   factory FeatureAddons.fromMap(Map<String, dynamic> map) {
//     return FeatureAddons(
//       id: map['id'] as int,
//       name: map['name'] as String,
//       price: map['price'] as String,
//     );
//   }
//
//   String toJson() => json.encode(toMap());
//
//   factory FeatureAddons.fromJson(String source) => FeatureAddons.fromMap(json.decode(source) as Map<String, dynamic>);
//
//   @override
//   bool get stringify => true;
//
//   @override
//   List<Object> get props => [id, name, price];
// }
//
//
//



// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:equatable/equatable.dart';

class FeaturedProducts extends Equatable {
  final int id;
  final String slug;
  final String image;
  final int categoryId;
  final int restaurantId;
  final int price;
  final int offerPrice;
  final String status;
  final List<FeatureAddons>? addons; // ✅ Correct type
  final String createdAt;
  final String updatedAt;
  final String isFeatured;
  final String reviewsAvgRating;
  final int reviewsCount;
  final String name;
  final String shortDescription;
  final String size;

  const FeaturedProducts({
    required this.id,
    required this.slug,
    required this.image,
    required this.categoryId,
    required this.restaurantId,
    required this.price,
    required this.offerPrice,
    required this.status,
    required this.addons,
    required this.createdAt,
    required this.updatedAt,
    required this.isFeatured,
    required this.reviewsAvgRating,
    required this.reviewsCount,
    required this.name,
    required this.shortDescription,
    required this.size,
  });

  FeaturedProducts copyWith({
    int? id,
    String? slug,
    String? image,
    int? categoryId,
    int? restaurantId,
    int? price,
    int? offerPrice,
    String? status,
    List<FeatureAddons>? addons, // ✅ Fixed
    String? createdAt,
    String? updatedAt,
    String? isFeatured,
    String? reviewsAvgRating,
    int? reviewsCount,
    String? name,
    String? shortDescription,
    String? size,
  }) {
    return FeaturedProducts(
      id: id ?? this.id,
      slug: slug ?? this.slug,
      image: image ?? this.image,
      categoryId: categoryId ?? this.categoryId,
      restaurantId: restaurantId ?? this.restaurantId,
      price: price ?? this.price,
      offerPrice: offerPrice ?? this.offerPrice,
      status: status ?? this.status,
      addons: addons ?? this.addons,
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
      'addons': addons?.map((x) => x.toMap()).toList(), // ✅ Fixed
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

  factory FeaturedProducts.fromMap(Map<String, dynamic> map) {
    return FeaturedProducts(
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
      // ✅ Fixed: Properly parse addons list
      addons: map['addons'] != null
          ? (map['addons'] is List
          ? List<FeatureAddons>.from(
        (map['addons'] as List).map((x) => FeatureAddons.fromMap(x as Map<String, dynamic>)),
      )
          : null)
          : null,
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

  factory FeaturedProducts.fromJson(String source) =>
      FeaturedProducts.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;

  @override
  List<Object?> get props { // ✅ Changed to Object? to handle null
    return [
      id,
      slug,
      image,
      categoryId,
      restaurantId,
      price,
      offerPrice,
      status,
      addons,
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
}

class FeatureAddons extends Equatable {
  final int id;
  final String name;
  final String price;

  const FeatureAddons({
    required this.id,
    required this.name,
    required this.price,
  });

  FeatureAddons copyWith({
    int? id,
    String? name,
    String? price,
  }) {
    return FeatureAddons(
      id: id ?? this.id,
      name: name ?? this.name,
      price: price ?? this.price,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'price': price,
    };
  }

  factory FeatureAddons.fromMap(Map<String, dynamic> map) {
    return FeatureAddons(
      id: map['id'] is int ? map['id'] as int : int.tryParse(map['id'].toString()) ?? 0,
      name: map['name']?.toString() ?? '',
      price: map['price']?.toString() ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory FeatureAddons.fromJson(String source) =>
      FeatureAddons.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;

  @override
  List<Object> get props => [id, name, price];
}