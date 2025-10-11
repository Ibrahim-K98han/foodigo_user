// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:equatable/equatable.dart';

class RestaurantProfileModel extends Equatable {
  final String message;
  final RestaurantProfile? restaurantProfile;
  final List<Cities>? cities;
  final List<Cuisines>? cuisines;

  const RestaurantProfileModel({
    required this.message,
    this.restaurantProfile,
    this.cities,
    this.cuisines,
  });

  RestaurantProfileModel copyWith({
    String? message,
    RestaurantProfile? restaurantProfile,
    List<Cities>? cities,
    List<Cuisines>? cuisines,
  }) {
    return RestaurantProfileModel(
      message: message ?? this.message,
      restaurantProfile: restaurantProfile ?? this.restaurantProfile,
      cities: cities ?? this.cities,
      cuisines: cuisines ?? this.cuisines,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'message':message,
      'restaurant': restaurantProfile?.toMap(),
      'cities': cities?.map((x) => x.toMap()).toList(),
      'cuisines': cuisines?.map((x) => x.toMap()).toList(),
    };
  }

  factory RestaurantProfileModel.fromMap(Map<String, dynamic> map) {
    return RestaurantProfileModel(
      message: map['message'] ?? '',
      restaurantProfile:
          map['restaurant'] != null
              ? RestaurantProfile.fromMap(
                map['restaurant'] as Map<String, dynamic>,
              )
              : null,
      cities:
          map['cities'] != null
              ? List<Cities>.from(
                (map['cities'] as List<dynamic>).map<Cities?>(
                  (x) => Cities.fromMap(x as Map<String, dynamic>),
                ),
              )
              : null,
      cuisines:
          map['cuisines'] != null
              ? List<Cuisines>.from(
                (map['cuisines'] as List<dynamic>).map<Cuisines?>(
                  (x) => Cuisines.fromMap(x as Map<String, dynamic>),
                ),
              )
              : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory RestaurantProfileModel.fromJson(String source) =>
      RestaurantProfileModel.fromMap(
        json.decode(source) as Map<String, dynamic>,
      );

  @override
  bool get stringify => true;

  @override
  List<Object> get props => [message,restaurantProfile!, cities!, cuisines!];
}

class RestaurantProfile extends Equatable {
  final String message;
  final int id;
  final String logo;
  final String coverImage;
  final String restaurantName;
  final String slug;
  final String cityId;
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
  final String cuisines;

  const RestaurantProfile({
    required this.message,
    required this.id,
    required this.logo,
    required this.coverImage,
    required this.restaurantName,
    required this.slug,
    required this.cityId,
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
    required this.cuisines,
  });

  RestaurantProfile copyWith({
    String? message,
    int? id,
    String? logo,
    String? coverImage,
    String? restaurantName,
    String? slug,
    String? cityId,
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
    String? cuisines,
  }) {
    return RestaurantProfile(

      message: message ?? this.message,
      id: id ?? this.id,
      logo: logo ?? this.logo,
      coverImage: coverImage ?? this.coverImage,
      restaurantName: restaurantName ?? this.restaurantName,
      slug: slug ?? this.slug,
      cityId: cityId ?? this.cityId,
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
      cuisines: cuisines ?? this.cuisines,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'message':message,
      'id': id,
      'logo': logo,
      'cover_image': coverImage,
      'restaurant_name': restaurantName,
      'slug': slug,
      'city_id': cityId,
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
      'cuisines': cuisines,
    };
  }

  factory RestaurantProfile.fromMap(Map<String, dynamic> map) {
    return RestaurantProfile(
      message: map['message'] ?? '',
      id: map['id'] ?? 0,
      logo: map['logo'] ?? '',
      coverImage: map['cover_image'] ?? '',
      restaurantName: map['restaurant_name'] ?? '',
      slug: map['slug'] ?? '',
      cityId: map['city_id'] ?? '',
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
      cuisines: map['cuisines'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory RestaurantProfile.fromJson(String source) =>
      RestaurantProfile.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;

  @override
  List<Object> get props {
    return [
      message,
      id,
      logo,
      coverImage,
      restaurantName,
      slug,
      cityId,
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
      cuisines,
    ];
  }
}

class Cities extends Equatable {
  final int id;
  final String createdAt;
  final String updatedAt;
  final String image;
  final String name;
  final List<CitiesTranslate>? citiesTranslate;

  const Cities({
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    required this.image,
    required this.name,
    this.citiesTranslate,
  });

  Cities copyWith({
    int? id,
    String? createdAt,
    String? updatedAt,
    String? image,
    String? name,
    List<CitiesTranslate>? citiesTranslate,
  }) {
    return Cities(
      id: id ?? this.id,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      image: image ?? this.image,
      name: name ?? this.name,
      citiesTranslate: citiesTranslate ?? this.citiesTranslate,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'created_at': createdAt,
      'updated_at': updatedAt,
      'image': image,
      'name': name,
      'cities_translate': citiesTranslate?.map((x) => x.toMap()).toList(),
    };
  }

  factory Cities.fromMap(Map<String, dynamic> map) {
    return Cities(
      id: map['id'] ?? 0,
      createdAt: map['created_at'] ?? '',
      updatedAt: map['updated_at'] ?? '',
      image: map['image'] ?? '',
      name: map['name'] ?? '',
      citiesTranslate:
          map['cities_translate'] != null
              ? List<CitiesTranslate>.from(
                (map['cities_translate'] as List<dynamic>).map(
                  (x) => CitiesTranslate.fromMap(x),
                ),
              )
              : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Cities.fromJson(String source) =>
      Cities.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;

  @override
  List<Object?> get props {
    return [id, createdAt, updatedAt, image, name, citiesTranslate];
  }
}

class CitiesTranslate extends Equatable {
  final int id;
  final String cityId;
  final String langCode;
  final String name;
  final String createdAt;
  final String updatedAt;

  const CitiesTranslate({
    required this.id,
    required this.cityId,
    required this.langCode,
    required this.name,
    required this.createdAt,
    required this.updatedAt,
  });

  CitiesTranslate copyWith({
    int? id,
    String? cityId,
    String? langCode,
    String? name,
    String? createdAt,
    String? updatedAt,
  }) {
    return CitiesTranslate(
      id: id ?? this.id,
      cityId: cityId ?? this.cityId,
      langCode: langCode ?? this.langCode,
      name: name ?? this.name,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'city_id': cityId,
      'lang_code': langCode,
      'name': name,
      'created_at': createdAt,
      'updated_at': updatedAt,
    };
  }

  factory CitiesTranslate.fromMap(Map<String, dynamic> map) {
    return CitiesTranslate(
      id: map['id'] ?? 0,
      cityId: map['city_id'] ?? '',
      langCode: map['lang_code'] ?? '',
      name: map['name'] ?? '',
      createdAt: map['created_at'] ?? '',
      updatedAt: map['updated_at'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory CitiesTranslate.fromJson(String source) =>
      CitiesTranslate.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;

  @override
  List<Object> get props {
    return [id, cityId, langCode, name, createdAt, updatedAt];
  }
}

class Cuisines extends Equatable {
  final int id;
  final String slug;
  final String icon;
  final String status;
  final String createdAt;
  final String updatedAt;
  final String name;
  final List<CuisinesTranslate>? cuisinesTranslate;

  const Cuisines({
    required this.id,
    required this.slug,
    required this.icon,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    required this.name,
    this.cuisinesTranslate,
  });

  Cuisines copyWith({
    int? id,
    String? slug,
    String? icon,
    String? status,
    String? createdAt,
    String? updatedAt,
    String? name,
    List<CuisinesTranslate>? cuisinesTranslate,
  }) {
    return Cuisines(
      id: id ?? this.id,
      slug: slug ?? this.slug,
      icon: icon ?? this.icon,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      name: name ?? this.name,
      cuisinesTranslate: cuisinesTranslate ?? this.cuisinesTranslate,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'slug': slug,
      'icon': icon,
      'status': status,
      'created_at': createdAt,
      'updated_at': updatedAt,
      'name': name,
      'cuisines_translate': cuisinesTranslate?.map((x) => x.toMap()).toList(),
    };
  }

  factory Cuisines.fromMap(Map<String, dynamic> map) {
    return Cuisines(
      id: map['id'] ?? 0,
      slug: map['slug'] ?? '',
      icon: map['icon'] ?? '',
      status: map['status'] ?? '',
      createdAt: map['created_at'] ?? '',
      updatedAt: map['updated_at'] ?? '',
      name: map['name'] ?? '',
      cuisinesTranslate:
          map['cuisines_translate'] != null
              ? List<CuisinesTranslate>.from(
                (map['cuisines_translate'] as List<dynamic>).map(
                  (x) => CuisinesTranslate.fromMap(x),
                ),
              )
              : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Cuisines.fromJson(String source) =>
      Cuisines.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;

  @override
  List<Object?> get props {
    return [
      id,
      slug,
      icon,
      status,
      createdAt,
      updatedAt,
      name,
      cuisinesTranslate,
    ];
  }
}

class CuisinesTranslate extends Equatable {
  final int id;
  final String cuisineId;
  final String langCode;
  final String name;
  final String createdAt;
  final String updatedAt;

  const CuisinesTranslate({
    required this.id,
    required this.cuisineId,
    required this.langCode,
    required this.name,
    required this.createdAt,
    required this.updatedAt,
  });

  CuisinesTranslate copyWith({
    int? id,
    String? cuisineId,
    String? langCode,
    String? name,
    String? createdAt,
    String? updatedAt,
  }) {
    return CuisinesTranslate(
      id: id ?? this.id,
      cuisineId: cuisineId ?? this.cuisineId,
      langCode: langCode ?? this.langCode,
      name: name ?? this.name,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'cuisine_id': cuisineId,
      'lang_code': langCode,
      'name': name,
      'created_at': createdAt,
      'updated_at': updatedAt,
    };
  }

  factory CuisinesTranslate.fromMap(Map<String, dynamic> map) {
    return CuisinesTranslate(
      id: map['id'] ?? 0,
      cuisineId: map['cuisine_id'] ?? '',
      langCode: map['lang_code'] ?? '',
      name: map['name'] ?? '',
      createdAt: map['created_at'] ?? '',
      updatedAt: map['updated_at'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory CuisinesTranslate.fromJson(String source) =>
      CuisinesTranslate.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;

  @override
  List<Object> get props {
    return [id, cuisineId, langCode, name, createdAt, updatedAt];
  }
}


