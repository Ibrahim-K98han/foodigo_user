// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'package:equatable/equatable.dart';
import '../../SingleRestaurant/model/single_restaurant_model.dart';
import 'order_model.dart';

class OrderDetails extends Equatable {
  final int? id;
  final String? userId;
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
  final String createdAt;
  final String updatedAt;
  final String deliveryManId;
  final String orderRequest;
  final String orderReqDate;
  final String orderReqAcceptDate;
  final Restaurant? restaurant;
  final List<Items>? items;
  final String deliveryMan;

  const OrderDetails({
    this.id,
    this.userId,
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
    required this.restaurant,
    this.items,
    required this.deliveryMan,
  });

  OrderDetails copyWith({
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
    List<Items>? items,
    String? deliveryMan,
  }) {
    return OrderDetails(
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
      deliveryMan: deliveryMan ?? this.deliveryMan,
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
      'delivery_man': deliveryMan,
    };
  }

  factory OrderDetails.fromMap(Map<String, dynamic> map) {
    return OrderDetails(
      id: map['id'] ?? 0,
      userId: map['user_id']?.toString(),
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
      createdAt: map['created_at'] ?? '',
      updatedAt: map['updated_at'] ?? '',
      deliveryManId: map['delivery_man_id'] ?? '',
      orderRequest: map['order_request'] ?? '',
      orderReqDate: map['order_req_date'] ?? '',
      orderReqAcceptDate: map['order_req_accept_date'] ?? '',
      restaurant: map['restaurant'] != null
          ? Restaurant.fromMap(map['restaurant'] as Map<String, dynamic>)
          : null,
      items: map['items'] != null
          ? List<Items>.from(
              (map['items'] as List<dynamic>).map<Items?>(
                (x) => Items.fromMap(x as Map<String, dynamic>),
              ),
            )
          : null,
      deliveryMan: map['delivery_man'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory OrderDetails.fromJson(String source) =>
      OrderDetails.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;

  @override
  List<Object> get props {
    return [
      id!,
      userId!,
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
      restaurant!,
      items!,
      deliveryMan,
    ];
  }
}

class Items extends Equatable {
  final int id;
  final String orderId;
  final String productId;
  final String size;
  final List<AddonDetails>? detailsAddons;
  final String qty;
  final String total;
  final String createdAt;
  final String updatedAt;
  final Products? products;

  const Items({
    required this.id,
    required this.orderId,
    required this.productId,
    required this.size,
    this.detailsAddons,
    required this.qty,
    required this.total,
    required this.createdAt,
    required this.updatedAt,
    this.products,
  });

  Items copyWith({
    int? id,
    String? orderId,
    String? productId,
    String? size,
    String? qty,
    String? total,
    String? createdAt,
    String? updatedAt,
    Products? products,
  }) {
    return Items(
      id: id ?? this.id,
      orderId: orderId ?? this.orderId,
      productId: productId ?? this.productId,
      size: size ?? this.size,
    qty: qty ?? this.qty,
      total: total ?? this.total,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      products: products ?? this.products,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'order_id': orderId,
      'product_id': productId,
      'size': size,
      'addon_details': detailsAddons?.map((x) => x.toMap()).toList(),
      'qty': qty,
      'total': total,
      'created_at': createdAt,
      'updated_at': updatedAt,
      'products': products?.toMap(),
    };
  }

  factory Items.fromMap(Map<String, dynamic> map) {
    return Items(
      id: map['id'] ?? 0,
      orderId: map['order_id'] ?? '',
      productId: map['product_id'] ?? '',
      size: map['size'] ?? '',
      detailsAddons:
      map['addon_details'] != null
          ? List<AddonDetails>.from(
        (map['addon_details'] as List).map(
              (x) => AddonDetails.fromMap(x as Map<String, dynamic>),
        ),
      )
          : null,
      qty: map['qty'] ?? '',
      total: map['total'] ?? '',
      createdAt: map['created_at'] ?? '',
      updatedAt: map['updated_at'] ?? '',
      products: map['products'] != null
          ? Products.fromMap(map['products'] as Map<String, dynamic>)
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Items.fromJson(String source) =>
      Items.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;

  @override
  List<Object> get props {
    return [
      id,
      orderId,
      productId,
      size,
      detailsAddons!,
      qty,
      total,
      createdAt,
      updatedAt,
      products!,
    ];
  }
}

class AddonDetails extends Equatable {
  final int id;
  final String name;
  final String price;
  final int quantity;
  const AddonDetails({
    required this.id,
    required this.name,
    required this.price,
    required this.quantity,
  });

  AddonDetails copyWith({
    int? id,
    String? name,
    String? price,
    int? quantity,
  }) {
    return AddonDetails(
      id: id ?? this.id,
      name: name ?? this.name,
      price: price ?? this.price,
      quantity: quantity ?? this.quantity,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'price': price,
      'quantity': quantity,
    };
  }

  factory AddonDetails.fromMap(Map<String, dynamic> map) {
    return AddonDetails(
      id: map['id'] ??0,
      name: map['name'] ?? '',
      price: map['price'] ?? '',
      quantity: map['quantity'] ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory AddonDetails.fromJson(String source) => AddonDetails.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;

  @override
  List<Object> get props => [id, name, price, quantity];
}