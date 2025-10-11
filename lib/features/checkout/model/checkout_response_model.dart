// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:equatable/equatable.dart';

import '../../add_to_cart/model/add_cart_response_model.dart';

class CheckoutResponseModel extends Equatable {
  final CheckoutData? checkoutData;

  const CheckoutResponseModel({this.checkoutData});

  CheckoutResponseModel copyWith({
    bool? success,
    CheckoutData? data,
    String? message,
  }) {
    return CheckoutResponseModel(checkoutData: checkoutData ?? checkoutData);
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{'data': checkoutData?.toMap()};
  }

  factory CheckoutResponseModel.fromMap(Map<String, dynamic> map) {
    return CheckoutResponseModel(
      checkoutData:
          map['data'] != null
              ? CheckoutData.fromMap(map['data'] as Map<String, dynamic>)
              : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory CheckoutResponseModel.fromJson(String source) =>
      CheckoutResponseModel.fromMap(
        json.decode(source) as Map<String, dynamic>,
      );

  @override
  bool get stringify => true;

  @override
  List<Object?> get props => [checkoutData];
}

class CheckoutData extends Equatable {
  final Validation validation;
  final OrderSummary orderSummary;
  final DeliveryInfo deliveryInfo;
  final PricingBreakdown pricingBreakdown;
  final RestaurantInfo restaurantInfo;
  final AddressInfo addressInfo;
  final NextSteps nextSteps;

  const CheckoutData({
    required this.validation,
    required this.orderSummary,
    required this.deliveryInfo,
    required this.pricingBreakdown,
    required this.restaurantInfo,
    required this.addressInfo,
    required this.nextSteps,
  });

  CheckoutData copyWith({
    CartSummary? cartSummary,
    Validation? validation,
    OrderSummary? orderSummary,
    DeliveryInfo? deliveryInfo,
    PricingBreakdown? pricingBreakdown,
    RestaurantInfo? restaurantInfo,
    AddressInfo? addressInfo,
    NextSteps? nextSteps,
  }) {
    return CheckoutData(
      validation: validation ?? this.validation,
      orderSummary: orderSummary ?? this.orderSummary,
      deliveryInfo: deliveryInfo ?? this.deliveryInfo,
      pricingBreakdown: pricingBreakdown ?? this.pricingBreakdown,
      restaurantInfo: restaurantInfo ?? this.restaurantInfo,
      addressInfo: addressInfo ?? this.addressInfo,
      nextSteps: nextSteps ?? this.nextSteps,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'validation': validation.toMap(),
      'order_summary': orderSummary.toMap(),
      'delivery_info': deliveryInfo.toMap(),
      'pricing_breakdown': pricingBreakdown.toMap(),
      'restaurant_info': restaurantInfo.toMap(),
      'address_info': addressInfo.toMap(),
      'next_steps': nextSteps.toMap(),
    };
  }

  factory CheckoutData.fromMap(Map<String, dynamic> map) {
    return CheckoutData(
      validation:
          map['validation'] != null
              ? Validation.fromMap(map['validation'])
              : const Validation(
                addressValid: false,
                deliveryAvailable: false,
                paymentMethodValid: false,
                cartValid: false,
                distanceValid: false,
                minimumOrderMet: false,
              ),
      orderSummary:
          map['order_summary'] != null
              ? OrderSummary.fromMap(map['order_summary'])
              : const OrderSummary(
                cartItemsCount: 0,
                totalQuantity: 0,
                orderType: '',
                paymentMethod: '',
              ),
      deliveryInfo:
          map['delivery_info'] != null
              ? DeliveryInfo.fromMap(map['delivery_info'])
              : const DeliveryInfo(
                distanceKm: 0,
                maxDeliveryDistance: '',
                deliveryAvailable: false,
                estimatedDeliveryTime: '',
                deliveryInstructions: '',
              ),
      pricingBreakdown:
          map['pricing_breakdown'] != null
              ? PricingBreakdown.fromMap(map['pricing_breakdown'])
              : const PricingBreakdown(
                subtotal: 0,
                deliveryFee: 0,
                taxAmount: 0,
                taxRate: '',
                couponDiscount: 0,
                totalAmount: 0,
              ),
      restaurantInfo:
          map['restaurant_info'] != null
              ? RestaurantInfo.fromMap(map['restaurant_info'])
              : const RestaurantInfo(
                id: 0,
                name: '',
                address: '',
                phone: '',
                deliveryFeeBase: 0,
                minimumOrder: 0,
                maxDeliveryDistance: '',
              ),
      addressInfo:
          map['address_info'] != null
              ? AddressInfo.fromMap(map['address_info'])
              : const AddressInfo(
                id: 0,
                name: '',
                address: '',
                phone: '',
                email: '',
                deliveryType: '',
                coordinates: Coordinates(lat: '', lon: ''),
              ),
      nextSteps:
          map['next_steps'] != null
              ? NextSteps.fromMap(map['next_steps'])
              : const NextSteps(
                canProceed: false,
                message: '',
                requiredActions: [],
              ),
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object?> get props => [
    validation,
    orderSummary,
    deliveryInfo,
    pricingBreakdown,
    restaurantInfo,
    addressInfo,
    nextSteps,
  ];
}

class Validation extends Equatable {
  final bool addressValid;
  final bool deliveryAvailable;
  final bool paymentMethodValid;
  final bool cartValid;
  final bool distanceValid;
  final bool minimumOrderMet;

  const Validation({
    required this.addressValid,
    required this.deliveryAvailable,
    required this.paymentMethodValid,
    required this.cartValid,
    required this.distanceValid,
    required this.minimumOrderMet,
  });

  Map<String, dynamic> toMap() {
    return {
      'address_valid': addressValid,
      'delivery_available': deliveryAvailable,
      'payment_method_valid': paymentMethodValid,
      'cart_valid': cartValid,
      'distance_valid': distanceValid,
      'minimum_order_met': minimumOrderMet,
    };
  }

  factory Validation.fromMap(Map<String, dynamic> map) {
    return Validation(
      addressValid: map['address_valid'] ?? false,
      deliveryAvailable: map['delivery_available'] ?? false,
      paymentMethodValid: map['payment_method_valid'] ?? false,
      cartValid: map['cart_valid'] ?? false,
      distanceValid: map['distance_valid'] ?? false,
      minimumOrderMet: map['minimum_order_met'] ?? false,
    );
  }

  @override
  List<Object?> get props => [
    addressValid,
    deliveryAvailable,
    paymentMethodValid,
    cartValid,
    distanceValid,
    minimumOrderMet,
  ];
}

class OrderSummary extends Equatable {
  final int cartItemsCount;
  final int totalQuantity;
  final String orderType;
  final String paymentMethod;

  const OrderSummary({
    required this.cartItemsCount,
    required this.totalQuantity,
    required this.orderType,
    required this.paymentMethod,
  });

  Map<String, dynamic> toMap() {
    return {
      'cart_items_count': cartItemsCount,
      'total_quantity': totalQuantity,
      'order_type': orderType,
      'payment_method': paymentMethod,
    };
  }

  factory OrderSummary.fromMap(Map<String, dynamic> map) {
    return OrderSummary(
      cartItemsCount: map['cart_items_count'] ?? 0,
      totalQuantity: map['total_quantity'] ?? 0,
      orderType: map['order_type'] ?? '',
      paymentMethod: map['payment_method'] ?? '',
    );
  }

  @override
  List<Object?> get props => [
    cartItemsCount,
    totalQuantity,
    orderType,
    paymentMethod,
  ];
}

class DeliveryInfo extends Equatable {
  final double distanceKm;
  final String maxDeliveryDistance;
  final bool deliveryAvailable;
  final String estimatedDeliveryTime;
  final String deliveryInstructions;

  const DeliveryInfo({
    required this.distanceKm,
    required this.maxDeliveryDistance,
    required this.deliveryAvailable,
    required this.estimatedDeliveryTime,
    required this.deliveryInstructions,
  });

  Map<String, dynamic> toMap() {
    return {
      'distance_km': distanceKm,
      'max_delivery_distance': maxDeliveryDistance,
      'delivery_available': deliveryAvailable,
      'estimated_delivery_time': estimatedDeliveryTime,
      'delivery_instructions': deliveryInstructions,
    };
  }

  factory DeliveryInfo.fromMap(Map<String, dynamic> map) {
    return DeliveryInfo(
      distanceKm: (map['distance_km'] as num?)?.toDouble() ?? 0.0,
      maxDeliveryDistance: map['max_delivery_distance'] ?? '',
      deliveryAvailable: map['delivery_available'] ?? false,
      estimatedDeliveryTime: map['estimated_delivery_time'] ?? '',
      deliveryInstructions: map['delivery_instructions'] ?? '',
    );
  }

  @override
  List<Object?> get props => [
    distanceKm,
    maxDeliveryDistance,
    deliveryAvailable,
    estimatedDeliveryTime,
    deliveryInstructions,
  ];
}

class PricingBreakdown extends Equatable {
  final double subtotal;
  final double deliveryFee;
  final double taxAmount;
  final String taxRate;
  final double couponDiscount;
  final double totalAmount;

  const PricingBreakdown({
    required this.subtotal,
    required this.deliveryFee,
    required this.taxAmount,
    required this.taxRate,
    required this.couponDiscount,
    required this.totalAmount,
  });

  Map<String, dynamic> toMap() {
    return {
      'subtotal': subtotal,
      'delivery_fee': deliveryFee,
      'tax_amount': taxAmount,
      'tax_rate': taxRate,
      'coupon_discount': couponDiscount,
      'total_amount': totalAmount,
    };
  }

  factory PricingBreakdown.fromMap(Map<String, dynamic> map) {
    return PricingBreakdown(
      subtotal:
          map['subtotal'] != null
              ? double.parse(map['subtotal'].toString())
              : 0.0,
      deliveryFee:
          map['delivery_fee'] != null
              ? double.parse(map['delivery_fee'].toString())
              : 0.0,
      taxAmount:
          map['tax_amount'] != null
              ? double.parse(map['tax_amount'].toString())
              : 0.0,
      taxRate: map['tax_rate'] ?? '',
      couponDiscount:
          map['coupon_discount'] != null
              ? double.parse(map['coupon_discount'].toString())
              : 0.0,
      totalAmount:
          map['total_amount'] != null
              ? double.parse(map['total_amount'].toString())
              : 0.0,
    );
  }

  @override
  List<Object?> get props => [
    subtotal,
    deliveryFee,
    taxAmount,
    taxRate,
    couponDiscount,
    totalAmount,
  ];
}

class RestaurantInfo extends Equatable {
  final int id;
  final String name;
  final String address;
  final String phone;
  final double deliveryFeeBase;
  final double minimumOrder;
  final String maxDeliveryDistance;

  const RestaurantInfo({
    required this.id,
    required this.name,
    required this.address,
    required this.phone,
    required this.deliveryFeeBase,
    required this.minimumOrder,
    required this.maxDeliveryDistance,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'address': address,
      'phone': phone,
      'delivery_fee_base': deliveryFeeBase,
      'minimum_order': minimumOrder,
      'max_delivery_distance': maxDeliveryDistance,
    };
  }

  factory RestaurantInfo.fromMap(Map<String, dynamic> map) {
    return RestaurantInfo(
      id: map['id'] ?? 0,
      name: map['name'] ?? '',
      address: map['address'] ?? '',
      phone: map['phone'] ?? '',
      deliveryFeeBase: (map['delivery_fee_base'] as num?)?.toDouble() ?? 0.0,
      minimumOrder: (map['minimum_order'] as num?)?.toDouble() ?? 0.0,
      maxDeliveryDistance: map['max_delivery_distance'] ?? '',
    );
  }

  @override
  List<Object?> get props => [
    id,
    name,
    address,
    phone,
    deliveryFeeBase,
    minimumOrder,
    maxDeliveryDistance,
  ];
}

class AddressInfo extends Equatable {
  final int id;
  final String name;
  final String address;
  final String phone;
  final String email;
  final String deliveryType;
  final Coordinates coordinates;

  const AddressInfo({
    required this.id,
    required this.name,
    required this.address,
    required this.phone,
    required this.email,
    required this.deliveryType,
    required this.coordinates,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'address': address,
      'phone': phone,
      'email': email,
      'delivery_type': deliveryType,
      'coordinates': coordinates.toMap(),
    };
  }

  factory AddressInfo.fromMap(Map<String, dynamic> map) {
    return AddressInfo(
      id: map['id'] ?? 0,
      name: map['name'] ?? '',
      address: map['address'] ?? '',
      phone: map['phone'] ?? '',
      email: map['email'] ?? '',
      deliveryType: map['delivery_type'] ?? '',
      coordinates: Coordinates.fromMap(map['coordinates']),
    );
  }

  @override
  List<Object?> get props => [
    id,
    name,
    address,
    phone,
    email,
    deliveryType,
    coordinates,
  ];
}

class Coordinates extends Equatable {
  final String lat;
  final String lon;

  const Coordinates({required this.lat, required this.lon});

  Map<String, dynamic> toMap() {
    return {'lat': lat, 'lon': lon};
  }

  factory Coordinates.fromMap(Map<String, dynamic> map) {
    return Coordinates(lat: map['lat'] ?? '', lon: map['lon'] ?? '');
  }

  @override
  List<Object?> get props => [lat, lon];
}

class NextSteps extends Equatable {
  final bool canProceed;
  final String message;
  final List<dynamic> requiredActions;

  const NextSteps({
    required this.canProceed,
    required this.message,
    required this.requiredActions,
  });

  Map<String, dynamic> toMap() {
    return {
      'can_proceed': canProceed,
      'message': message,
      'required_actions': requiredActions,
    };
  }

  factory NextSteps.fromMap(Map<String, dynamic> map) {
    return NextSteps(
      canProceed: map['can_proceed'] ?? false,
      message: map['message'] ?? '',
      requiredActions:
          (map['required_actions'] as List<dynamic>? ?? []).toList(),
    );
  }

  @override
  List<Object?> get props => [canProceed, message, requiredActions];
}
