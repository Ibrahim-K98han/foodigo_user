// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:equatable/equatable.dart';

class ResAddonModel extends Equatable {
  final List<ResAddons>? resAddons;

  const ResAddonModel({
    this.resAddons,
  });

  ResAddonModel copyWith({
    List<ResAddons>? resAddons,
  }) {
    return ResAddonModel(
      resAddons: resAddons ?? this.resAddons,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'addons': resAddons?.map((x) => x.toMap()).toList(),
    };
  }

  factory ResAddonModel.fromMap(Map<String, dynamic> map) {
    return ResAddonModel(
      resAddons: map['addons'] != null
          ? List<ResAddons>.from(
              (map['addons'] as List<dynamic>).map<ResAddons?>(
                (x) => ResAddons.fromMap(x as Map<String, dynamic>),
              ),
            )
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory ResAddonModel.fromJson(String source) =>
      ResAddonModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;

  @override
  List<Object> get props => [resAddons!];
}

class ResAddons extends Equatable {
  final int id;
  final String restaurantId;
  final String price;
  final String status;
  final String createdAt;
  final String updatedAt;
  final String name;

  const ResAddons({
    required this.id,
    required this.restaurantId,
    required this.price,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    required this.name,
  });

  ResAddons copyWith({
    int? id,
    String? restaurantId,
    String? price,
    String? status,
    String? createdAt,
    String? updatedAt,
    String? name,
  }) {
    return ResAddons(
      id: id ?? this.id,
      restaurantId: restaurantId ?? this.restaurantId,
      price: price ?? this.price,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      name: name ?? this.name,
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
    };
  }

  factory ResAddons.fromMap(Map<String, dynamic> map) {
    return ResAddons(
      id: map['id'] ?? 0,
      restaurantId: map['restaurant_id'] ?? '',
      price: map['price'] ?? '',
      status: map['status'] ?? '',
      createdAt: map['created_at'] ?? '',
      updatedAt: map['updated_at'] ?? '',
      name: map['name'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory ResAddons.fromJson(String source) =>
      ResAddons.fromMap(json.decode(source) as Map<String, dynamic>);

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
    ];
  }
}
