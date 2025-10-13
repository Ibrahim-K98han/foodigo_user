// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:equatable/equatable.dart';

class ProductData extends Equatable {
  final User? user;
  final List<Categories>? categories;
  final List<FeatureAddons>? addons;
  final ProductUpdate? product;
  final List<int>? selectedIds;
  final ProductTranslate? productTranslate;

  const ProductData({
    this.user,
    this.categories,
    this.addons,
    this.product,
    this.selectedIds,
    this.productTranslate,
  });

  ProductData copyWith({
    User? user,
    List<Categories>? categories,
    List<FeatureAddons>? addons,
    ProductUpdate? product,
    List<int>? selectedIds,
    ProductTranslate? productTranslate,
  }) {
    return ProductData(
      user: user ?? this.user,
      categories: categories ?? this.categories,
      addons: addons ?? this.addons,
      product: product ?? this.product,
      selectedIds: selectedIds ?? this.selectedIds,
      productTranslate: productTranslate ?? this.productTranslate,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'user': user?.toMap(),
      'categories': categories?.map((x) => x.toMap()).toList(),
      'addons': addons?.map((x) => x.toMap()).toList(),
      'product': product?.toMap(),
      'selected_ids': selectedIds,
      'product_translate': productTranslate?.toMap(),
    };
  }

  factory ProductData.fromMap(Map<String, dynamic> map) {
    return ProductData(
      user: map['user'] != null
          ? User.fromMap(map['user'] as Map<String, dynamic>)
          : null,
      categories: map['categories'] != null
          ? List<Categories>.from(
              (map['categories'] as List).map(
                (x) => Categories.fromMap(x as Map<String, dynamic>),
              ),
            )
          : null,
      addons: map['addons'] != null
          ? List<FeatureAddons>.from(
        (map['addons'] as List).map(
              (x) => FeatureAddons.fromMap(x as Map<String, dynamic>),
        ),
      )
          : null,
      product: map['product'] != null
          ? ProductUpdate.fromMap(map['product'] as Map<String, dynamic>)
          : null,
      selectedIds: map['selected_ids'] != null
          ? List<int>.from(map['selected_ids'] as List)
          : null,
      productTranslate: map['product_translate'] != null
          ? ProductTranslate.fromMap(
              map['product_translate'] as Map<String, dynamic>,
            )
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory ProductData.fromJson(String source) =>
      ProductData.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;

  @override
  List<Object?> get props => [
        user,
        categories,
        addons,
        product,
        selectedIds,
        productTranslate,
      ];
}

class User extends Equatable {
  final int id;
  final String logo;
  final String coverImage;
  final String restaurantName;
  final String slug;
  final String cityId;
  final String cuisines;
  final String whatsapp;
  final String address;
  final String latitude;
  final String longitude;
  final String maxDeliveryDistance;
  final String ownerName;
  final String ownerEmail;
  final String ownerPhone;
  final String name;
  final String email;
  final String password;
  final String openingHour;
  final String closingHour;
  final String minProcessingTime;
  final String maxProcessingTime;
  final String timeSlotSeparate;
  final String tags;
  final String isFeatured;
  final String isPickupOrder;
  final String isDeliveryOrder;
  final String adminApproval;
  final String isBanned;
  final String forgetPasswordToken;
  final String createdAt;
  final String updatedAt;
  final String isTrusted;

  const User({
    required this.id,
    required this.logo,
    required this.coverImage,
    required this.restaurantName,
    required this.slug,
    required this.cityId,
    required this.cuisines,
    required this.whatsapp,
    required this.address,
    required this.latitude,
    required this.longitude,
    required this.maxDeliveryDistance,
    required this.ownerName,
    required this.ownerEmail,
    required this.ownerPhone,
    required this.name,
    required this.email,
    required this.password,
    required this.openingHour,
    required this.closingHour,
    required this.minProcessingTime,
    required this.maxProcessingTime,
    required this.timeSlotSeparate,
    required this.tags,
    required this.isFeatured,
    required this.isPickupOrder,
    required this.isDeliveryOrder,
    required this.adminApproval,
    required this.isBanned,
    required this.forgetPasswordToken,
    required this.createdAt,
    required this.updatedAt,
    required this.isTrusted,
  });

  User copyWith({
    int? id,
    String? logo,
    String? coverImage,
    String? restaurantName,
    String? slug,
    String? cityId,
    String? cuisines,
    String? whatsapp,
    String? address,
    String? latitude,
    String? longitude,
    String? maxDeliveryDistance,
    String? ownerName,
    String? ownerEmail,
    String? ownerPhone,
    String? name,
    String? email,
    String? password,
    String? openingHour,
    String? closingHour,
    String? minProcessingTime,
    String? maxProcessingTime,
    String? timeSlotSeparate,
    String? tags,
    String? isFeatured,
    String? isPickupOrder,
    String? isDeliveryOrder,
    String? adminApproval,
    String? isBanned,
    String? forgetPasswordToken,
    String? createdAt,
    String? updatedAt,
    String? isTrusted,
  }) {
    return User(
      id: id ?? this.id,
      logo: logo ?? this.logo,
      coverImage: coverImage ?? this.coverImage,
      restaurantName: restaurantName ?? this.restaurantName,
      slug: slug ?? this.slug,
      cityId: cityId ?? this.cityId,
      cuisines: cuisines ?? this.cuisines,
      whatsapp: whatsapp ?? this.whatsapp,
      address: address ?? this.address,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      maxDeliveryDistance: maxDeliveryDistance ?? this.maxDeliveryDistance,
      ownerName: ownerName ?? this.ownerName,
      ownerEmail: ownerEmail ?? this.ownerEmail,
      ownerPhone: ownerPhone ?? this.ownerPhone,
      name: name ?? this.name,
      email: email ?? this.email,
      password: password ?? this.password,
      openingHour: openingHour ?? this.openingHour,
      closingHour: closingHour ?? this.closingHour,
      minProcessingTime: minProcessingTime ?? this.minProcessingTime,
      maxProcessingTime: maxProcessingTime ?? this.maxProcessingTime,
      timeSlotSeparate: timeSlotSeparate ?? this.timeSlotSeparate,
      tags: tags ?? this.tags,
      isFeatured: isFeatured ?? this.isFeatured,
      isPickupOrder: isPickupOrder ?? this.isPickupOrder,
      isDeliveryOrder: isDeliveryOrder ?? this.isDeliveryOrder,
      adminApproval: adminApproval ?? this.adminApproval,
      isBanned: isBanned ?? this.isBanned,
      forgetPasswordToken: forgetPasswordToken ?? this.forgetPasswordToken,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      isTrusted: isTrusted ?? this.isTrusted,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'logo': logo,
      'cover_image': coverImage,
      'restaurant_name': restaurantName,
      'slug': slug,
      'city_id': cityId,
      'cuisines': cuisines,
      'whatsapp': whatsapp,
      'address': address,
      'latitude': latitude,
      'longitude': longitude,
      'max_delivery_distance': maxDeliveryDistance,
      'owner_name': ownerName,
      'owner_email': ownerEmail,
      'owner_phone': ownerPhone,
      'name': name,
      'email': email,
      'password': password,
      'opening_hour': openingHour,
      'closing_hour': closingHour,
      'min_processing_time': minProcessingTime,
      'max_processing_time': maxProcessingTime,
      'time_slot_separate': timeSlotSeparate,
      'tags': tags,
      'is_featured': isFeatured,
      'is_pickup_order': isPickupOrder,
      'is_delivery_order': isDeliveryOrder,
      'admin_approval': adminApproval,
      'is_banned': isBanned,
      'forget_password_token': forgetPasswordToken,
      'created_at': createdAt,
      'updated_at': updatedAt,
      'is_trusted': isTrusted,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['id'] ?? 0,
      logo: map['logo'] ?? '',
      coverImage: map['cover_image'] ?? '',
      restaurantName: map['restaurant_name'] ?? '',
      slug: map['slug'] ?? '',
      cityId: map['city_id'] ?? '',
      cuisines: map['cuisines'] ?? '',
      whatsapp: map['whatsapp'] ?? '',
      address: map['address'] ?? '',
      latitude: map['latitude'] ?? '',
      longitude: map['longitude'] ?? '',
      maxDeliveryDistance: map['max_delivery_distance'] ?? '',
      ownerName: map['owner_name'] ?? '',
      ownerEmail: map['owner_email'] ?? '',
      ownerPhone: map['owner_phone'] ?? '',
      name: map['name'] ?? '',
      email: map['email'] ?? '',
      password: map['password'] ?? '',
      openingHour: map['opening_hour'] ?? '',
      closingHour: map['closing_hour'] ?? '',
      minProcessingTime: map['min_processing_time'] ?? '',
      maxProcessingTime: map['max_processing_time'] ?? '',
      timeSlotSeparate: map['time_slot_separate'] ?? '',
      tags: map['tags'] ?? '',
      isFeatured: map['is_featured'] ?? '',
      isPickupOrder: map['is_pickup_order'] ?? '',
      isDeliveryOrder: map['is_delivery_order'] ?? '',
      adminApproval: map['admin_approval'] ?? '',
      isBanned: map['is_banned'] ?? '',
      forgetPasswordToken: map['forget_password_token'] ?? '',
      createdAt: map['created_at'] ?? '',
      updatedAt: map['updated_at'] ?? '',
      isTrusted: map['is_trusted'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) =>
      User.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;

  @override
  List<Object> get props {
    return [
      id,
      logo,
      coverImage,
      restaurantName,
      slug,
      cityId,
      cuisines,
      whatsapp,
      address,
      latitude,
      longitude,
      maxDeliveryDistance,
      ownerName,
      ownerEmail,
      ownerPhone,
      name,
      email,
      password,
      openingHour,
      closingHour,
      minProcessingTime,
      maxProcessingTime,
      timeSlotSeparate,
      tags,
      isFeatured,
      isPickupOrder,
      isDeliveryOrder,
      adminApproval,
      isBanned,
      forgetPasswordToken,
      createdAt,
      updatedAt,
      isTrusted,
    ];
  }
}

class Categories extends Equatable {
  final int id;
  final String slug;
  final String status;
  final String createdAt;
  final String updatedAt;
  final String icon;
  final String name;

  const Categories({
    required this.id,
    required this.slug,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    required this.icon,
    required this.name,
  });

  Categories copyWith({
    int? id,
    String? slug,
    String? status,
    String? createdAt,
    String? updatedAt,
    String? icon,
    String? name,
  }) {
    return Categories(
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

  factory Categories.fromMap(Map<String, dynamic> map) {
    return Categories(
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

  factory Categories.fromJson(String source) =>
      Categories.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;

  @override
  List<Object> get props {
    return [
      id,
      slug,
      status,
      createdAt,
      updatedAt,
      icon,
      name,
    ];
  }
}

class Addons extends Equatable {
  final int id;
  final String restaurantId;
  final String price;
  final String status;
  final String createdAt;
  final String updatedAt;
  final String name;
  final User? restaurant;

  const Addons({
    required this.id,
    required this.restaurantId,
    required this.price,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    required this.name,
    this.restaurant,
  });

  Addons copyWith({
    int? id,
    String? restaurantId,
    String? price,
    String? status,
    String? createdAt,
    String? updatedAt,
    String? name,
    User? restaurant,
  }) {
    return Addons(
      id: id ?? this.id,
      restaurantId: restaurantId ?? this.restaurantId,
      price: price ?? this.price,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      name: name ?? this.name,
      restaurant: restaurant ?? this.restaurant,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'restaurant_id': restaurantId,
      'price': price,
      'status': status,
      'created_at': createdAt,
      'updated_at': updatedAt,
      'name': name,
      'restaurant': restaurant?.toMap(),
    };
  }

  factory Addons.fromMap(Map<String, dynamic> map) {
    return Addons(
      id: map['id'] ?? 0,
      restaurantId: map['restaurant_id'] ?? '',
      price: map['price'] ?? '',
      status: map['status'] ?? '',
      createdAt: map['created_at'] ?? '',
      updatedAt: map['updated_at'] ?? '',
      name: map['name'] ?? '',
      restaurant: map['restaurant'] != null
          ? User.fromMap(map['restaurant'] as Map<String, dynamic>)
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Addons.fromJson(String source) =>
      Addons.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;

  @override
  List<Object> get props {
    return [
      id,
      restaurantId,
      price,
      status,
      createdAt,
      updatedAt,
      name,
      restaurant!,
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

class ProductUpdate extends Equatable {
  final int id;
  final String slug;
  final String image;
  final String categoryId;
  final String restaurantId;
  final String price;
  final String offerPrice;
  final String status;
  final String addonItems;
  final List<FeatureAddons>? addons;
  final String createdAt;
  final String updatedAt;
  final String isFeatured;
  final String name;
  final String shortDescription;
  final String size;

  const ProductUpdate({
    required this.id,
    required this.slug,
    required this.image,
    required this.categoryId,
    required this.restaurantId,
    required this.price,
    required this.offerPrice,
    required this.status,
    required this.addonItems,
    this.addons,
    required this.createdAt,
    required this.updatedAt,
    required this.isFeatured,
    required this.name,
    required this.shortDescription,
    required this.size,
  });

  ProductUpdate copyWith({
    int? id,
    String? slug,
    String? image,
    String? categoryId,
    String? restaurantId,
    String? price,
    String? offerPrice,
    String? status,
    String? addonItems,
    List<FeatureAddons>? addons,
    String? createdAt,
    String? updatedAt,
    String? isFeatured,
    String? name,
    String? shortDescription,
    String? size,
  }) {
    return ProductUpdate(
      id: id ?? this.id,
      slug: slug ?? this.slug,
      image: image ?? this.image,
      categoryId: categoryId ?? this.categoryId,
      restaurantId: restaurantId ?? this.restaurantId,
      price: price ?? this.price,
      offerPrice: offerPrice ?? this.offerPrice,
      status: status ?? this.status,
      addonItems: addonItems ?? this.addonItems,
      addons: addons ?? this.addons,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      isFeatured: isFeatured ?? this.isFeatured,
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
      'addons': addons?.map((x) => x.toMap()).toList(),
      'created_at': createdAt,
      'updated_at': updatedAt,
      'is_featured': isFeatured,
      'name': name,
      'short_description': shortDescription,
      'size': size,
    };
  }

  factory ProductUpdate.fromMap(Map<String, dynamic> map) {
    return ProductUpdate(
      id: map['id'] ?? 0,
      slug: map['slug'] ?? '',
      image: map['image'] ?? '',
      categoryId: map['category_id'] ?? '',
      restaurantId: map['restaurant_id'] ?? '',
      price: map['price'] ?? '',
      offerPrice: map['offer_price'] ?? '',
      status: map['status'] ?? '',
      addonItems: map['addon_items'] ?? '',
      addons: map['addons'] != null
          ? List<FeatureAddons>.from(
        (map['addons'] as List).map(
              (x) => FeatureAddons.fromMap(x as Map<String, dynamic>),
        ),
      )
          : null,
      createdAt: map['created_at'] ?? '',
      updatedAt: map['updated_at'] ?? '',
      isFeatured: map['is_featured'] ?? '',
      name: map['name'] ?? '',
      shortDescription: map['short_description'] ?? '',
      size: map['size'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory ProductUpdate.fromJson(String source) =>
      ProductUpdate.fromMap(json.decode(source) as Map<String, dynamic>);

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
      addons!,
      createdAt,
      updatedAt,
      isFeatured,
      name,
      shortDescription,
      size,
    ];
  }
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

  ProductTranslate copyWith({
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
    return ProductTranslate(
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

  factory ProductTranslate.fromMap(Map<String, dynamic> map) {
    return ProductTranslate(
      id: map['id'] ?? 0,
      productId: map['product_id'] ?? '',
      langCode: map['lang_code'] ?? '',
      name: map['name'] ?? '',
      shortDescription: map['short_description'] ?? '',
      size: map['size'] ?? '',
      specification: map['specification'] ?? '',
      createdAt: map['created_at'] ?? '',
      updatedAt: map['updated_at'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory ProductTranslate.fromJson(String source) =>
      ProductTranslate.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;

  @override
  List<Object> get props {
    return [
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
}
