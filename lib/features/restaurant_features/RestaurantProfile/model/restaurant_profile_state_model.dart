// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:equatable/equatable.dart';

import '../cubit/restaurant_profile_state.dart';

class RestaurantProfileStateModel extends Equatable {
  final String restaurantName;
  final String cityId;
  final List<String> cuisines;
  final String whatsappNumber;
  final String address;
  final String latitude;
  final String longitude;
  final String maxDeliveryDistance;
  final String ownerName;
  final String ownerEmail;
  final String ownerPhoneNumber;
  final String name;
  final String openingHours;
  final String closingHours;
  final String minProcessingTime;
  final String maxProcessingTime;
  final String timeSlotSeparator;
  final String logo;
  final String coverImages;
  final bool isFeatured;
  final bool isPickupOrder;
  final bool isDeliveryOrder;
  final String tags;
  final String slug;
  final RestaurantProfileState restaurantProfileState;

  const RestaurantProfileStateModel({
    this.restaurantName = '',
    this.cityId = '',
    this.cuisines = const [],
    this.whatsappNumber = '',
    this.address = '',
    this.latitude = '',
    this.longitude = '',
    this.maxDeliveryDistance = '',
    this.ownerName = '',
    this.ownerEmail = '',
    this.ownerPhoneNumber = '',
    this.name = '',
    this.openingHours = '',
    this.closingHours = '',
    this.minProcessingTime = '',
    this.maxProcessingTime = '',
    this.timeSlotSeparator = '',
    this.logo = '',
    this.coverImages = '',
    this.isFeatured = false,
    this.isPickupOrder = false,
    this.isDeliveryOrder = false,
    this.tags = '',
    this.slug = '',
    this.restaurantProfileState = const RestaurantProfileInitial(),
  });

  copyWith({
    String? restaurantName,
    String? cityId,
    List<String>? cuisines,
    String? whatsappNumber,
    String? address,
    String? latitude,
    String? longitude,
    String? maxDeliveryDistance,
    String? ownerName,
    String? ownerEmail,
    String? ownerPhoneNumber,
    String? name,
    String? openingHours,
    String? closingHours,
    String? minProcessingTime,
    String? maxProcessingTime,
    String? timeSlotSeparator,
    String? logo,
    String? coverImages,
    bool? isFeatured,
    bool? isPickupOrder,
    bool? isDeliveryOrder,
    String? tags,
    String? slug,
    RestaurantProfileState? restaurantProfileState,
  }) {
    return RestaurantProfileStateModel(
      restaurantName: restaurantName ?? this.restaurantName,
      cityId: cityId ?? this.cityId,
      cuisines: cuisines ?? this.cuisines,
      whatsappNumber: whatsappNumber ?? this.whatsappNumber,
      address: address ?? this.address,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      maxDeliveryDistance: maxDeliveryDistance ?? this.maxDeliveryDistance,
      ownerName: ownerName ?? this.ownerName,
      ownerEmail: ownerEmail ?? this.ownerEmail,
      ownerPhoneNumber: ownerPhoneNumber ?? this.ownerPhoneNumber,
      name: name ?? this.name,
      openingHours: openingHours ?? this.openingHours,
      closingHours: closingHours ?? this.closingHours,
      minProcessingTime: minProcessingTime ?? this.minProcessingTime,
      maxProcessingTime: maxProcessingTime ?? this.maxProcessingTime,
      timeSlotSeparator: timeSlotSeparator ?? this.timeSlotSeparator,
      logo: logo ?? this.logo,
      coverImages: coverImages ?? this.coverImages,
      isFeatured: isFeatured ?? this.isFeatured,
      isPickupOrder: isPickupOrder ?? this.isPickupOrder,
      isDeliveryOrder: isDeliveryOrder ?? this.isDeliveryOrder,
      tags: tags ?? this.tags,
      slug: slug ?? this.slug,
      restaurantProfileState:
          restaurantProfileState ?? this.restaurantProfileState,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'restaurant_name': restaurantName,
      'city_id': cityId,
      'cuisines': cuisines,
      'whatsapp': whatsappNumber,
      'address': address,
      'latitude': latitude,
      'longitude': longitude,
      'max_delivery_distance': maxDeliveryDistance,
      'owner_name': ownerName,
      'owner_email': ownerEmail,
      'owner_phone': ownerPhoneNumber,
      'name': name,
      'opening_hour': openingHours,
      'closing_hour': closingHours,
      'min_processing_time': minProcessingTime,
      'max_processing_time': maxProcessingTime,
      'time_slot_separate': timeSlotSeparator,
      'logo': logo,
      'cover_image': coverImages,
      'is_featured': isFeatured,
      'is_pickup_order': isPickupOrder,
      'is_delivery_order': isDeliveryOrder,
      'tags': tags,
      'slug': slug,
    };
  }

  factory RestaurantProfileStateModel.fromMap(Map<String, dynamic> map) {
    return RestaurantProfileStateModel(
      restaurantName: map['restaurant_name'] ?? '',
      cityId: map['city_id'] ?? '',
      cuisines: map['cuisines'] != null
          ? List<String>.from(jsonDecode(map['cuisines']))
          : [],
      whatsappNumber: map['whatsapp'] ?? '',
      address: map['address'] ?? '',
      latitude: map['latitude'] ?? '',
      longitude: map['longitude'] ?? '',
      maxDeliveryDistance: map['max_delivery_distance'] ?? '',
      ownerName: map['owner_name'] ?? '',
      ownerEmail: map['owner_email'] ?? '',
      ownerPhoneNumber: map['owner_phone'] ?? '',
      name: map['name'] ?? '',
      openingHours: map['opening_hour'] ?? '',
      closingHours: map['closing_hour'] ?? '',
      minProcessingTime: map['min_processing_time'] ?? '',
      maxProcessingTime: map['max_processing_time'] ?? '',
      timeSlotSeparator: map['time_slot_separate'] ?? '',
      logo: map['logo'] ?? '',
      coverImages: map['cover_image'] ?? '',
      isFeatured: map['is_featured'] ?? '',
      isPickupOrder: map['is_pickup_order'] ?? '',
      isDeliveryOrder: map['is_delivery_order'] ?? '',
      tags: map['tags'] ?? '',
      slug: map['slug'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory RestaurantProfileStateModel.fromJson(String source) =>
      RestaurantProfileStateModel.fromMap(
          json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;

  @override
  List<Object> get props {
    return [
      restaurantName,
      cityId,
      cuisines,
      whatsappNumber,
      address,
      latitude,
      longitude,
      maxDeliveryDistance,
      ownerName,
      ownerEmail,
      ownerPhoneNumber,
      name,
      openingHours,
      closingHours,
      minProcessingTime,
      maxProcessingTime,
      timeSlotSeparator,
      logo,
      coverImages,
      isFeatured,
      isPickupOrder,
      isDeliveryOrder,
      tags,
      slug,
      restaurantProfileState,
    ];
  }
}
