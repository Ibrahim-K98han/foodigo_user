import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:foodigo/features/restaurant_features/WithdrawData/cubit/withdraw_state.dart';

class WithdrawStoreStateModel extends Equatable {
  final String methodId;
  final String amount;
  final String bankDescription;
  final WithdrawState withdrawState;

  const WithdrawStoreStateModel({
    this.methodId = '',
    this.amount = '',
    this.bankDescription = '',
    this.withdrawState = const WithdrawMethodInitial(),
  });

  WithdrawStoreStateModel copyWith(
      {String? methodId,
      String? amount,
      String? bankDescription,
      WithdrawState? withdrawState}) {
    return WithdrawStoreStateModel(
      methodId: methodId ?? this.methodId,
      amount: amount ?? this.amount,
      bankDescription: methodId ?? this.bankDescription,
      withdrawState: withdrawState ?? this.withdrawState,
    );
  }

  Map<String, String> toMap() {
    return {
      'method_id': methodId,
      'amount': amount,
      'description': bankDescription,
    };
  }

  factory WithdrawStoreStateModel.fromMap(Map<String, dynamic> map) {
    return WithdrawStoreStateModel(
      methodId: map['method_id'] ?? '',
      amount: map['amount'] ?? '',
      bankDescription: map['description'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory WithdrawStoreStateModel.fromJson(String source) =>
      WithdrawStoreStateModel.fromMap(json.decode(source));

  @override
  List<Object?> get props => [methodId, amount, bankDescription, withdrawState];
}
