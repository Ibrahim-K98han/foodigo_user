// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:equatable/equatable.dart';

class WithdrawModel extends Equatable {
  final List<Methods>? methods;

  const WithdrawModel({
    this.methods,
  });

  WithdrawModel copyWith({
    List<Methods>? methods,
  }) {
    return WithdrawModel(
      methods: methods ?? this.methods,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'methods': methods?.map((x) => x.toMap()).toList(),
    };
  }

  factory WithdrawModel.fromMap(Map<String, dynamic> map) {
    return WithdrawModel(
      methods: map['methods'] != null
          ? List<Methods>.from(
              (map['methods'] as List<dynamic>).map<Methods?>(
                (x) => Methods.fromMap(x as Map<String, dynamic>),
              ),
            )
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory WithdrawModel.fromJson(String source) =>
      WithdrawModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;

  @override
  List<Object> get props => [methods!];
}

class Methods extends Equatable {
  final int id;
  final String methodName;
  final String minAmount;
  final String maxAmount;
  final String withdrawCharge;
  final String description;
  final String status;
  final String createdAt;
  final String updatedAt;

  const Methods({
    required this.id,
    required this.methodName,
    required this.minAmount,
    required this.maxAmount,
    required this.withdrawCharge,
    required this.description,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
  });

  Methods copyWith({
    int? id,
    String? methodName,
    String? minAmount,
    String? maxAmount,
    String? withdrawCharge,
    String? description,
    String? status,
    String? createdAt,
    String? updatedAt,
  }) {
    return Methods(
      id: id ?? this.id,
      methodName: methodName ?? this.methodName,
      minAmount: minAmount ?? this.minAmount,
      maxAmount: maxAmount ?? this.maxAmount,
      withdrawCharge: withdrawCharge ?? this.withdrawCharge,
      description: description ?? this.description,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'method_name': methodName,
      'min_amount': minAmount,
      'max_amount': maxAmount,
      'withdraw_charge': withdrawCharge,
      'description': description,
      'status': status,
      'created_at': createdAt,
      'updated_at': updatedAt,
    };
  }

  factory Methods.fromMap(Map<String, dynamic> map) {
    return Methods(
      id: map['id'] ?? 0,
      methodName: map['method_name'] ?? '',
      minAmount: map['min_amount'] ?? '',
      maxAmount: map['max_amount'] ?? '',
      withdrawCharge: map['withdraw_charge'] ?? '',
      description: map['description'] ?? '',
      status: map['status'] ?? '',
      createdAt: map['created_at'] ?? '',
      updatedAt: map['updated_at'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory Methods.fromJson(String source) =>
      Methods.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;

  @override
  List<Object> get props {
    return [
      id,
      methodName,
      minAmount,
      maxAmount,
      withdrawCharge,
      description,
      status,
      createdAt,
      updatedAt,
    ];
  }
}
