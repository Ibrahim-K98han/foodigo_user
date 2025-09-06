// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'package:equatable/equatable.dart';
import '../../HomeData/category_model.dart';
import '../../HomeData/cuisines_model.dart';

class AllFoodModel extends Equatable {
  final List<Foods>? foods;
  final List<Categories>? categories;
  final List<Cuisines>? cuisines;

  const AllFoodModel({
    this.foods,
    this.categories,
    this.cuisines,
  });

  AllFoodModel copyWith({
    List<Foods>? foods,
    List<Categories>? categories,
    List<Cuisines>? cuisines,
  }) {
    return AllFoodModel(
      foods: foods ?? this.foods,
      categories: categories ?? this.categories,
      cuisines: cuisines ?? this.cuisines,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'foods': foods?.map((x) => x.toMap()).toList(),
      'categories': categories?.map((x) => x.toMap()).toList(),
      'cuisines': cuisines?.map((x) => x.toMap()).toList(),
    };
  }

  factory AllFoodModel.fromMap(Map<String, dynamic> map) {
    return AllFoodModel(
      foods: map['foods'] != null
          ? List<Foods>.from(
              (map['foods'] as List<dynamic>).map<Foods?>(
                (x) => Foods.fromMap(x as Map<String, dynamic>),
              ),
            )
          : null,
      categories: map['categories'] != null
          ? List<Categories>.from(
              (map['categories'] as List<dynamic>).map<Categories?>(
                (x) => Categories.fromMap(x as Map<String, dynamic>),
              ),
            )
          : null,
      cuisines: map['cuisines'] != null
          ? List<Cuisines>.from(
              (map['cuisines'] as List<dynamic>).map<Cuisines?>(
                (x) => Cuisines.fromMap(x as Map<String, dynamic>),
              ),
            )
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory AllFoodModel.fromJson(String source) =>
      AllFoodModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;

  @override
  List<Object> get props => [
        foods!,
        categories!,
        cuisines!,
      ];
}

class Foods extends Equatable {
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
  final String reviewsAvgRating;
  final String reviewsCount;
  final String name;
  final String shortDescription;
  final String size;

  const Foods({
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

  Foods copyWith({
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
    String? reviewsAvgRating,
    String? reviewsCount,
    String? name,
    String? shortDescription,
    String? size,
  }) {
    return Foods(
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

  factory Foods.fromMap(Map<String, dynamic> map) {
    return Foods(
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
      reviewsAvgRating: map['reviews_avg_rating'] ?? '',
      reviewsCount: map['reviews_count'] ?? '',
      name: map['name'] ?? '',
      shortDescription: map['short_description'] ?? '',
      size: map['size'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory Foods.fromJson(String source) =>
      Foods.fromMap(json.decode(source) as Map<String, dynamic>);

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
      reviewsAvgRating,
      reviewsCount,
      name,
      shortDescription,
      size,
    ];
  }
}
