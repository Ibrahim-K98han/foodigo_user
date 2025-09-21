import 'dart:convert';
import 'package:equatable/equatable.dart';
import 'package:foodigo/features/restaurant_features/StoreProduct/cubit/store_product_state.dart';

class StoreProductStateModel extends Equatable {
  final String name;
  final String slug;
  final String categoryId;
  final String addonId;
  final String image; // file path
  final String productPrice;
  final String offerPrice;
  final String translateId;
  final List<String> size; // ["small", "medium", "large"]
  final List<String> price; // ["20", "40", "60"]
  final String shortDescription;
  final StoreProductState storeProductState;

  const StoreProductStateModel({
    this.name = '',
    this.slug = '',
    this.categoryId = '',
    this.addonId = '',
    this.image = '',
    this.productPrice = '',
    this.offerPrice = '',
    this.translateId = '',
    this.size = const [],
    this.price = const [],
    this.shortDescription = '',
    this.storeProductState = const StoreProductInitial(),
  });

  /// copyWith method
  StoreProductStateModel copyWith({
    String? name,
    String? slug,
    String? categoryId,
    String? addonId,
    String? image,
    String? productPrice,
    String? offerPrice,
    String? translateId,
    List<String>? size,
    List<String>? price,
    String? shortDescription,
    StoreProductState? storeProductState,
  }) {
    return StoreProductStateModel(
      name: name ?? this.name,
      slug: slug ?? this.slug,
      categoryId: categoryId ?? this.categoryId,
      addonId: addonId ?? this.addonId,
      image: image ?? this.image,
      productPrice: productPrice ?? this.productPrice,
      offerPrice: offerPrice ?? this.offerPrice,
      translateId: translateId ?? this.translateId,
      size: size ?? this.size,
      price: price ?? this.price,
      shortDescription: shortDescription ?? this.shortDescription,
      storeProductState: storeProductState ?? this.storeProductState,
    );
  }

  /// for API body (MultipartRequest fields are always String)
  Map<String, String> toMap() {
    return {
      'name': name,
      'slug': slug,
      'category_id': categoryId,
      'addon': addonId,
      'product_price': productPrice,
      'offer_price': offerPrice,
      'translate_id': translateId,
      'size': jsonEncode(size),
      'price': jsonEncode(price),
      'short_description': shortDescription,
    };
  }

  factory StoreProductStateModel.fromMap(Map<String, dynamic> map) {
    return StoreProductStateModel(
      name: map['name'] ?? '',
      slug: map['slug'] ?? '',
      categoryId: map['category_id']?.toString() ?? '',
      addonId: map['addon']?.toString() ?? '',
      image: map['image'] ?? '',
      productPrice: map['product_price']?.toString() ?? '0',
      offerPrice: map['offer_price']?.toString() ?? '0',
      translateId: map['translate_id']?.toString() ?? '0',
      size:
          map['size'] != null ? List<String>.from(jsonDecode(map['size'])) : [],
      price: map['price'] != null
          ? List<String>.from(jsonDecode(map['price']))
          : [],
      shortDescription: map['short_description'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory StoreProductStateModel.fromJson(String source) =>
      StoreProductStateModel.fromMap(json.decode(source));

  @override
  List<Object?> get props => [
        name,
        slug,
        categoryId,
        addonId,
        image,
        productPrice,
        offerPrice,
        translateId,
        size,
        price,
        shortDescription,
        storeProductState,
      ];
}
