import 'dart:convert';
import 'package:equatable/equatable.dart';
import 'package:foodigo/features/SingleRestaurant/model/single_restaurant_model.dart';

class StoreProductResponseModel extends Equatable {
  final Data? data;
  final String message;

  const StoreProductResponseModel({
    this.data,
    this.message = '',
  });

  factory StoreProductResponseModel.fromMap(Map<String, dynamic> map) {
    return StoreProductResponseModel(
      data: map['data'] is Map<String, dynamic>
          ? Data.fromMap(map['data'])
          : null,
      message: map['message'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'data': data?.toMap(),
      'message': message,
    };
  }

  String toJson() => json.encode(toMap());

  factory StoreProductResponseModel.fromJson(String source) =>
      StoreProductResponseModel.fromMap(json.decode(source));

  @override
  List<Object?> get props => [data, message];
}

class Data extends Equatable {
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
  final ProductTranslate? productTranslate;

  const Data({
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
    required this.productTranslate,
  });

  Data copyWith({
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
    Products? products,
    ProductTranslate? productTranslate,
  }) {
    return Data(
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
      productTranslate: productTranslate ?? this.productTranslate,
    );
  }

  factory Data.fromMap(Map<String, dynamic> map) {
    return Data(
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
      productTranslate: map['product_translate'] != null
          ? ProductTranslate.fromMap(map['product_translate'])
          : null,
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
      'product_translate': productTranslate?.toMap(),
    };
  }

  String toJson() => json.encode(toMap());

  factory Data.fromJson(String source) => Data.fromMap(json.decode(source));

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
        productTranslate,
      ];
}

class ProductTranslate extends Equatable {
  final int id;
  final String productId;
  final String langCode;
  final String name;
  final String shortDescription;
  final String size;
  final String specification;
  final String createdAt;
  final String updatedAt;

  const ProductTranslate({
    required this.id,
    required this.productId,
    required this.langCode,
    required this.name,
    required this.shortDescription,
    required this.size,
    required this.specification,
    required this.createdAt,
    required this.updatedAt,
  });

  /// Safe empty factory
  const ProductTranslate.empty()
      : id = 0,
        productId = '',
        langCode = '',
        name = '',
        shortDescription = '',
        size = '',
        specification = '',
        createdAt = '',
        updatedAt = '';

  factory ProductTranslate.fromMap(Map<String, dynamic> map) {
    return ProductTranslate(
      id: map['id'] ?? 0,
      productId: map['product_id']?.toString() ?? '',
      langCode: map['lang_code'] ?? '',
      name: map['name'] ?? '',
      shortDescription: map['short_description'] ?? '',
      size: map['size'] ?? '',
      specification: map['specification'] ?? '',
      createdAt: map['created_at'] ?? '',
      updatedAt: map['updated_at'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'product_id': productId,
      'lang_code': langCode,
      'name': name,
      'short_description': shortDescription,
      'size': size,
      'specification': specification,
      'created_at': createdAt,
      'updated_at': updatedAt,
    };
  }

  String toJson() => json.encode(toMap());

  factory ProductTranslate.fromJson(String source) =>
      ProductTranslate.fromMap(json.decode(source));

  @override
  List<Object?> get props => [
        id,
        productId,
        langCode,
        name,
        shortDescription,
        size,
        specification,
        createdAt,
        updatedAt,
      ];
}
