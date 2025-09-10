// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'package:equatable/equatable.dart';

class BankPaymentResponseModel extends Equatable {
  final bool success;
  final String message;
  final OrderData? order;

  const BankPaymentResponseModel({
    required this.success,
    required this.message,
    this.order,
  });

  BankPaymentResponseModel copyWith({
    bool? success,
    String? message,
    OrderData? order,
  }) {
    return BankPaymentResponseModel(
      success: success ?? this.success,
      message: message ?? this.message,
      order: order ?? this.order,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'success': success,
      'message': message,
      'order': order?.toMap(),
    };
  }

  factory BankPaymentResponseModel.fromMap(Map<String, dynamic> map) {
    return BankPaymentResponseModel(
      success: map['success'] ?? false,
      message: map['message'] ?? '',
      order: map['order'] != null
          ? OrderData.fromMap(map['order'] as Map<String, dynamic>)
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory BankPaymentResponseModel.fromJson(String source) =>
      BankPaymentResponseModel.fromMap(
          json.decode(source) as Map<String, dynamic>);

  @override
  List<Object?> get props => [success, message, order];
}

class OrderData extends Equatable {
  final int id;
  final int userId;
  final String restaurantId;
  final String orderType;
  final int addressId;
  final String deliveryDay;
  final String timeSlotId;
  final String coupon;
  final String discountAmount;
  final String deliveryCharge;
  final String vat;
  final double total;
  final double grandTotal;
  final String paymentMethod;
  final String paymentStatus;
  final String tnxInfo;
  final int isGuest;
  final String deliveryAddress;
  final String createdAt;
  final String updatedAt;

  const OrderData({
    required this.id,
    required this.userId,
    required this.restaurantId,
    required this.orderType,
    required this.addressId,
    required this.deliveryDay,
    required this.timeSlotId,
    required this.coupon,
    required this.discountAmount,
    required this.deliveryCharge,
    required this.vat,
    required this.total,
    required this.grandTotal,
    required this.paymentMethod,
    required this.paymentStatus,
    required this.tnxInfo,
    required this.isGuest,
    required this.deliveryAddress,
    required this.createdAt,
    required this.updatedAt,
  });

  OrderData copyWith({
    int? id,
    int? userId,
    String? restaurantId,
    String? orderType,
    int? addressId,
    String? deliveryDay,
    String? timeSlotId,
    String? coupon,
    String? discountAmount,
    String? deliveryCharge,
    String? vat,
    double? total,
    double? grandTotal,
    String? paymentMethod,
    String? paymentStatus,
    String? tnxInfo,
    int? isGuest,
    String? deliveryAddress,
    String? createdAt,
    String? updatedAt,
  }) {
    return OrderData(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      restaurantId: restaurantId ?? this.restaurantId,
      orderType: orderType ?? this.orderType,
      addressId: addressId ?? this.addressId,
      deliveryDay: deliveryDay ?? this.deliveryDay,
      timeSlotId: timeSlotId ?? this.timeSlotId,
      coupon: coupon ?? this.coupon,
      discountAmount: discountAmount ?? this.discountAmount,
      deliveryCharge: deliveryCharge ?? this.deliveryCharge,
      vat: vat ?? this.vat,
      total: total ?? this.total,
      grandTotal: grandTotal ?? this.grandTotal,
      paymentMethod: paymentMethod ?? this.paymentMethod,
      paymentStatus: paymentStatus ?? this.paymentStatus,
      tnxInfo: tnxInfo ?? this.tnxInfo,
      isGuest: isGuest ?? this.isGuest,
      deliveryAddress: deliveryAddress ?? this.deliveryAddress,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'user_id': userId,
      'restaurant_id': restaurantId,
      'order_type': orderType,
      'address_id': addressId,
      'delivery_day': deliveryDay,
      'time_slot_id': timeSlotId,
      'coupon': coupon,
      'discount_amount': discountAmount,
      'delivery_charge': deliveryCharge,
      'vat': vat,
      'total': total,
      'grand_total': grandTotal,
      'payment_method': paymentMethod,
      'payment_status': paymentStatus,
      'tnx_info': tnxInfo,
      'is_guest': isGuest,
      'delivery_address': deliveryAddress,
      'created_at': createdAt,
      'updated_at': updatedAt,
    };
  }

  factory OrderData.fromMap(Map<String, dynamic> map) {
    return OrderData(
      id: map['id'] is String ? int.tryParse(map['id']) ?? 0 : (map['id'] ?? 0),
      userId: map['user_id'] is String
          ? int.tryParse(map['user_id']) ?? 0
          : (map['user_id'] ?? 0),
      restaurantId: map['restaurant_id']?.toString() ?? '',
      orderType: map['order_type']?.toString() ?? '',
      addressId: map['address_id'] is String
          ? int.tryParse(map['address_id']) ?? 0
          : (map['address_id'] ?? 0),
      deliveryDay: map['delivery_day']?.toString() ?? '',
      timeSlotId: map['time_slot_id']?.toString() ?? '',
      coupon: map['coupon']?.toString() ?? '',
      discountAmount: map['discount_amount']?.toString() ?? '',
      deliveryCharge: map['delivery_charge']?.toString() ?? '',
      vat: map['vat']?.toString() ?? '',
      total: (map['total'] is num) ? (map['total'] as num).toDouble() : 0.0,
      grandTotal: (map['grand_total'] is num)
          ? (map['grand_total'] as num).toDouble()
          : 0.0,
      paymentMethod: map['payment_method']?.toString() ?? '',
      paymentStatus: map['payment_status']?.toString() ?? '',
      tnxInfo: map['tnx_info']?.toString() ?? '',
      isGuest: map['is_guest'] is String
          ? int.tryParse(map['is_guest']) ?? 0
          : (map['is_guest'] ?? 0),
      deliveryAddress: map['delivery_address']?.toString() ?? '',
      createdAt: map['created_at']?.toString() ?? '',
      updatedAt: map['updated_at']?.toString() ?? '',
    );
  }


  String toJson() => json.encode(toMap());

  factory OrderData.fromJson(String source) =>
      OrderData.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  List<Object?> get props => [
        id,
        userId,
        restaurantId,
        orderType,
        addressId,
        deliveryDay,
        timeSlotId,
        coupon,
        discountAmount,
        deliveryCharge,
        vat,
        total,
        grandTotal,
        paymentMethod,
        paymentStatus,
        tnxInfo,
        isGuest,
        deliveryAddress,
        createdAt,
        updatedAt,
      ];
}
