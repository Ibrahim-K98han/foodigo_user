import 'dart:convert';

class BankPaymentRequestModel {
  final String transactionInfo;
  final OrderDataRequest orderData;

  BankPaymentRequestModel({
    required this.transactionInfo,
    required this.orderData,
  });

  Map<String, dynamic> toMap() {
    return {
      'transaction_info': transactionInfo,
      'order_data': orderData.toMap(),
    };
  }

  String toJson() => json.encode(toMap());
}

class OrderDataRequest {
  final String addressId;
  final String orderType;
  final String? deliveryInstructions;
  final String? couponCode;
  final String? discountAmount;
  final String? deliveryCharge;
  final String? vat;

  OrderDataRequest({
    required this.addressId,
    required this.orderType,
    this.deliveryInstructions,
    this.couponCode,
    this.discountAmount,
    this.deliveryCharge,
    this.vat,
  });

  Map<String, dynamic> toMap() {
    return {
      'address_id': addressId,
      'order_type': orderType,
      if (deliveryInstructions != null) 'delivery_instructions': deliveryInstructions,
      if (couponCode != null) 'coupon_code': couponCode,
      if (discountAmount != null) 'discount_amount': discountAmount,
      if (deliveryCharge != null) 'delivery_charge': deliveryCharge,
      if (vat != null) 'vat': vat,
    };
  }
}
