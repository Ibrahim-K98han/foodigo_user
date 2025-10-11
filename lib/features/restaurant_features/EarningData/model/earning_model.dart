// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:equatable/equatable.dart';

class EarningModel extends Equatable {
  final List<WithdrawList>? withdrawList;
  final String totalIncome;
  final double totalCommission;
  final double netIncome;
  final double currentBalance;
  final int totalWithdrawAmount;
  final String pendingWithdraw;

  const EarningModel({
    this.withdrawList,
    required this.totalIncome,
    required this.totalCommission,
    required this.netIncome,
    required this.currentBalance,
    required this.totalWithdrawAmount,
    required this.pendingWithdraw,
  });

  EarningModel copyWith({
    List<WithdrawList>? withdrawList,
    String? totalIncome,
    double? totalCommission,
    double? netIncome,
    double? currentBalance,
    int? totalWithdrawAmount,
    String? pendingWithdraw,
  }) {
    return EarningModel(
      withdrawList: withdrawList ?? this.withdrawList,
      totalIncome: totalIncome ?? this.totalIncome,
      totalCommission: totalCommission ?? this.totalCommission,
      netIncome: netIncome ?? this.netIncome,
      currentBalance: currentBalance ?? this.currentBalance,
      totalWithdrawAmount: totalWithdrawAmount ?? this.totalWithdrawAmount,
      pendingWithdraw: pendingWithdraw ?? this.pendingWithdraw,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'withdraw_list': withdrawList?.map((x) => x.toMap()).toList(),
      'total_income': totalIncome,
      'total_commission': totalCommission,
      'net_income': netIncome,
      'current_balance': currentBalance,
      'total_withdraw_amount': totalWithdrawAmount,
      'pending_withdraw': pendingWithdraw,
    };
  }

  factory EarningModel.fromMap(Map<String, dynamic> map) {
    return EarningModel(
      withdrawList:
          map['withdraw_list'] != null
              ? List<WithdrawList>.from(
                (map['withdraw_list'] as List<dynamic>).map<WithdrawList>(
                  (x) => WithdrawList.fromMap(x as Map<String, dynamic>),
                ),
              )
              : null,
      totalIncome: map['total_income']?.toString() ?? '',
      totalCommission:
          map['total_commission'] != null
              ? (map['total_commission'] as num).toDouble()
              : 0.0,
      netIncome:
          map['net_income'] != null
              ? (map['net_income'] as num).toDouble()
              : 0.0,
      currentBalance:
          map['current_balance'] != null
              ? (map['current_balance'] as num).toDouble()
              : 0.0,
      totalWithdrawAmount:
          map['total_withdraw_amount'] != null
              ? (map['total_withdraw_amount'] as num).toInt()
              : 0,
      pendingWithdraw: map['pending_withdraw']?.toString() ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory EarningModel.fromJson(String source) =>
      EarningModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;

  @override
  List<Object> get props {
    return [
      withdrawList!,
      totalIncome,
      totalCommission,
      netIncome,
      currentBalance,
      totalWithdrawAmount,
      pendingWithdraw,
    ];
  }
}

class WithdrawList extends Equatable {
  final int id;
  final String sellerId;
  final String withdrawMethodId;
  final String withdrawMethodName;
  final String totalAmount;
  final String withdrawAmount;
  final String chargeAmount;
  final String description;
  final String status;
  final String createdAt;
  final String updatedAt;
  final String isDeliveryman;

  const WithdrawList({
    required this.id,
    required this.sellerId,
    required this.withdrawMethodId,
    required this.withdrawMethodName,
    required this.totalAmount,
    required this.withdrawAmount,
    required this.chargeAmount,
    required this.description,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    required this.isDeliveryman,
  });

  WithdrawList copyWith({
    int? id,
    String? sellerId,
    String? withdrawMethodId,
    String? withdrawMethodName,
    String? totalAmount,
    String? withdrawAmount,
    String? chargeAmount,
    String? description,
    String? status,
    String? createdAt,
    String? updatedAt,
    String? isDeliveryman,
  }) {
    return WithdrawList(
      id: id ?? this.id,
      sellerId: sellerId ?? this.sellerId,
      withdrawMethodId: withdrawMethodId ?? this.withdrawMethodId,
      withdrawMethodName: withdrawMethodName ?? this.withdrawMethodName,
      totalAmount: totalAmount ?? this.totalAmount,
      withdrawAmount: withdrawAmount ?? this.withdrawAmount,
      chargeAmount: chargeAmount ?? this.chargeAmount,
      description: description ?? this.description,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      isDeliveryman: isDeliveryman ?? this.isDeliveryman,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'seller_id': sellerId,
      'withdraw_method_id': withdrawMethodId,
      'withdraw_method_name': withdrawMethodName,
      'total_amount': totalAmount,
      'withdraw_amount': withdrawAmount,
      'charge_amount': chargeAmount,
      'description': description,
      'status': status,
      'created_at': createdAt,
      'updated_at': updatedAt,
      'is_deliveryman': isDeliveryman,
    };
  }

  factory WithdrawList.fromMap(Map<String, dynamic> map) {
    return WithdrawList(
      id: map['id'] ?? 0,
      sellerId: map['seller_id'] ?? '',
      withdrawMethodId: map['withdraw_method_id'] ?? '',
      withdrawMethodName: map['withdraw_method_name'] ?? '',
      totalAmount: map['total_amount'] ?? '',
      withdrawAmount: map['withdraw_amount'] ?? '',
      chargeAmount: map['charge_amount'] ?? '',
      description: map['description'] ?? '',
      status: map['status'] ?? '',
      createdAt: map['created_at'] ?? '',
      updatedAt: map['updated_at'] ?? '',
      isDeliveryman: map['is_deliveryman'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory WithdrawList.fromJson(String source) =>
      WithdrawList.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;

  @override
  List<Object> get props {
    return [
      id,
      sellerId,
      withdrawMethodId,
      withdrawMethodName,
      totalAmount,
      withdrawAmount,
      chargeAmount,
      description,
      status,
      createdAt,
      updatedAt,
      isDeliveryman,
    ];
  }
}
