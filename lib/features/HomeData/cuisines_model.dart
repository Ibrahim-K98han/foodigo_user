// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:equatable/equatable.dart';

class Cuisines extends Equatable {
  final int id;
  final String slug;
  final String icon;
  final String status;
  final String createdAt;
  final String updatedAt;
  final int totalRestaurant;
  final String name;
  const Cuisines({
    required this.id,
    required this.slug,
    required this.icon,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    required this.totalRestaurant,
    required this.name,
  });

  Cuisines copyWith({
    int? id,
    String? slug,
    String? icon,
    String? status,
    String? createdAt,
    String? updatedAt,
    int? totalRestaurant,
    String? name,
  }) {
    return Cuisines(
      id: id ?? this.id,
      slug: slug ?? this.slug,
      icon: icon ?? this.icon,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      totalRestaurant: totalRestaurant ?? this.totalRestaurant,
      name: name ?? this.name,
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
      'total_restaurant': totalRestaurant,
      'name': name,
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
      totalRestaurant: map['total_restaurant'] ?? 0,
      name: map['name'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory Cuisines.fromJson(String source) => Cuisines.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;

  @override
  List<Object> get props {
    return [
      id,
      slug,
      icon,
      status,
      createdAt,
      updatedAt,
      totalRestaurant,
      name,
    ];
  }
}
