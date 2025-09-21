import 'dart:convert';
import 'package:equatable/equatable.dart';
import 'package:foodigo/features/SingleRestaurant/model/single_restaurant_model.dart';

class StoreProductResponseModel extends Equatable {
  final String image;
  final String slug;
  final int restaurantId;
  final String categoryId;
  final String price;
  final int offerPrice;
  final String? addonItems;
  final String status;
  final String updatedAt;
  final String createdAt;
  final int id;
  final String name;
  final String? shortDescription;
  final Map<String, dynamic> size;
  final Products? products;

  const StoreProductResponseModel({
    required this.image,
    required this.slug,
    required this.restaurantId,
    required this.categoryId,
    required this.price,
    required this.offerPrice,
    this.addonItems,
    required this.status,
    required this.updatedAt,
    required this.createdAt,
    required this.id,
    required this.name,
    this.shortDescription,
    required this.size,
    this.products,
  });

  StoreProductResponseModel copyWith({
    String? image,
    String? slug,
    int? restaurantId,
    String? categoryId,
    String? price,
    int? offerPrice,
    String? addonItems,
    String? status,
    String? updatedAt,
    String? createdAt,
    int? id,
    String? name,
    String? shortDescription,
    Map<String, dynamic>? size,
  }) {
    return StoreProductResponseModel(
      image: image ?? this.image,
      slug: slug ?? this.slug,
      restaurantId: restaurantId ?? this.restaurantId,
      categoryId: categoryId ?? this.categoryId,
      price: price ?? this.price,
      offerPrice: offerPrice ?? this.offerPrice,
      addonItems: addonItems ?? this.addonItems,
      status: status ?? this.status,
      updatedAt: updatedAt ?? this.updatedAt,
      createdAt: createdAt ?? this.createdAt,
      id: id ?? this.id,
      name: name ?? this.name,
      shortDescription: shortDescription ?? this.shortDescription,
      size: size ?? this.size,
      products: products ?? this.products,
    );
  }

  factory StoreProductResponseModel.fromMap(Map<String, dynamic> map) {
    return StoreProductResponseModel(
      image: map['image'] ?? '',
      slug: map['slug'] ?? '',
      restaurantId: map['restaurant_id'] is int
          ? map['restaurant_id']
          : int.tryParse(map['restaurant_id'].toString()) ?? 0,
      categoryId: map['category_id'].toString(),
      price: map['price'].toString(),
      offerPrice: map['offer_price'] is int
          ? map['offer_price']
          : int.tryParse(map['offer_price'].toString()) ?? 0,
      addonItems: map['addon_items'],
      status: map['status'] ?? '',
      updatedAt: map['updated_at'] ?? '',
      createdAt: map['created_at'] ?? '',
      id: map['id'] ?? 0,
      name: map['name'] ?? '',
      shortDescription: map['short_description'],
      size:
          map['size'] is String ? jsonDecode(map['size']) : (map['size'] ?? {}),
      products:
          map['products'] != null ? Products.fromMap(map['products']) : null,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'image': image,
      'slug': slug,
      'restaurant_id': restaurantId,
      'category_id': categoryId,
      'price': price,
      'offer_price': offerPrice,
      'addon_items': addonItems,
      'status': status,
      'updated_at': updatedAt,
      'created_at': createdAt,
      'id': id,
      'name': name,
      'short_description': shortDescription,
      'size': size,
      'products': products?.toMap(),
    };
  }

  String toJson() => json.encode(toMap());

  factory StoreProductResponseModel.fromJson(String source) =>
      StoreProductResponseModel.fromMap(json.decode(source));

  @override
  List<Object?> get props => [
        image,
        slug,
        restaurantId,
        categoryId,
        price,
        offerPrice,
        addonItems,
        status,
        updatedAt,
        createdAt,
        id,
        name,
        shortDescription,
        size,
        products,
      ];
}
