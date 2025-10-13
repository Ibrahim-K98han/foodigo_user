import 'dart:convert';

import 'package:equatable/equatable.dart';

import '../cubit/store_product_state.dart';

class StoreProductStateModel extends Equatable {
  final String name;
  final String slug;
  final String categoryId;
  final String image; // file path
  final String productPrice;
  final List<String> size; // ["small", "medium", "large"]
  final List<String> price; // ["20", "40", "60"]
  final String shortDescription;
  final List<String> addonItems; // ["1","2","3"]
  final List<String> specification;
  final String offerPrice;
  final String translateId;
  final StoreProductState storeProductState;

  const StoreProductStateModel({
    this.name = '',
    this.slug = '',
    this.categoryId = '',
    this.image = '',
    this.productPrice = '',
    this.size = const [],
    this.price = const [],
    this.shortDescription = '',
    this.addonItems = const [],
    this.specification = const [],
    this.offerPrice = '',
    this.translateId = '',
    this.storeProductState = const StoreProductInitial(),
  });

  StoreProductStateModel copyWith({
    String? name,
    String? slug,
    String? categoryId,
    String? image,
    String? productPrice,
    List<String>? size,
    List<String>? price,
    String? shortDescription,
    List<String>? addonItems,
    List<String>? specification,
    String? offerPrice,
    String? translateId,
    StoreProductState? storeProductState,
  }) {
    return StoreProductStateModel(
      name: name ?? this.name,
      slug: slug ?? this.slug,
      categoryId: categoryId ?? this.categoryId,
      image: image ?? this.image,
      productPrice: productPrice ?? this.productPrice,
      size: size ?? this.size,
      price: price ?? this.price,
      shortDescription: shortDescription ?? this.shortDescription,
      addonItems: addonItems ?? this.addonItems,
      specification: specification ?? this.specification,
      offerPrice: offerPrice ?? this.offerPrice,
      translateId: translateId ?? this.translateId,
      storeProductState: storeProductState ?? this.storeProductState,
    );
  }

  Map<String, String> toMap() {
    return {
      'name': name,
      'slug': slug,
      'category_id': categoryId,
      'image': image,
      'product_price': productPrice,
      'size': jsonEncode(size),            // stringified list
      'price': jsonEncode(price),          // stringified list
      'short_description': shortDescription,
      'addon_items': jsonEncode(addonItems), // ["1","2","3"]
      'specification': jsonEncode(specification),
      'offer_price': offerPrice,
      'translate_id': translateId,
    };
  }

  factory StoreProductStateModel.fromMap(Map<String, dynamic> map) {
    return StoreProductStateModel(
      name: map['name'] ?? '',
      slug: map['slug'] ?? '',
      categoryId: map['category_id'] ?? '',
      image: map['image'] ?? '',
      productPrice: map['product_price'] ?? '',
      size: map['size'] != null ? List<String>.from(jsonDecode(map['size'])) : [],
      price: map['price'] != null
          ? List<String>.from(jsonDecode(map['price']))
          : [],
      shortDescription: map['short_description'] ?? '',
      addonItems: map['addon_items'] != null
          ? List<String>.from(jsonDecode(map['addon_items']))
          : [],
      specification: map['specification'] != null
          ? List<String>.from(jsonDecode(map['specification']))
          : [],
      offerPrice: map['offer_price']?? '',
      translateId: map['translate_id'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory StoreProductStateModel.fromJson(String source) =>
      StoreProductStateModel.fromMap(json.decode(source));

  @override
  List<Object> get props => [
    name,
    slug,
    categoryId,
    image,
    productPrice,
    size,
    price,
    shortDescription,
    addonItems,
    specification,
    offerPrice,
    translateId,
    storeProductState,
  ];
}



