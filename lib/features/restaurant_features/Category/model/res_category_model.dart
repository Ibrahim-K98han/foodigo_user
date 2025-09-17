// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:equatable/equatable.dart';

class ResCategoryModel extends Equatable {
  final List<ResCategories>? resCategories;

  const ResCategoryModel({
    this.resCategories,
  });

  ResCategoryModel copyWith({
    List<ResCategories>? resCategories,
  }) {
    return ResCategoryModel(
      resCategories: resCategories ?? this.resCategories,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'categories': resCategories?.map((x) => x.toMap()).toList(),
    };
  }

  factory ResCategoryModel.fromMap(Map<String, dynamic> map) {
    return ResCategoryModel(
      resCategories: map['categories'] != null
          ? List<ResCategories>.from(
              (map['categories'] as List<dynamic>).map<ResCategories?>(
                (x) => ResCategories.fromMap(x as Map<String, dynamic>),
              ),
            )
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory ResCategoryModel.fromJson(String source) =>
      ResCategoryModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;

  @override
  List<Object> get props => [resCategories!];
}

class ResCategories extends Equatable {
  final int id;
  final String slug;
  final String status;
  final String createdAt;
  final String updatedAt;
  final String icon;
  final String name;

  const ResCategories({
    required this.id,
    required this.slug,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    required this.icon,
    required this.name,
  });

  ResCategories copyWith({
    int? id,
    String? slug,
    String? status,
    String? createdAt,
    String? updatedAt,
    String? icon,
    String? name,
  }) {
    return ResCategories(
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
      'createdAt': createdAt,
      'updatedAt': updatedAt,
      'icon': icon,
      'name': name,
    };
  }

  factory ResCategories.fromMap(Map<String, dynamic> map) {
    return ResCategories(
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

  factory ResCategories.fromJson(String source) =>
      ResCategories.fromMap(json.decode(source) as Map<String, dynamic>);

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
