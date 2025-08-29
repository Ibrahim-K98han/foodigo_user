// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:equatable/equatable.dart';

class UserResponseModel extends Equatable {
  final User? user;
  final String token;
  final String tokenType;

  const UserResponseModel({
    this.user,
    required this.token,
    required this.tokenType,
  });

  UserResponseModel copyWith({
    User? user,
    String? token,
    String? tokenType,
  }) {
    return UserResponseModel(
      user: user ?? this.user,
      token: token ?? this.token,
      tokenType: tokenType ?? this.tokenType,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'user': user?.toMap(),
      'token': token,
      'token_type': tokenType,
    };
  }

  factory UserResponseModel.fromMap(Map<String, dynamic> map) {
    return UserResponseModel(
      user: map['user'] != null
          ? User.fromMap(map['user'] as Map<String, dynamic>)
          : null,
      token: map['token'] ?? '',
      tokenType: map['token_type'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory UserResponseModel.fromJson(String source) =>
      UserResponseModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;

  @override
  List<Object?> get props => [user, token, tokenType];
}

class User extends Equatable {
  final int id;
  final String name;
  final String email;
  final String username;
  final String phone;
  final String image;
  final String address;
  final String status;

  const User({
    required this.id,
    required this.name,
    required this.email,
    required this.username,
    required this.phone,
    required this.image,
    required this.address,
    required this.status,
  });

  User copyWith({
    int? id,
    String? name,
    String? email,
    String? username,
    String? phone,
    String? image,
    String? address,
    String? status,
  }) {
    return User(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      username: username ?? this.username,
      phone: phone ?? this.phone,
      image: image ?? this.image,
      address: address ?? this.address,
      status: status ?? this.status,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'email': email,
      'username': username,
      'phone': phone,
      'image': image,
      'address': address,
      'status': status,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['id'] ?? 0,
      name: map['name'] ?? '',
      email: map['email'] ?? '',
      username: map['username'] ?? '',
      phone: map['phone'] ?? '',
      image: map['image'] ?? '',
      address: map['address'] ?? '',
      status: map['status'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) =>
      User.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;

  @override
  List<Object> get props {
    return [
      id,
      name,
      email,
      username,
      phone,
      image,
      address,
      status,
    ];
  }
}
