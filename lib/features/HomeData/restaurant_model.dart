// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:equatable/equatable.dart';

class Restaurants extends Equatable {
  final int id;
  final String logo;
  final String coverImage;
  final String restaurantName;
  final String slug;
  final int cityId;
  final String cuisines;
  final String whatsapp;
  final String address;
  final double latitude;
  final double longitude;
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
  final int isTrusted;
  final String reviewsAvgRating;
  final int reviewsCount;

  const Restaurants({
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
    required this.reviewsAvgRating,
    required this.reviewsCount,
  });

  Restaurants copyWith({
    int? id,
    String? logo,
    String? coverImage,
    String? restaurantName,
    String? slug,
    int? cityId,
    String? cuisines,
    String? whatsapp,
    String? address,
    double? latitude,
    double? longitude,
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
    int? isTrusted,
    String? reviewsAvgRating,
    int? reviewsCount,
  }) {
    return Restaurants(
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
      reviewsAvgRating: reviewsAvgRating ?? this.reviewsAvgRating,
      reviewsCount: reviewsCount ?? this.reviewsCount,
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
      'reviews_avg_rating': reviewsAvgRating,
      'reviews_count': reviewsCount,
    };
  }

  factory Restaurants.fromMap(Map<String, dynamic> map) {
    return Restaurants(
      id: map['id'] ?? 0,
      logo: map['logo'] ?? '',
      coverImage: map['cover_image'] ?? '',
      restaurantName: map['restaurant_name'] ?? '',
      slug: map['slug'] ?? '',
      cityId: map['city_id'] is int
          ? map['city_id'] as int
          : int.tryParse(map['city_id'].toString()) ?? 0,
      cuisines: map['cuisines'] ?? '',
      whatsapp: map['whatsapp'] ?? '',
      address: map['address'] ?? '',
      latitude: map['latitude'] is double ? map['latitude'] as double : double.tryParse(map['latitude'].toString()) ?? 0,
      longitude: map['longitude'] is double ? map['longitude'] as double : double.tryParse(map['longitude'].toString()) ?? 0,
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
      isTrusted: map['is_trusted'] is int
          ? map['is_trusted'] as int
          : int.tryParse(map['is_trusted'].toString()) ?? 0,
      reviewsAvgRating: map['reviews_avg_rating'] ?? '',
      reviewsCount: map['reviews_count'] is int
          ? map['reviews_count'] as int
          : int.tryParse(map['reviews_count'].toString()) ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory Restaurants.fromJson(String source) =>
      Restaurants.fromMap(json.decode(source) as Map<String, dynamic>);

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
      reviewsAvgRating,
      reviewsCount,
    ];
  }
}
