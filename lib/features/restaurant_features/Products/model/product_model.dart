import 'dart:convert';
import 'package:equatable/equatable.dart';
import '../../RestaurantDashboard/model/res_dashboard_model.dart';

class ProductModel extends Equatable {
  final List<ProductList>? productList;

  const ProductModel({this.productList});

  ProductModel copyWith({List<ProductList>? productList}) {
    return ProductModel(
      productList: productList ?? this.productList,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'product_list': productList?.map((x) => x.toMap()).toList(),
    };
  }

  factory ProductModel.fromMap(Map<String, dynamic> map) {
    return ProductModel(
      productList: map['product_list'] != null
          ? List<ProductList>.from(
          map['product_list'].map((x) => ProductList.fromMap(x)))
          : [],
    );
  }

  String toJson() => json.encode(toMap());

  factory ProductModel.fromJson(String source) =>
      ProductModel.fromMap(json.decode(source));

  @override
  bool get stringify => true;

  @override
  List<Object?> get props => [productList];
}

class ProductList extends Equatable {
  final int? id;
  final String? slug;
  final String? image;
  final String? categoryId;
  final String? restaurantId;
  final String? price;
  final String? offerPrice;
  final String? status;
  final String? addonItems;
  final String? createdAt;
  final String? updatedAt;
  final String? isFeatured;
  final String? name;
  final String? shortDescription;
  final String? size;
  final TranslateProduct? translateProduct;
  final Category? category;
  final Restaurant? restaurant;
  final Offer? offer;
  final List<Item>? orderItems;
  final List<Reviews>? reviews;

  const ProductList({
    this.id,
    this.slug,
    this.image,
    this.categoryId,
    this.restaurantId,
    this.price,
    this.offerPrice,
    this.status,
    this.addonItems,
    this.createdAt,
    this.updatedAt,
    this.isFeatured,
    this.name,
    this.shortDescription,
    this.size,
    this.translateProduct,
    this.category,
    this.restaurant,
    this.offer,
    this.orderItems,
    this.reviews,
  });

  ProductList copyWith({
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
    TranslateProduct? translateProduct,
    Category? category,
    Restaurant? restaurant,
    Offer? offer,
    List<Item>? orderItems,
    List<Reviews>? reviews,
  }) {
    return ProductList(
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
      translateProduct: translateProduct ?? this.translateProduct,
      category: category ?? this.category,
      restaurant: restaurant ?? this.restaurant,
      offer: offer ?? this.offer,
      orderItems: orderItems ?? this.orderItems,
      reviews: reviews ?? this.reviews,
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
      'translate_product': translateProduct?.toMap(),
      'category': category?.toMap(),
      'restaurant': restaurant?.toMap(),
      'offer': offer?.toMap(),
      'order_items': orderItems?.map((x) => x.toMap()).toList(),
      'reviews': reviews?.map((x) => x.toMap()).toList(),
    };
  }

  factory ProductList.fromMap(Map<String, dynamic> map) {
    return ProductList(
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
      translateProduct: map['translate_product'] != null
          ? TranslateProduct.fromMap(map['translate_product'])
          : null,
      category:
          map['category'] != null ? Category.fromMap(map['category']) : null,
      restaurant: map['restaurant'] != null
          ? Restaurant.fromMap(map['restaurant'])
          : null,
      offer: map['offer'] != null ? Offer.fromMap(map['offer']) : null,
      orderItems: map['order_items'] != null
          ? List<Item>.from(
              (map['order_items'] as List).map((x) => Item.fromMap(x)))
          : null,
      reviews: map['reviews'] != null
          ? List<Reviews>.from(
              (map['reviews'] as List).map((x) => Reviews.fromMap(x)))
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory ProductList.fromJson(String source) =>
      ProductList.fromMap(json.decode(source));

  @override
  bool get stringify => true;

  @override
  List<Object?> get props => [
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
        translateProduct,
        category,
        restaurant,
        offer,
        orderItems,
        reviews,
      ];
}

class TranslateProduct extends Equatable {
  final int? id;
  final String? productId;
  final String? langCode;
  final String? name;
  final String? shortDescription;
  final String? size;
  final String? specification;
  final String? createdAt;
  final String? updatedAt;

  const TranslateProduct({
    this.id,
    this.productId,
    this.langCode,
    this.name,
    this.shortDescription,
    this.size,
    this.specification,
    this.createdAt,
    this.updatedAt,
  });

  TranslateProduct copyWith({
    int? id,
    String? productId,
    String? langCode,
    String? name,
    String? shortDescription,
    String? size,
    String? specification,
    String? createdAt,
    String? updatedAt,
  }) {
    return TranslateProduct(
      id: id ?? this.id,
      productId: productId ?? this.productId,
      langCode: langCode ?? this.langCode,
      name: name ?? this.name,
      shortDescription: shortDescription ?? this.shortDescription,
      size: size ?? this.size,
      specification: specification ?? this.specification,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
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

  factory TranslateProduct.fromMap(Map<String, dynamic> map) {
    return TranslateProduct(
      id: map['id'] ?? 0,
      productId: map['product_id'] ?? 0,
      langCode: map['lang_code'] ?? 0,
      name: map['name'] ?? '',
      shortDescription: map['short_description'] ?? '',
      size: map['size'] ?? '',
      specification: map['specification'] ?? '',
      createdAt: map['created_at'] ?? '',
      updatedAt: map['updated_at'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory TranslateProduct.fromJson(String source) =>
      TranslateProduct.fromMap(json.decode(source));

  @override
  bool get stringify => true;

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

class Category extends Equatable {
  final int? id;
  final String? slug;
  final String? status;
  final String? createdAt;
  final String? updatedAt;
  final String? icon;
  final String? name;

  const Category({
    this.id,
    this.slug,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.icon,
    this.name,
  });

  Category copyWith({
    int? id,
    String? slug,
    String? status,
    String? createdAt,
    String? updatedAt,
    String? icon,
    String? name,
  }) {
    return Category(
      id: id ?? this.id,
      slug: slug ?? this.slug,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      icon: icon ?? this.icon,
      name: name ?? this.name,
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
      'name': name,
    };
  }

  factory Category.fromMap(Map<String, dynamic> map) {
    return Category(
      id: map['id'] ?? 0,
      slug: map['slug'] ?? '',
      status: map['status'] ?? '',
      createdAt: map['created_at'] ?? '',
      updatedAt: map['updated_at'] ?? '',
      icon: map['icon'] ?? '',
      name: map['name'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory Category.fromJson(String source) =>
      Category.fromMap(json.decode(source));

  @override
  bool get stringify => true;

  @override
  List<Object?> get props =>
      [id, slug, status, createdAt, updatedAt, icon, name];
}

class Offer extends Equatable {
  final int? id;
  final String? productId;
  final String? status;
  final String? createdAt;
  final String? updatedAt;

  const Offer({
    this.id,
    this.productId,
    this.status,
    this.createdAt,
    this.updatedAt,
  });

  Offer copyWith({
    int? id,
    String? productId,
    String? status,
    String? createdAt,
    String? updatedAt,
  }) {
    return Offer(
      id: id ?? this.id,
      productId: productId ?? this.productId,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'product_id': productId,
      'status': status,
      'created_at': createdAt,
      'updated_at': updatedAt,
    };
  }

  factory Offer.fromMap(Map<String, dynamic> map) {
    return Offer(
      id: map['id'] ?? 0,
      productId: map['product_id'] ?? 0,
      status: map['status'] ?? '',
      createdAt: map['created_at'] ?? '',
      updatedAt: map['updated_at'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory Offer.fromJson(String source) => Offer.fromMap(json.decode(source));

  @override
  bool get stringify => true;

  @override
  List<Object?> get props => [id, productId, status, createdAt, updatedAt];
}

class Reviews extends Equatable {
  final int? id;
  final String? userId;
  final String? orderId;
  final String? productId;
  final String? review;
  final String? rating;
  final String? status;
  final String? createdAt;
  final String? updatedAt;
  final String? restaurantId;

  const Reviews({
    this.id,
    this.userId,
    this.orderId,
    this.productId,
    this.review,
    this.rating,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.restaurantId,
  });

  Reviews copyWith({
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
  }) {
    return Reviews(
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
    };
  }

  factory Reviews.fromMap(Map<String, dynamic> map) {
    return Reviews(
      id: map['id'] ?? 0,
      userId: map['user_id'] ?? 0,
      orderId: map['order_id'] ?? 0,
      productId: map['product_id'] ?? 0,
      review: map['review'] ?? '',
      rating: map['rating'] ?? '',
      status: map['status'] ?? '',
      createdAt: map['created_at'] ?? '',
      updatedAt: map['updated_at'] ?? '',
      restaurantId: map['restaurant_id'] ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory Reviews.fromJson(String source) =>
      Reviews.fromMap(json.decode(source));

  @override
  bool get stringify => true;

  @override
  List<Object?> get props => [
        id,
        userId,
        orderId,
        productId,
        review,
        rating,
        status,
        createdAt,
        updatedAt,
        restaurantId
      ];
}
