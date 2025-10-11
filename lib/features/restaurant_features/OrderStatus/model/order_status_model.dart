// import 'dart:convert';
//
// import 'package:equatable/equatable.dart';
//
// class OrderStatusModel extends Equatable {
//   final OrderData? orderData;
//   final String message;
//
//   const OrderStatusModel({this.orderData, required this.message});
//
//   OrderStatusModel copyWith({String? message, OrderData? orderData}) {
//     return OrderStatusModel(
//       message: message ?? this.message,
//       orderData: orderData ?? this.orderData,
//     );
//   }
//
//   Map<String, dynamic> toMap() {
//     return <String, dynamic>{
//       'data': orderData?.toMap(),
//       'message': message,
//     };
//   }
//
//   factory OrderStatusModel.fromMap(Map<String, dynamic> map) {
//     return OrderStatusModel(
//       orderData: map['data'] != null
//           ? OrderData.fromMap(map['data'] as Map<String, dynamic>)
//           : null,
//       message: map['message'] ?? '',
//     );
//   }
//
//   String toJson() => json.encode(toMap());
//
//   factory OrderStatusModel.fromJson(String source) =>
//       OrderStatusModel.fromMap(json.decode(source) as Map<String, dynamic>);
//
//   @override
//   List<Object?> get props => [orderData, message];
// }
//
// class OrderData extends Equatable {
//   final int id;
//   final String userId;
//   final String restaurantId;
//   final String addressId;
//   final String timeSlotId;
//   final String orderType;
//   final String deliveryDay;
//   final String coupon;
//   final String discountAmount;
//   final String deliveryCharge;
//   final String vat;
//   final String total;
//   final String grandTotal;
//   final String paymentMethod;
//   final String paymentStatus;
//   final String orderStatus;
//   final String isGuest;
//   final String tnxInfo;
//   final String deliveryAddress;
//   final DateTime createdAt;
//   final DateTime updatedAt;
//   final String deliveryManId;
//   final String orderRequest;
//   final String orderReqDate;
//   final String orderReqAcceptDate;
//
//   const OrderData({
//     required this.id,
//     required this.userId,
//     required this.restaurantId,
//     required this.addressId,
//     required this.timeSlotId,
//     required this.orderType,
//     required this.deliveryDay,
//     required this.coupon,
//     required this.discountAmount,
//     required this.deliveryCharge,
//     required this.vat,
//     required this.total,
//     required this.grandTotal,
//     required this.paymentMethod,
//     required this.paymentStatus,
//     required this.orderStatus,
//     required this.isGuest,
//     required this.tnxInfo,
//     required this.deliveryAddress,
//     required this.createdAt,
//     required this.updatedAt,
//     required this.deliveryManId,
//     required this.orderRequest,
//     required this.orderReqDate,
//     required this.orderReqAcceptDate,
//   });
//
//   OrderData copyWith({
//     int? id,
//     String? userId,
//     String? restaurantId,
//     String? addressId,
//     String? timeSlotId,
//     String? orderType,
//     String? deliveryDay,
//     String? coupon,
//     String? discountAmount,
//     String? deliveryCharge,
//     String? vat,
//     String? total,
//     String? grandTotal,
//     String? paymentMethod,
//     String? paymentStatus,
//     String? orderStatus,
//     String? isGuest,
//     String? tnxInfo,
//     String? deliveryAddress,
//     DateTime? createdAt,
//     DateTime? updatedAt,
//     String? deliveryManId,
//     String? orderRequest,
//     String? orderReqDate,
//     String? orderReqAcceptDate,
//   }) {
//     return OrderData(
//       id: id ?? this.id,
//       userId: userId ?? this.userId,
//       restaurantId: restaurantId ?? this.restaurantId,
//       addressId: addressId ?? this.addressId,
//       timeSlotId: timeSlotId ?? this.timeSlotId,
//       orderType: orderType ?? this.orderType,
//       deliveryDay: deliveryDay ?? this.deliveryDay,
//       coupon: coupon ?? this.coupon,
//       discountAmount: discountAmount ?? this.discountAmount,
//       deliveryCharge: deliveryCharge ?? this.deliveryCharge,
//       vat: vat ?? this.vat,
//       total: total ?? this.total,
//       grandTotal: grandTotal ?? this.grandTotal,
//       paymentMethod: paymentMethod ?? this.paymentMethod,
//       paymentStatus: paymentStatus ?? this.paymentStatus,
//       orderStatus: orderStatus ?? this.orderStatus,
//       isGuest: isGuest ?? this.isGuest,
//       tnxInfo: tnxInfo ?? this.tnxInfo,
//       deliveryAddress: deliveryAddress ?? this.deliveryAddress,
//       createdAt: createdAt ?? this.createdAt,
//       updatedAt: updatedAt ?? this.updatedAt,
//       deliveryManId: deliveryManId ?? this.deliveryManId,
//       orderRequest: orderRequest ?? this.orderRequest,
//       orderReqDate: orderReqDate ?? this.orderReqDate,
//       orderReqAcceptDate: orderReqAcceptDate ?? this.orderReqAcceptDate,
//     );
//   }
//
//   Map<String, dynamic> toMap() {
//     return <String, dynamic>{
//       'id': id,
//       'user_id': userId,
//       'restaurant_id': restaurantId,
//       'address_id': addressId,
//       'time_slot_id': timeSlotId,
//       'order_type': orderType,
//       'delivery_day': deliveryDay,
//       'coupon': coupon,
//       'discount_amount': discountAmount,
//       'delivery_charge': deliveryCharge,
//       'vat': vat,
//       'total': total,
//       'grand_total': grandTotal,
//       'payment_method': paymentMethod,
//       'payment_status': paymentStatus,
//       'order_status': orderStatus,
//       'is_guest': isGuest,
//       'tnx_info': tnxInfo,
//       'delivery_address': deliveryAddress,
//       'created_at': createdAt.millisecondsSinceEpoch,
//       'updated_at': updatedAt.millisecondsSinceEpoch,
//       'delivery_man_id': deliveryManId,
//       'order_request': orderRequest,
//       'order_req_date': orderReqDate,
//       'order_req_accept_date': orderReqAcceptDate,
//     };
//   }
//
//   factory OrderData.fromMap(Map<String, dynamic> map) {
//     return OrderData(
//       id: map['id'] ?? 0,
//       userId: map['userId'] ?? '',
//       restaurantId: map['restaurant_id'] ?? '',
//       addressId: map['address_id'] ?? '',
//       timeSlotId: map['time_slot_id'] ?? '',
//       orderType: map['order_type'] ?? '',
//       deliveryDay: map['delivery_day'] ?? '',
//       coupon: map['coupon'] ?? '',
//       discountAmount: map['discount_amount'] ?? '',
//       deliveryCharge: map['delivery_charge'] ?? '',
//       vat: map['vat'] ?? '',
//       total: map['total'] ?? '',
//       grandTotal: map['grand_total'] ?? '',
//       paymentMethod: map['payment_method'] ?? '',
//       paymentStatus: map['payment_status'] ?? '',
//       orderStatus: map['order_status'] ?? '',
//       isGuest: map['is_guest'] ?? '',
//       tnxInfo: map['tnx_info'] ?? '',
//       deliveryAddress: map['delivery_address'] ?? '',
//       createdAt: map['created_at'] != null
//           ? DateTime.parse(map['created_at'])
//           : DateTime.now(),
//       // or any default
//       updatedAt: map['updated_at'] != null
//           ? DateTime.parse(map['updated_at'])
//           : DateTime.now(),
//       deliveryManId: map['delivery_man_id'] ?? '',
//       orderRequest: map['order_request'] ?? '',
//       orderReqDate: map['order_req_date'] ?? '',
//       orderReqAcceptDate: map['order_req_accept_date'] ?? '',
//     );
//   }
//
//   String toJson() => json.encode(toMap());
//
//   factory OrderData.fromJson(String source) =>
//       OrderData.fromMap(json.decode(source) as Map<String, dynamic>);
//
//   @override
//   List<Object?> get props => [
//         id,
//         userId,
//         restaurantId,
//         addressId,
//         timeSlotId,
//         orderType,
//         deliveryDay,
//         coupon,
//         discountAmount,
//         deliveryCharge,
//         vat,
//         total,
//         grandTotal,
//         paymentMethod,
//         paymentStatus,
//         orderStatus,
//         isGuest,
//         tnxInfo,
//         deliveryAddress,
//         createdAt,
//         updatedAt,
//         deliveryManId,
//         orderRequest,
//         orderReqDate,
//         orderReqAcceptDate,
//       ];
// }


import 'dart:convert';

import 'package:equatable/equatable.dart';

class OrderStatusModel extends Equatable {
  final OrderData? orderData;
  final String message;

  const OrderStatusModel({this.orderData, required this.message});

  OrderStatusModel copyWith({
    String? message,
    OrderData? orderData,
  }) {
    return OrderStatusModel(
      message: message ?? this.message,
      orderData: orderData ?? this.orderData,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'orderData': orderData?.toMap(),
      'message': message,
    };
  }

  factory OrderStatusModel.fromMap(Map<String, dynamic> map) {
    return OrderStatusModel(
      orderData: map['orderData'] != null
          ? OrderData.fromMap(map['orderData'] as Map<String, dynamic>)
          : null,
      message: map['message'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory OrderStatusModel.fromJson(String source) =>
      OrderStatusModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  List<Object?> get props => [orderData, message];
}

class OrderData extends Equatable {
  final int id;
  final String userId;
  final String restaurantId;
  final String addressId;
  final String timeSlotId;
  final String orderType;
  final String deliveryDay;
  final String coupon;
  final String discountAmount;
  final String deliveryCharge;
  final String vat;
  final String total;
  final String grandTotal;
  final String paymentMethod;
  final String paymentStatus;
  final String orderStatus;
  final String isGuest;
  final String tnxInfo;
  final String deliveryAddress;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String deliveryManId;
  final String orderRequest;
  final String orderReqDate;
  final String orderReqAcceptDate;

  const OrderData({
    required this.id,
    required this.userId,
    required this.restaurantId,
    required this.addressId,
    required this.timeSlotId,
    required this.orderType,
    required this.deliveryDay,
    required this.coupon,
    required this.discountAmount,
    required this.deliveryCharge,
    required this.vat,
    required this.total,
    required this.grandTotal,
    required this.paymentMethod,
    required this.paymentStatus,
    required this.orderStatus,
    required this.isGuest,
    required this.tnxInfo,
    required this.deliveryAddress,
    required this.createdAt,
    required this.updatedAt,
    required this.deliveryManId,
    required this.orderRequest,
    required this.orderReqDate,
    required this.orderReqAcceptDate,
  });

  OrderData copyWith({
    int? id,
    String? userId,
    String? restaurantId,
    String? addressId,
    String? timeSlotId,
    String? orderType,
    String? deliveryDay,
    String? coupon,
    String? discountAmount,
    String? deliveryCharge,
    String? vat,
    String? total,
    String? grandTotal,
    String? paymentMethod,
    String? paymentStatus,
    String? orderStatus,
    String? isGuest,
    String? tnxInfo,
    String? deliveryAddress,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? deliveryManId,
    String? orderRequest,
    String? orderReqDate,
    String? orderReqAcceptDate,
  }) {
    return OrderData(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      restaurantId: restaurantId ?? this.restaurantId,
      addressId: addressId ?? this.addressId,
      timeSlotId: timeSlotId ?? this.timeSlotId,
      orderType: orderType ?? this.orderType,
      deliveryDay: deliveryDay ?? this.deliveryDay,
      coupon: coupon ?? this.coupon,
      discountAmount: discountAmount ?? this.discountAmount,
      deliveryCharge: deliveryCharge ?? this.deliveryCharge,
      vat: vat ?? this.vat,
      total: total ?? this.total,
      grandTotal: grandTotal ?? this.grandTotal,
      paymentMethod: paymentMethod ?? this.paymentMethod,
      paymentStatus: paymentStatus ?? this.paymentStatus,
      orderStatus: orderStatus ?? this.orderStatus,
      isGuest: isGuest ?? this.isGuest,
      tnxInfo: tnxInfo ?? this.tnxInfo,
      deliveryAddress: deliveryAddress ?? this.deliveryAddress,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      deliveryManId: deliveryManId ?? this.deliveryManId,
      orderRequest: orderRequest ?? this.orderRequest,
      orderReqDate: orderReqDate ?? this.orderReqDate,
      orderReqAcceptDate: orderReqAcceptDate ?? this.orderReqAcceptDate,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'user_id': userId,
      'restaurant_id': restaurantId,
      'address_id': addressId,
      'time_slot_id': timeSlotId,
      'order_type': orderType,
      'delivery_day': deliveryDay,
      'coupon': coupon,
      'discount_amount': discountAmount,
      'delivery_charge': deliveryCharge,
      'vat': vat,
      'total': total,
      'grand_total': grandTotal,
      'payment_method': paymentMethod,
      'payment_status': paymentStatus,
      'order_status': orderStatus,
      'is_guest': isGuest,
      'tnx_info': tnxInfo,
      'delivery_address': deliveryAddress,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
      'delivery_man_id': deliveryManId,
      'order_request': orderRequest,
      'order_req_date': orderReqDate,
      'order_req_accept_date': orderReqAcceptDate,
    };
  }

  factory OrderData.fromMap(Map<String, dynamic> map) {
    return OrderData(
      id: map['id'] ?? 0,
      userId: map['user_id'] ?? '',
      restaurantId: map['restaurant_id'] ?? '',
      addressId: map['address_id'] ?? '',
      timeSlotId: map['time_slot_id'] ?? '',
      orderType: map['order_type'] ?? '',
      deliveryDay: map['delivery_day'] ?? '',
      coupon: map['coupon'] ?? '',
      discountAmount: map['discount_amount'] ?? '',
      deliveryCharge: map['delivery_charge'] ?? '',
      vat: map['vat'] ?? '',
      total: map['total'] ?? '',
      grandTotal: map['grand_total'] ?? '',
      paymentMethod: map['payment_method'] ?? '',
      paymentStatus: map['payment_status'] ?? '',
      orderStatus: map['order_status'] ?? '',
      isGuest: map['is_guest'] ?? '',
      tnxInfo: map['tnx_info'] ?? '',
      deliveryAddress: map['delivery_address'] ?? '',
      createdAt: map['created_at'] != null
          ? DateTime.parse(map['created_at'])
          : DateTime.now(),
      updatedAt: map['updated_at'] != null
          ? DateTime.parse(map['updated_at'])
          : DateTime.now(),
      deliveryManId: map['delivery_man_id'] ?? '',
      orderRequest: map['order_request'] ?? '',
      orderReqDate: map['order_req_date'] ?? '',
      orderReqAcceptDate: map['order_req_accept_date'] ?? '',
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
    addressId,
    timeSlotId,
    orderType,
    deliveryDay,
    coupon,
    discountAmount,
    deliveryCharge,
    vat,
    total,
    grandTotal,
    paymentMethod,
    paymentStatus,
    orderStatus,
    isGuest,
    tnxInfo,
    deliveryAddress,
    createdAt,
    updatedAt,
    deliveryManId,
    orderRequest,
    orderReqDate,
    orderReqAcceptDate,
  ];
}