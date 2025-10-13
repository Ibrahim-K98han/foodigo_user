// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'package:equatable/equatable.dart';

class OrderModel extends Equatable {
  final int id;
  final String userId;
  final String restaurantId;
  final String addressId;
  final String? timeSlotId;
  final String orderType;
  final String? deliveryDay;
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
  final String createdAt;
  final String updatedAt;
  final String? deliveryManId;
  final String? orderRequest;
  final String? orderReqDate;
  final String? orderReqAcceptDate;
  final Restaurant? restaurant;
  final List<OrderItem>? items;

  const OrderModel({
    required this.id,
    required this.userId,
    required this.restaurantId,
    required this.addressId,
    this.timeSlotId,
    required this.orderType,
    this.deliveryDay,
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
    this.deliveryManId,
    this.orderRequest,
    this.orderReqDate,
    this.orderReqAcceptDate,
    this.restaurant,
    this.items,
  });

  OrderModel copyWith({
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
    String? createdAt,
    String? updatedAt,
    String? deliveryManId,
    String? orderRequest,
    String? orderReqDate,
    String? orderReqAcceptDate,
    Restaurant? restaurant,
    List<OrderItem>? items,
  }) {
    return OrderModel(
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
      restaurant: restaurant ?? this.restaurant,
      items: items ?? this.items,
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
      'created_at': createdAt,
      'updated_at': updatedAt,
      'delivery_man_id': deliveryManId,
      'order_request': orderRequest,
      'order_req_date': orderReqDate,
      'order_req_accept_date': orderReqAcceptDate,
      'restaurant': restaurant?.toMap(),
      'items': items?.map((x) => x.toMap()).toList(),
    };
  }

  factory OrderModel.fromMap(Map<String, dynamic> map) {
    return OrderModel(
      id: map['id'] ?? 0,
      userId: map['user_id'] ?? '',
      restaurantId: map['restaurant_id'] ?? '',
      addressId: map['address_id'] ?? '',
      timeSlotId: map['time_slot_id'],
      orderType: map['order_type'] ?? '',
      deliveryDay: map['delivery_day'],
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
      createdAt: map['created_at'] ?? '',
      updatedAt: map['updated_at'] ?? '',
      deliveryManId: map['delivery_man_id'],
      orderRequest: map['order_request'],
      orderReqDate: map['order_req_date'],
      orderReqAcceptDate: map['order_req_accept_date'],
      restaurant:
          map['restaurant'] != null
              ? Restaurant.fromMap(map['restaurant'] as Map<String, dynamic>)
              : null,
      items:
          map['items'] != null
              ? List<OrderItem>.from(
                (map['items'] as List).map((x) => OrderItem.fromMap(x)),
              )
              : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory OrderModel.fromJson(String source) =>
      OrderModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;

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
    restaurant,
    items,
  ];
}

class Restaurant extends Equatable {
  final int id;
  final String? restaurantName;
  final String? logo;
  final String? coverImage;
  final String? address;

  const Restaurant({
    required this.id,
    this.restaurantName,
    this.logo,
    this.coverImage,
    this.address,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'restaurant_name': restaurantName,
      'logo': logo,
      'cover_image': coverImage,
      'address': address,
    };
  }

  factory Restaurant.fromMap(Map<String, dynamic> map) {
    return Restaurant(
      id: map['id'] ?? 0,
      restaurantName: map['restaurant_name'],
      logo: map['logo'],
      coverImage: map['cover_image'],
      address: map['address'],
    );
  }

  @override
  List<Object?> get props => [id, restaurantName, logo, coverImage, address];
}

class OrderItem extends Equatable {
  final int id;
  final String orderId;
  final String productId;
  final String size;
  final String qty;
  final String total;
  final String createdAt;
  final String updatedAt;

  const OrderItem({
    required this.id,
    required this.orderId,
    required this.productId,
    required this.size,

    required this.qty,
    required this.total,
    required this.createdAt,
    required this.updatedAt,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'order_id': orderId,
      'product_id': productId,
      'size': size,
      'qty': qty,
      'total': total,
      'created_at': createdAt,
      'updated_at': updatedAt,
    };
  }

  factory OrderItem.fromMap(Map<String, dynamic> map) {
    return OrderItem(
      id: map['id'] ?? 0,
      orderId: map['order_id'] ?? '',
      productId: map['product_id'] ?? '',
      size: map['size'] ?? '',
      qty: map['qty'] ?? '',
      total: map['total'] ?? '',
      createdAt: map['created_at'] ?? '',
      updatedAt: map['updated_at'] ?? '',
    );
  }

  @override
  List<Object?> get props => [
    id,
    orderId,
    productId,
    size,
    qty,
    total,
    createdAt,
    updatedAt,
  ];
}
