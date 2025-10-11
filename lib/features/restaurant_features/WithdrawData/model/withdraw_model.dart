// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:equatable/equatable.dart';

class WithdrawModel extends Equatable {
  final String message;
  final List<Methods>? methods;

  const WithdrawModel({this.methods, required this.message});

  WithdrawModel copyWith({List<Methods>? methods}) {
    return WithdrawModel(message: message, methods: methods ?? this.methods);
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'message': message,
      'methods': methods?.map((x) => x.toMap()).toList(),
    };
  }

  factory WithdrawModel.fromMap(Map<String, dynamic> map) {
    return WithdrawModel(
      message: map['message'] ?? '',
      methods:
          map['methods'] != null
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
  List<Object> get props => [methods!, message];
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

class NewWithdrawResponse extends Equatable {
  final NewWithdraw? newWithdraw;
  const NewWithdrawResponse({this.newWithdraw});

  NewWithdrawResponse copyWith({NewWithdraw? newWithdraw}) {
    return NewWithdrawResponse(newWithdraw: newWithdraw ?? this.newWithdraw);
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{'new_withdraw': newWithdraw?.toMap()};
  }

  factory NewWithdrawResponse.fromMap(Map<String, dynamic> map) {
    return NewWithdrawResponse(
      newWithdraw:
          map['new_withdraw'] != null
              ? NewWithdraw.fromMap(map['new_withdraw'] as Map<String, dynamic>)
              : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory NewWithdrawResponse.fromJson(String source) =>
      NewWithdrawResponse.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;

  @override
  List<Object> get props => [newWithdraw!];
}

class NewWithdraw extends Equatable {
  final int sellerId;
  final String withdrawMethodName;
  final String withdrawMethodId;
  final String totalAmount;
  final double withdrawAmount;
  final double chargeAmount;
  final String description;
  final String updatedAt;
  final String createdAt;
  final int id;
  const NewWithdraw({
    required this.sellerId,
    required this.withdrawMethodName,
    required this.withdrawMethodId,
    required this.totalAmount,
    required this.withdrawAmount,
    required this.chargeAmount,
    required this.description,
    required this.updatedAt,
    required this.createdAt,
    required this.id,
  });

  NewWithdraw copyWith({
    int? sellerId,
    String? withdrawMethodName,
    String? withdrawMethodId,
    String? totalAmount,
    double? withdrawAmount,
    double? chargeAmount,
    String? description,
    String? updatedAt,
    String? createdAt,
    int? id,
  }) {
    return NewWithdraw(
      sellerId: sellerId ?? this.sellerId,
      withdrawMethodName: withdrawMethodName ?? this.withdrawMethodName,
      withdrawMethodId: withdrawMethodId ?? this.withdrawMethodId,
      totalAmount: totalAmount ?? this.totalAmount,
      withdrawAmount: withdrawAmount ?? this.withdrawAmount,
      chargeAmount: chargeAmount ?? this.chargeAmount,
      description: description ?? this.description,
      updatedAt: updatedAt ?? this.updatedAt,
      createdAt: createdAt ?? this.createdAt,
      id: id ?? this.id,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'sellerId': sellerId,
      'withdrawMethodName': withdrawMethodName,
      'withdrawMethodId': withdrawMethodId,
      'totalAmount': totalAmount,
      'withdrawAmount': withdrawAmount,
      'chargeAmount': chargeAmount,
      'description': description,
      'updatedAt': updatedAt,
      'createdAt': createdAt,
      'id': id,
    };
  }

  factory NewWithdraw.fromMap(Map<String, dynamic> map) {
    return NewWithdraw(
      sellerId: map['sellerId'] as int,
      withdrawMethodName: map['withdrawMethodName'] as String,
      withdrawMethodId: map['withdrawMethodId'] as String,
      totalAmount: map['totalAmount'] as String,
      withdrawAmount: map['withdrawAmount'] as double,
      chargeAmount: map['chargeAmount'] as double,
      description: map['description'] as String,
      updatedAt: map['updatedAt'] as String,
      createdAt: map['createdAt'] as String,
      id: map['id'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory NewWithdraw.fromJson(String source) =>
      NewWithdraw.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;

  @override
  List<Object> get props {
    return [
      sellerId,
      withdrawMethodName,
      withdrawMethodId,
      totalAmount,
      withdrawAmount,
      chargeAmount,
      description,
      updatedAt,
      createdAt,
      id,
    ];
  }
}
