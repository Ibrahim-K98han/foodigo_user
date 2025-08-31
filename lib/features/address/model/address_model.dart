// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:equatable/equatable.dart';

class GetAddress extends Equatable {
  final List<Address>? address;

  const GetAddress({
    this.address,
  });

  GetAddress copyWith({
    List<Address>? address,
  }) {
    return GetAddress(
      address: address ?? this.address,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'address': address?.map((x) => x.toMap()).toList(),
    };
  }

  factory GetAddress.fromMap(Map<String, dynamic> map) {
    return GetAddress(
      address: map['address'] != null
          ? List<Address>.from(
              (map['address'] as List<int>).map<Address?>(
                (x) => Address.fromMap(x as Map<String, dynamic>),
              ),
            )
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory GetAddress.fromJson(String source) =>
      GetAddress.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;

  @override
  List<Object> get props => [address!];
}

class Address extends Equatable {
  final int id;
  final String userId;
  final String name;
  final String lat;
  final String lon;
  final String email;
  final String phone;
  final String address;
  final String deliveryType;
  final String isGuest;
  final String createdAt;
  final String updatedAt;

  const Address({
    required this.id,
    required this.userId,
    required this.name,
    required this.lat,
    required this.lon,
    required this.email,
    required this.phone,
    required this.address,
    required this.deliveryType,
    required this.isGuest,
    required this.createdAt,
    required this.updatedAt,
  });

  Address copyWith({
    int? id,
    String? userId,
    String? name,
    String? lat,
    String? lon,
    String? email,
    String? phone,
    String? address,
    String? deliveryType,
    String? isGuest,
    String? createdAt,
    String? updatedAt,
  }) {
    return Address(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      name: name ?? this.name,
      lat: lat ?? this.lat,
      lon: lon ?? this.lon,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      address: address ?? this.address,
      deliveryType: deliveryType ?? this.deliveryType,
      isGuest: isGuest ?? this.isGuest,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'user_id': userId,
      'name': name,
      'lat': lat,
      'lon': lon,
      'email': email,
      'phone': phone,
      'address': address,
      'delivery_type': deliveryType,
      'is_guest': isGuest,
      'created_at': createdAt,
      'updated_at': updatedAt,
    };
  }

  factory Address.fromMap(Map<String, dynamic> map) {
    return Address(
      id: map['id'] ?? 0,
      userId: (map['user_id'] ?? 0).toString(),
      name: map['name'] ?? '',
      lat: map['lat'] ?? '',
      lon: map['lon'] ?? '',
      email: map['email'] ?? '',
      phone: map['phone'] ?? '',
      address: map['address'] ?? '',
      deliveryType: map['delivery_type'] ?? '',
      isGuest: map['is_guest'] ?? '',
      createdAt: map['created_at'] ?? '',
      updatedAt: map['updated_at'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory Address.fromJson(String source) =>
      Address.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;

  @override
  List<Object> get props {
    return [
      id,
      userId,
      name,
      lat,
      lon,
      email,
      phone,
      address,
      deliveryType,
      isGuest,
      createdAt,
      updatedAt,
    ];
  }
}
