// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'package:equatable/equatable.dart';

class ResAddonModel extends Equatable {
  final List<ResAddons> resAddons;

  const ResAddonModel({
    this.resAddons = const [],
  });

  ResAddonModel copyWith({
    List<ResAddons>? resAddons,
  }) {
    return ResAddonModel(
      resAddons: resAddons ?? this.resAddons,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'addons': resAddons.map((x) => x.toMap()).toList(),
    };
  }

  factory ResAddonModel.fromMap(Map<String, dynamic> map) {
    return ResAddonModel(
      resAddons: map['addons'] != null
          ? List<ResAddons>.from(
        (map['addons'] as List).map(
              (x) => ResAddons.fromMap(x as Map<String, dynamic>),
        ),
      )
          : [],
    );
  }

  String toJson() => json.encode(toMap());

  factory ResAddonModel.fromJson(String source) =>
      ResAddonModel.fromMap(json.decode(source));

  @override
  List<Object> get props => [resAddons];
}

class ResAddons extends Equatable {
  final int id;
  final String restaurantId;
  final String price;
  final String status;
  final String createdAt;
  final String updatedAt;
  final String name;
  final AddonTranslate? addonTranslate;

  const ResAddons({
    required this.id,
    required this.restaurantId,
    required this.price,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    required this.name,
    this.addonTranslate,
  });

  ResAddons copyWith({
    int? id,
    String? restaurantId,
    String? price,
    String? status,
    String? createdAt,
    String? updatedAt,
    String? name,
    AddonTranslate? addonTranslate,
  }) {
    return ResAddons(
      id: id ?? this.id,
      restaurantId: restaurantId ?? this.restaurantId,
      price: price ?? this.price,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      name: name ?? this.name,
      addonTranslate: addonTranslate ?? this.addonTranslate,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'restaurant_id': restaurantId,
      'price': price,
      'status': status,
      'created_at': createdAt,
      'updated_at': updatedAt,
      'name': name,
      'addon_translate': addonTranslate?.toMap(),
    };
  }

  factory ResAddons.fromMap(Map<String, dynamic> map) {
    return ResAddons(
      id: (map['id'] is String)
          ? int.tryParse(map['id']) ?? 0
          : (map['id'] ?? 0),
      restaurantId: map['restaurant_id']?.toString() ?? '',
      price: map['price']?.toString() ?? '',
      status: map['status']?.toString() ?? '',
      createdAt: map['created_at']?.toString() ?? '',
      updatedAt: map['updated_at']?.toString() ?? '',
      name: map['name']?.toString() ?? '',
      addonTranslate: map['addon_translate'] != null
          ? AddonTranslate.fromMap(map['addon_translate'])
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory ResAddons.fromJson(String source) =>
      ResAddons.fromMap(json.decode(source));

  @override
  List<Object?> get props => [
    id,
    restaurantId,
    price,
    status,
    createdAt,
    updatedAt,
    name,
    addonTranslate,
  ];
}

class AddonTranslate extends Equatable {
  final int id;
  final String addonId;
  final String langCode;
  final String name;
  final String createdAt;
  final String updatedAt;

  const AddonTranslate({
    required this.id,
    required this.addonId,
    required this.langCode,
    required this.name,
    required this.createdAt,
    required this.updatedAt,
  });

  AddonTranslate copyWith({
    int? id,
    String? addonId,
    String? langCode,
    String? name,
    String? createdAt,
    String? updatedAt,
  }) {
    return AddonTranslate(
      id: id ?? this.id,
      addonId: addonId ?? this.addonId,
      langCode: langCode ?? this.langCode,
      name: name ?? this.name,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'addon_id': addonId,
      'lang_code': langCode,
      'name': name,
      'created_at': createdAt,
      'updated_at': updatedAt,
    };
  }

  factory AddonTranslate.fromMap(Map<String, dynamic> map) {
    return AddonTranslate(
      id: (map['id'] is String)
          ? int.tryParse(map['id']) ?? 0
          : (map['id'] ?? 0),
      addonId: map['addon_id']?.toString() ?? '',
      langCode: map['lang_code']?.toString() ?? '',
      name: map['name']?.toString() ?? '',
      createdAt: map['created_at']?.toString() ?? '',
      updatedAt: map['updated_at']?.toString() ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory AddonTranslate.fromJson(String source) =>
      AddonTranslate.fromMap(json.decode(source));

  @override
  List<Object> get props => [id, addonId, langCode, name, createdAt, updatedAt];
}
