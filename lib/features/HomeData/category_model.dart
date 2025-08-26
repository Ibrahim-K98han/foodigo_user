// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:equatable/equatable.dart';

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

  factory Categories.fromJson(String source) => Categories.fromMap(json.decode(source) as Map<String, dynamic>);

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
