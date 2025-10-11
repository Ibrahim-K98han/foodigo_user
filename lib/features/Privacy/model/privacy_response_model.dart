// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:equatable/equatable.dart';

class PrivacyResponseModel extends Equatable {
  final int id;
  final String langCode;
  final String description;
  final String createdAt;
  final String updatedAt;
  const PrivacyResponseModel({
    required this.id,
    required this.langCode,
    required this.description,
    required this.createdAt,
    required this.updatedAt,
  });

  PrivacyResponseModel copyWith({
    int? id,
    String? langCode,
    String? description,
    String? createdAt,
    String? updatedAt,
  }) {
    return PrivacyResponseModel(
      id: id ?? this.id,
      langCode: langCode ?? this.langCode,
      description: description ?? this.description,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'lang_code': langCode,
      'description': description,
      'created_at': createdAt,
      'updated_at': updatedAt,
    };
  }

  factory PrivacyResponseModel.fromMap(Map<String, dynamic> map) {
    return PrivacyResponseModel(
      id: map['id'] ?? 0,
      langCode: map['lang_code'] ?? '',
      description: map['description'] ?? '',
      createdAt: map['created_at'] ?? '',
      updatedAt: map['updated_at'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory PrivacyResponseModel.fromJson(String source) =>
      PrivacyResponseModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;

  @override
  List<Object> get props {
    return [id, langCode, description, createdAt, updatedAt];
  }
}

class TermsAndConditionResponseModel extends Equatable {
  final int id;
  final String langCode;
  final String description;
  final String createdAt;
  final String updatedAt;
  const TermsAndConditionResponseModel({
    required this.id,
    required this.langCode,
    required this.description,
    required this.createdAt,
    required this.updatedAt,
  });

  TermsAndConditionResponseModel copyWith({
    int? id,
    String? langCode,
    String? description,
    String? createdAt,
    String? updatedAt,
  }) {
    return TermsAndConditionResponseModel(
      id: id ?? this.id,
      langCode: langCode ?? this.langCode,
      description: description ?? this.description,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'lang_code': langCode,
      'description': description,
      'created_at': createdAt,
      'updated_at': updatedAt,
    };
  }

  factory TermsAndConditionResponseModel.fromMap(Map<String, dynamic> map) {
    return TermsAndConditionResponseModel(
      id: map['id'] ?? 0,
      langCode: map['lang_code'] ?? '',
      description: map['description'] ?? '',
      createdAt: map['created_at'] ?? '',
      updatedAt: map['updated_at'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory TermsAndConditionResponseModel.fromJson(String source) =>
      TermsAndConditionResponseModel.fromMap(
        json.decode(source) as Map<String, dynamic>,
      );

  @override
  bool get stringify => true;

  @override
  List<Object> get props {
    return [id, langCode, description, createdAt, updatedAt];
  }
}

class OfferAndReward extends Equatable {
  final List<DiscountProducts>? discountProducts;
  final List<PopularProducts>? popularProducts;
  final List<Banners>? banners;
  final OfferData? offerData;
  final int offerStatus;
  const OfferAndReward({
    this.discountProducts,
    this.popularProducts,
    this.banners,
    this.offerData,
    required this.offerStatus,
  });

  OfferAndReward copyWith({
    List<DiscountProducts>? discountProducts,
    List<PopularProducts>? popularProducts,
    List<Banners>? banners,
    OfferData? offerData,
    int? offerStatus,
  }) {
    return OfferAndReward(
      discountProducts: discountProducts ?? this.discountProducts,
      popularProducts: popularProducts ?? this.popularProducts,
      banners: banners ?? this.banners,
      offerData: offerData ?? this.offerData,
      offerStatus: offerStatus ?? this.offerStatus,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'discount_products': discountProducts?.map((x) => x.toMap()).toList(),
      'popular_products': popularProducts?.map((x) => x.toMap()).toList(),
      'banners': banners?.map((x) => x.toMap()).toList(),
      'offer_data': offerData?.toMap(),
      'offer_status': offerStatus,
    };
  }

  factory OfferAndReward.fromMap(Map<String, dynamic> map) {
    return OfferAndReward(
      discountProducts:
          map['discount_products'] != null
              ? List<DiscountProducts>.from(
                (map['discount_products'] as List<dynamic>).map<
                  DiscountProducts?
                >((x) => DiscountProducts.fromMap(x as Map<String, dynamic>)),
              )
              : null,
      popularProducts:
          map['popular_products'] != null
              ? List<PopularProducts>.from(
                (map['popular_products'] as List<dynamic>)
                    .map<PopularProducts?>(
                      (x) => PopularProducts.fromMap(x as Map<String, dynamic>),
                    ),
              )
              : null,
      banners:
          map['banners'] != null
              ? List<Banners>.from(
                (map['banners'] as List<dynamic>).map<Banners?>(
                  (x) => Banners.fromMap(x as Map<String, dynamic>),
                ),
              )
              : null,
      offerData:
          map['offer_data'] != null
              ? OfferData.fromMap(map['offer_data'] as Map<String, dynamic>)
              : null,
      offerStatus: map['offer_status'] ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory OfferAndReward.fromJson(String source) =>
      OfferAndReward.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;

  @override
  List<Object> get props {
    return [
      discountProducts!,
      popularProducts!,
      banners!,
      offerData!,
      offerStatus,
    ];
  }
}

class DiscountProducts extends Equatable {
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
  const DiscountProducts({
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

  DiscountProducts copyWith({
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
    return DiscountProducts(
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
      'category-id': categoryId,
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

  factory DiscountProducts.fromMap(Map<String, dynamic> map) {
    return DiscountProducts(
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

  factory DiscountProducts.fromJson(String source) =>
      DiscountProducts.fromMap(json.decode(source) as Map<String, dynamic>);

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

class PopularProducts extends Equatable {
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
  final String orderItemsCount;
  final String name;
  final String shortDescription;
  final String size;
  const PopularProducts({
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
    required this.orderItemsCount,
    required this.name,
    required this.shortDescription,
    required this.size,
  });

  PopularProducts copyWith({
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
    String? orderItemsCount,
    String? name,
    String? shortDescription,
    String? size,
  }) {
    return PopularProducts(
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
      orderItemsCount: orderItemsCount ?? this.orderItemsCount,
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
      'order_items_count': orderItemsCount,
      'name': name,
      'short_description': shortDescription,
      'size': size,
    };
  }

  factory PopularProducts.fromMap(Map<String, dynamic> map) {
    return PopularProducts(
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
      orderItemsCount: map['order_items_count'] ?? '',
      name: map['name'] ?? '',
      shortDescription: map['short_description'] ?? '',
      size: map['size'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory PopularProducts.fromJson(String source) =>
      PopularProducts.fromMap(json.decode(source) as Map<String, dynamic>);

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
      orderItemsCount,
      name,
      shortDescription,
      size,
    ];
  }
}

class Banners extends Equatable {
  final int id;
  final String image;
  final String url;
  final String status;
  final String createdAt;
  final String updatedAt;
  const Banners({
    required this.id,
    required this.image,
    required this.url,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
  });

  Banners copyWith({
    int? id,
    String? image,
    String? url,
    String? status,
    String? createdAt,
    String? updatedAt,
  }) {
    return Banners(
      id: id ?? this.id,
      image: image ?? this.image,
      url: url ?? this.url,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'image': image,
      'url': url,
      'status': status,
      'created_at': createdAt,
      'updated_at': updatedAt,
    };
  }

  factory Banners.fromMap(Map<String, dynamic> map) {
    return Banners(
      id: map['id'] ?? 0,
      image: map['image'] ?? '',
      url: map['url'] ?? '',
      status: map['status'] ?? '',
      createdAt: map['created_at'] ?? '',
      updatedAt: map['updated_at'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory Banners.fromJson(String source) =>
      Banners.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;

  @override
  List<Object> get props {
    return [id, image, url, status, createdAt, updatedAt];
  }
}

class OfferData extends Equatable {
  final int id;
  final String title;
  final String description;
  final String offer;
  final String endTime;
  final String status;
  final String createdAt;
  final String updatedAt;
  const OfferData({
    required this.id,
    required this.title,
    required this.description,
    required this.offer,
    required this.endTime,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
  });

  OfferData copyWith({
    int? id,
    String? title,
    String? description,
    String? offer,
    String? endTime,
    String? status,
    String? createdAt,
    String? updatedAt,
  }) {
    return OfferData(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      offer: offer ?? this.offer,
      endTime: endTime ?? this.endTime,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'title': title,
      'description': description,
      'offer': offer,
      'end_time': endTime,
      'status': status,
      'created_at': createdAt,
      'updated_at': updatedAt,
    };
  }

  factory OfferData.fromMap(Map<String, dynamic> map) {
    return OfferData(
      id: map['id'] ?? 0,
      title: map['title'] ?? '',
      description: map['description'] ?? '',
      offer: map['offer'] ?? '',
      endTime: map['end_time'] ?? '',
      status: map['status'] ?? '',
      createdAt: map['created_at'] ?? '',
      updatedAt: map['updated_at'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory OfferData.fromJson(String source) =>
      OfferData.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;

  @override
  List<Object> get props {
    return [
      id,
      title,
      description,
      offer,
      endTime,
      status,
      createdAt,
      updatedAt,
    ];
  }
}
