import 'dart:convert';

import 'package:equatable/equatable.dart';

import '../cubit/subscription_state.dart';

class PaymentToMapModel extends Equatable {
  final String addressId;
  final String couponCode;
  final String discountAmount;
  final String deliveryCharge;
  final String vat;
  final String orderType;
  final String token;
  final SubscriptionListState subscriptionListState;

  const PaymentToMapModel({
    required this.addressId,
    required this.couponCode,
    required this.discountAmount,
    required this.deliveryCharge,
    required this.vat,
    required this.orderType,
    required this.token,
    this.subscriptionListState = const SubscriptionListInitial(),
  });

  PaymentToMapModel copyWith({
    String? addressId,
    String? couponCode,
    String? discountAmount,
    String? deliveryCharge,
    String? vat,
    String? orderType,
    String? token,
    SubscriptionListState? subscriptionListState,
  }) {
    return PaymentToMapModel(
      addressId: addressId ?? this.addressId,
      couponCode: couponCode ?? this.couponCode,
      discountAmount: discountAmount ?? this.discountAmount,
      deliveryCharge: deliveryCharge ?? this.deliveryCharge,
      vat: vat ?? this.vat,
      orderType: orderType ?? this.orderType,
      token: token ?? this.token,
      subscriptionListState:
          subscriptionListState ?? this.subscriptionListState,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'addressId': addressId,
      'couponCode': couponCode,
      'discountAmount': discountAmount,
      'deliveryCharge': deliveryCharge,
      'vat': vat,
      'orderType': orderType,
      'Authorization': token,
    };
  }

  static PaymentToMapModel init() {
    return const PaymentToMapModel(
      addressId: '',
      couponCode: '',
      discountAmount: '',
      deliveryCharge: '',
      vat: '',
      orderType: '',
      token: '',
      subscriptionListState: SubscriptionListInitial(),
    );
  }

  factory PaymentToMapModel.fromMap(Map<String, dynamic> map) {
    return PaymentToMapModel(
      addressId: map['addressId'] ?? '',
      couponCode: map['couponCode'] ?? '',
      discountAmount: map['discountAmount'] ?? '',
      deliveryCharge: map['deliveryCharge'] ?? '',
      vat: map['vat'] ?? '',
      token: map['token'] ?? '',
      orderType: map['orderType'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory PaymentToMapModel.fromJson(String source) =>
      PaymentToMapModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;

  @override
  List<Object> get props {
    return [
      addressId,
      couponCode,
      discountAmount,
      deliveryCharge,
      vat,
      orderType,
      token,
      subscriptionListState,
    ];
  }
}
