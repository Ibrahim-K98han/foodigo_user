// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'package:equatable/equatable.dart';
import 'package:foodigo/features/checkout/cubit/checkout_state.dart';

import '../cubit/apply_coupon_state.dart';

class ApplyCouponStateModel extends Equatable {
  final String addressId;
  final String orderType;
  final String deliveryInstructions;
  final String couponCode;
  final String discountAmount;
  final String deliveryCharge;
  final String vat;
  final ApplyCouponState applyCouponState;

  const ApplyCouponStateModel(
      {this.addressId = '',
      this.orderType = '',
      this.deliveryInstructions = '',
      this.couponCode = '',
      this.discountAmount = '0',
      this.deliveryCharge = '0',
      this.vat = '0',
      this.applyCouponState = const ApplyCouponStateInitial()});

  ApplyCouponStateModel copyWith({
    String? addressId,
    String? orderType,
    String? deliveryInstructions,
    String? couponCode,
    String? discountAmount,
    String? deliveryCharge,
    String? vat,
    ApplyCouponState? applyCouponState,
  }) {
    return ApplyCouponStateModel(
      addressId: addressId ?? this.addressId,
      orderType: orderType ?? this.orderType,
      deliveryInstructions: deliveryInstructions ?? this.deliveryInstructions,
      couponCode: couponCode ?? this.couponCode,
      discountAmount: discountAmount ?? this.discountAmount,
      deliveryCharge: deliveryCharge ?? this.deliveryCharge,
      vat: vat ?? this.vat,
      applyCouponState: applyCouponState ?? this.applyCouponState,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'address_id': addressId,
      'order_type': orderType,
      'delivery_instructions': deliveryInstructions,
      'coupon_code': couponCode,
      'discount_amount': discountAmount,
      'delivery_charge': deliveryCharge,
      'vat': vat,
    };
  }

  factory ApplyCouponStateModel.fromMap(Map<String, dynamic> map) {
    return ApplyCouponStateModel(
      addressId: map['address_id'] ?? '',
      orderType: map['order_type'] ?? '',
      deliveryInstructions: map['delivery_instructions'] ?? '',
      couponCode: map['coupon_code'] ?? '',
      discountAmount: map['discount_amount'] ?? '0',
      deliveryCharge: map['delivery_charge'] ?? '0',
      vat: map['vat'] ?? '0',
    );
  }

  String toJson() => json.encode(toMap());

  factory ApplyCouponStateModel.fromJson(String source) =>
      ApplyCouponStateModel.fromMap(
          json.decode(source) as Map<String, dynamic>);

  @override
  List<Object> get props => [
        addressId,
        orderType,
        deliveryInstructions,
        couponCode,
        discountAmount,
        deliveryCharge,
        vat,
        applyCouponState
      ];
}
