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

class TranslateAddonModel extends Equatable {
  final Addon? addon;
  final AddonTranslate? addonTranslate;

  const TranslateAddonModel({
    this.addon,
    this.addonTranslate,
  });

  TranslateAddonModel copyWith({
    String? message,
    Addon? addon,
    AddonTranslate? addonTranslate,
  }) {
    return TranslateAddonModel(
      addon: addon ?? this.addon,
      addonTranslate: addonTranslate ?? this.addonTranslate,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'addon': addon?.toMap(),
      'addon_translate': addonTranslate?.toMap(),
    };
  }

  factory TranslateAddonModel.fromMap(Map<String, dynamic> map) {
    return TranslateAddonModel(
      addon: map['addon'] != null
          ? Addon.fromMap(map['addon'] as Map<String, dynamic>)
          : null,
      addonTranslate: map['addon_translate'] != null
          ? AddonTranslate.fromMap(
              map['addon_translate'] as Map<String, dynamic>)
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory TranslateAddonModel.fromJson(String source) =>
      TranslateAddonModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;

  @override
  List<Object> get props => [addon!, addonTranslate!];
}

class Addon extends Equatable {
  final int id;
  final String restaurantId;
  final String price;
  final String status;
  final String createdAt;
  final String updatedAt;
  final String name;

  const Addon({
    required this.id,
    required this.restaurantId,
    required this.price,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    required this.name,
  });

  Addon copyWith({
    int? id,
    String? restaurantId,
    String? price,
    String? status,
    String? createdAt,
    String? updatedAt,
    String? name,
  }) {
    return Addon(
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

  factory Addon.fromMap(Map<String, dynamic> map) {
    return Addon(
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

  factory Addon.fromJson(String source) =>
      Addon.fromMap(json.decode(source) as Map<String, dynamic>);

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
      id: map['id'] ?? 0,
      restaurantId: map['restaurant_id'] ?? '',
      price: map['price'] ?? '',
      status: map['status'] ?? '',
      createdAt: map['created_at'] ?? '',
      updatedAt: map['updated_at'] ?? '',
      name: map['name'] ?? '',
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
      id: map['id'] ?? 0,
      addonId: map['addon_id'] ?? '',
      langCode: map['lang_code'] ?? '',
      name: map['name'] ?? '',
      createdAt: map['created_at'] ?? '',
      updatedAt: map['updated_at'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory AddonTranslate.fromJson(String source) =>
      AddonTranslate.fromMap(json.decode(source));

  @override
  List<Object> get props => [id, addonId, langCode, name, createdAt, updatedAt];
}
