// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:equatable/equatable.dart';

class RestaurantLoginResponse extends Equatable {
  final Restaurant? restaurant;
  final String token;
  final String tokenType;

  const RestaurantLoginResponse({
    this.restaurant,
    required this.token,
    required this.tokenType,
  });

  RestaurantLoginResponse copyWith({
    Restaurant? user,
    String? token,
    String? tokenType,
  }) {
    return RestaurantLoginResponse(
      restaurant: user ?? this.restaurant,
      token: token ?? this.token,
      tokenType: tokenType ?? this.tokenType,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'restaurant': restaurant?.toMap(),
      'token': token,
      'token_type': tokenType,
    };
  }

  factory RestaurantLoginResponse.fromMap(Map<String, dynamic> map) {
    return RestaurantLoginResponse(
      restaurant: map['restaurant'] != null
          ? Restaurant.fromMap(map['restaurant'] as Map<String, dynamic>)
          : null,
      token: map['token'] ?? '',
      tokenType: map['token_type'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory RestaurantLoginResponse.fromJson(String source) =>
      RestaurantLoginResponse.fromMap(
          json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;

  @override
  List<Object?> get props => [restaurant, token, tokenType];
}

class Restaurant extends Equatable {
  final int id;
  final String restaurantName;
  final String name;
  final String email;
  final String ownerName;
  final String ownerPhone;
  final String logo;
  final String coverImage;
  final String address;
  final String latitude;
  final String longitude;
  final String adminApproval;
  final String isBanned;

  const Restaurant({
    required this.id,
    required this.restaurantName,
    required this.name,
    required this.email,
    required this.ownerName,
    required this.ownerPhone,
    required this.logo,
    required this.coverImage,
    required this.address,
    required this.latitude,
    required this.longitude,
    required this.adminApproval,
    required this.isBanned,
  });

  Restaurant copyWith({
    int? id,
    String? restaurantName,
    String? name,
    String? email,
    String? ownerName,
    String? ownerPhone,
    String? logo,
    String? coverImage,
    String? address,
    String? latitude,
    String? longitude,
    String? adminApproval,
    String? isBanned,
  }) {
    return Restaurant(
      id: id ?? this.id,
      restaurantName: restaurantName ?? this.restaurantName,
      name: name ?? this.name,
      email: email ?? this.email,
      ownerName: ownerName ?? this.ownerName,
      ownerPhone: ownerPhone ?? this.ownerPhone,
      logo: logo ?? this.logo,
      coverImage: coverImage ?? this.coverImage,
      address: address ?? this.address,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      adminApproval: adminApproval ?? this.adminApproval,
      isBanned: isBanned ?? this.isBanned,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'restaurant_name': restaurantName,
      'name': name,
      'email': email,
      'owner_name': ownerName,
      'owner_phone': ownerPhone,
      'logo': logo,
      'cover_image': coverImage,
      'address': address,
      'latitude': latitude,
      'longitude': longitude,
      'admin_approval': adminApproval,
      'is_banned': isBanned,
    };
  }

  factory Restaurant.fromMap(Map<String, dynamic> map) {
    return Restaurant(
      id: map['id'] ?? 0,
      restaurantName: map['restaurant_name'] ?? '',
      name: map['name'] ?? '',
      email: map['email'] ?? '',
      ownerName: map['owner_name'] ?? '',
      ownerPhone: map['owner_phone'] ?? '',
      logo: map['logo'] ?? '',
      coverImage: map['cover_image'] ?? '',
      address: map['address'] ?? '',
      latitude: map['latitude'] ?? '',
      longitude: map['longitude'] ?? '',
      adminApproval: map['admin_approval'] ?? '',
      isBanned: map['is_banned'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory Restaurant.fromJson(String source) =>
      Restaurant.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;

  @override
  List<Object> get props {
    return [
      id,
      name,
      restaurantName,
      email,
      ownerName,
      ownerPhone,
      logo,
      coverImage,
      address,
      latitude,
      longitude,
      adminApproval,
      isBanned,
    ];
  }
}
