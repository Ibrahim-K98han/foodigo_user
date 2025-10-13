// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:equatable/equatable.dart';

import '../../../HomeData/feature_product_model.dart';

class ResDashboardModel extends Equatable {
  final RestaurantDisplay? restaurantDisplay;
  final Statistics? statistics;
  final List<RecentOrder>? recentOrder;
  final List<WithdrawHistory>? withdrawHistory;

  const ResDashboardModel({
    this.restaurantDisplay,
    this.statistics,
    this.recentOrder,
    this.withdrawHistory,
  });

  ResDashboardModel copyWith({
    RestaurantDisplay? restaurantDisplay,
    Statistics? statistics,
    List<RecentOrder>? recentOrder,
    List<WithdrawHistory>? withdrawHistory,
  }) {
    return ResDashboardModel(
      restaurantDisplay: restaurantDisplay ?? this.restaurantDisplay,
      statistics: statistics ?? this.statistics,
      recentOrder: recentOrder ?? this.recentOrder,
      withdrawHistory: withdrawHistory ?? this.withdrawHistory,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'restaurant': restaurantDisplay?.toMap(),
      'statistics': statistics?.toMap(),
      'recent_orders': recentOrder!.map((x) => x.toMap()).toList(),
      'withdraw_history': withdrawHistory!.map((x) => x.toMap()).toList(),
    };
  }

  factory ResDashboardModel.fromMap(Map<String, dynamic> map) {
    return ResDashboardModel(
      restaurantDisplay:
          map['restaurant'] != null
              ? RestaurantDisplay.fromMap(
                map['restaurant'] as Map<String, dynamic>,
              )
              : null,
      statistics:
          map['statistics'] != null
              ? Statistics.fromMap(map['statistics'] as Map<String, dynamic>)
              : null,
      recentOrder:
          map['recent_orders'] != null
              ? List<RecentOrder>.from(
                (map['recent_orders']['data'] as List<dynamic>)
                    .map<RecentOrder?>(
                      (x) => RecentOrder.fromMap(x as Map<String, dynamic>),
                    ),
              )
              : null,
      withdrawHistory:
          map['withdraw_history'] != null
              ? List<WithdrawHistory>.from(
                (map['withdraw_history'] as List<dynamic>)
                    .map<WithdrawHistory?>(
                      (x) => WithdrawHistory.fromMap(x as Map<String, dynamic>),
                    ),
              )
              : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory ResDashboardModel.fromJson(String source) =>
      ResDashboardModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;

  @override
  List<Object?> get props => [
    restaurantDisplay,
    statistics,
    recentOrder,
    withdrawHistory,
  ];
}

class RestaurantDisplay extends Equatable {
  final int id;
  final String name;
  final String email;
  final String logo;

  const RestaurantDisplay({
    required this.id,
    required this.name,
    required this.email,
    required this.logo,
  });

  RestaurantDisplay copyWith({
    int? id,
    String? name,
    String? email,
    String? logo,
  }) {
    return RestaurantDisplay(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      logo: logo ?? this.logo,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'email': email,
      'logo': logo,
    };
  }

  factory RestaurantDisplay.fromMap(Map<String, dynamic> map) {
    return RestaurantDisplay(
      id: map['id'] as int,
      name: map['name'] as String,
      email: map['email'] as String,
      logo: map['logo'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory RestaurantDisplay.fromJson(String source) =>
      RestaurantDisplay.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;

  @override
  List<Object> get props => [id, name, email, logo];
}

class Statistics extends Equatable {
  final OrderStatistics? orderStatistics;
  final FinancialStatistics? financialStatistics;
  final CommissionStatistics? commissionStatistics;

  const Statistics({
    this.orderStatistics,
    this.financialStatistics,
    this.commissionStatistics,
  });

  Statistics copyWith({
    OrderStatistics? orderStatistics,
    FinancialStatistics? financialStatistics,
    CommissionStatistics? commissionStatistics,
  }) {
    return Statistics(
      orderStatistics: orderStatistics ?? this.orderStatistics,
      financialStatistics: financialStatistics ?? this.financialStatistics,
      commissionStatistics: commissionStatistics ?? this.commissionStatistics,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'orders': orderStatistics?.toMap(),
      'financial': financialStatistics?.toMap(),
      'commission': commissionStatistics?.toMap(),
    };
  }

  factory Statistics.fromMap(Map<String, dynamic> map) {
    return Statistics(
      orderStatistics:
          map['orders'] != null
              ? OrderStatistics.fromMap(map['orders'] as Map<String, dynamic>)
              : null,
      financialStatistics:
          map['financial'] != null
              ? FinancialStatistics.fromMap(
                map['financial'] as Map<String, dynamic>,
              )
              : null,
      commissionStatistics:
          map['commission'] != null
              ? CommissionStatistics.fromMap(
                map['commission'] as Map<String, dynamic>,
              )
              : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Statistics.fromJson(String source) =>
      Statistics.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;

  @override
  List<Object> get props => [
    orderStatistics!,
    financialStatistics!,
    commissionStatistics!,
  ];
}

class OrderStatistics extends Equatable {
  final int active;
  final int pending;
  final int completed;
  final int cancelled;
  final int total;

  const OrderStatistics({
    required this.active,
    required this.pending,
    required this.completed,
    required this.cancelled,
    required this.total,
  });

  OrderStatistics copyWith({
    int? active,
    int? pending,
    int? completed,
    int? cancelled,
    int? total,
  }) {
    return OrderStatistics(
      active: active ?? this.active,
      pending: pending ?? this.pending,
      completed: completed ?? this.completed,
      cancelled: cancelled ?? this.cancelled,
      total: total ?? this.total,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'active': active,
      'pending': pending,
      'completed': completed,
      'cancelled': cancelled,
      'total': total,
    };
  }

  factory OrderStatistics.fromMap(Map<String, dynamic> map) {
    return OrderStatistics(
      active: map['active'] ?? 0,
      pending: map['pending'] ?? 0,
      completed: map['completed'] ?? 0,
      cancelled: map['cancelled'] ?? 0,
      total: map['total'] ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory OrderStatistics.fromJson(String source) =>
      OrderStatistics.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;

  @override
  List<Object> get props {
    return [active, pending, completed, cancelled, total];
  }
}

class FinancialStatistics extends Equatable {
  final String totalIncome;
  final String totalCommission;
  final String netIncome;
  final String currentBalance;
  final String totalWithdrawn;
  final String pendingWithdrawal;

  const FinancialStatistics({
    required this.totalIncome,
    required this.totalCommission,
    required this.netIncome,
    required this.currentBalance,
    required this.totalWithdrawn,
    required this.pendingWithdrawal,
  });

  FinancialStatistics copyWith({
    String? totalIncome,
    String? totalCommission,
    String? netIncome,
    String? currentBalance,
    String? totalWithdrawn,
    String? pendingWithdrawal,
  }) {
    return FinancialStatistics(
      totalIncome: totalIncome ?? this.totalIncome,
      totalCommission: totalCommission ?? this.totalCommission,
      netIncome: netIncome ?? this.netIncome,
      currentBalance: currentBalance ?? this.currentBalance,
      totalWithdrawn: totalWithdrawn ?? this.totalWithdrawn,
      pendingWithdrawal: pendingWithdrawal ?? this.pendingWithdrawal,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'total_income': totalIncome,
      'total_commission': totalCommission,
      'net_income': netIncome,
      'current_balance': currentBalance,
      'total_withdrawn': totalWithdrawn,
      'pending_withdrawal': pendingWithdrawal,
    };
  }

  factory FinancialStatistics.fromMap(Map<String, dynamic> map) {
    return FinancialStatistics(
      totalIncome: map['total_income'] ?? '',
      totalCommission: map['total_commission'] ?? '',
      netIncome: map['net_income'] ?? '',
      currentBalance: map['current_balance'] ?? '',
      totalWithdrawn: map['total_withdrawn'] ?? '',
      pendingWithdrawal: map['pending_withdrawal'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory FinancialStatistics.fromJson(String source) =>
      FinancialStatistics.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;

  @override
  List<Object> get props {
    return [
      totalIncome,
      totalCommission,
      netIncome,
      currentBalance,
      totalWithdrawn,
      pendingWithdrawal,
    ];
  }
}

class CommissionStatistics extends Equatable {
  final String type;
  final String rate;

  const CommissionStatistics({required this.type, required this.rate});

  CommissionStatistics copyWith({String? type, String? rate}) {
    return CommissionStatistics(
      type: type ?? this.type,
      rate: rate ?? this.rate,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{'type': type, 'rate': rate};
  }

  factory CommissionStatistics.fromMap(Map<String, dynamic> map) {
    return CommissionStatistics(
      type: map['type'] ?? '',
      rate: map['rate'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory CommissionStatistics.fromJson(String source) =>
      CommissionStatistics.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;

  @override
  List<Object> get props => [type, rate];
}

class RecentOrder extends Equatable {
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
  final DeliveryAddress? deliveryAddress;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String deliveryManId;
  final String orderRequest;
  final String orderReqDate;
  final String orderReqAcceptDate;
  final Restaurant restaurant;
  final dynamic address;
  final User? user;
  final List<Item>? items;
  final dynamic deliveryman;

  const RecentOrder({
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
    required this.restaurant,
    required this.address,
    this.user,
    this.items,
    required this.deliveryman,
  });

  RecentOrder copyWith({
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
    DeliveryAddress? deliveryAddress,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? deliveryManId,
    String? orderRequest,
    String? orderReqDate,
    String? orderReqAcceptDate,
    Restaurant? restaurant,
    dynamic address,
    User? user,
    List<Item>? items,
    dynamic deliveryman,
  }) {
    return RecentOrder(
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
      address: address ?? this.address,
      user: user ?? this.user,
      items: items ?? this.items,
      deliveryman: deliveryman ?? this.deliveryman,
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
      'created_at': createdAt.millisecondsSinceEpoch,
      'updated_at': updatedAt.millisecondsSinceEpoch,
      'delivery_man_id': deliveryManId,
      'order_request': orderRequest,
      'order_req_date': orderReqDate,
      'order_req_accept_date': orderReqAcceptDate,
      'restaurant': restaurant.toMap(),
      'address': address,
      'user': user?.toMap(),
      'items': items?.map((x) => x.toMap()).toList(),
      'deliveryman': deliveryman,
    };
  }

  factory RecentOrder.fromMap(Map<String, dynamic> map) {
    return RecentOrder(
      id: map['id'] ?? 0,
      userId: map['userId'] ?? '',
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
      deliveryAddress:
          map['delivery_address'] != null
              ? DeliveryAddress.fromMap(
                jsonDecode(map['delivery_address'] as String),
              )
              : null,
      createdAt:
          map['created_at'] != null
              ? DateTime.parse(map['created_at'])
              : DateTime.now(),
      // or any default
      updatedAt:
          map['updated_at'] != null
              ? DateTime.parse(map['updated_at'])
              : DateTime.now(),
      deliveryManId: map['delivery_man_id'] ?? '',
      orderRequest: map['order_request'] ?? '',
      orderReqDate: map['order_req_date'] ?? '',
      orderReqAcceptDate: map['order_req_accept_date'] ?? '',
      restaurant: Restaurant.fromMap(map['restaurant'] as Map<String, dynamic>),
      address: map['address'] as dynamic,
      user:
          map['user'] != null
              ? User.fromMap(map['user'] as Map<String, dynamic>)
              : null,
      items:
          map['items'] != null
              ? List<Item>.from(
                (map['items'] as List<dynamic>).map((x) => Item.fromMap(x)),
              )
              : [],
      deliveryman: map['deliveryman'] as dynamic,
    );
  }

  String toJson() => json.encode(toMap());

  factory RecentOrder.fromJson(String source) =>
      RecentOrder.fromMap(json.decode(source) as Map<String, dynamic>);

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
    address,
    user,
    items,
    deliveryman,
  ];
}

class DeliveryAddress extends Equatable {
  final int id;
  final String userId;
  final String name;
  final String lat;
  final String lon;
  final String email;
  final String phone;
  final String address;
  final String deliveryType;
  final String isGuest;
  final DateTime createdAt;
  final DateTime updatedAt;

  const DeliveryAddress({
    required this.id,
    required this.userId,
    required this.name,
    required this.lat,
    required this.lon,
    required this.email,
    required this.phone,
    required this.address,
    required this.deliveryType,
    required this.isGuest,
    required this.createdAt,
    required this.updatedAt,
  });

  DeliveryAddress copyWith({
    int? id,
    String? userId,
    String? name,
    String? lat,
    String? lon,
    String? email,
    String? phone,
    String? address,
    String? deliveryType,
    String? isGuest,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return DeliveryAddress(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      name: name ?? this.name,
      lat: lat ?? this.lat,
      lon: lon ?? this.lon,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      address: address ?? this.address,
      deliveryType: deliveryType ?? this.deliveryType,
      isGuest: isGuest ?? this.isGuest,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'user_id': userId,
      'name': name,
      'lat': lat,
      'lon': lon,
      'email': email,
      'phone': phone,
      'address': address,
      'delivery_type': deliveryType,
      'is_guest': isGuest,
      'created_at': createdAt.millisecondsSinceEpoch,
      'updated_at': updatedAt.millisecondsSinceEpoch,
    };
  }

  factory DeliveryAddress.fromMap(Map<String, dynamic> map) {
    return DeliveryAddress(
      id: map['id'] ?? 0,
      userId: map['user_id']?.toString() ?? '',
      name: map['name'] ?? '',
      lat: map['lat'] ?? '',
      lon: map['lon'] ?? '',
      email: map['email'] ?? '',
      phone: map['phone'] ?? '',
      address: map['address'] ?? '',
      deliveryType: map['delivery_type'] ?? '',

      isGuest: map['is_guest']?.toString() ?? '',

      createdAt:
          map['created_at'] != null
              ? DateTime.parse(map['created_at'])
              : DateTime.now(),
      // or any default
      updatedAt:
          map['updated_at'] != null
              ? DateTime.parse(map['updated_at'])
              : DateTime.now(),
    );
  }

  String toJson() => json.encode(toMap());

  factory DeliveryAddress.fromJson(String source) =>
      DeliveryAddress.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  List<Object?> get props => [
    id,
    userId,
    name,
    lat,
    lon,
    email,
    phone,
    address,
    deliveryType,
    isGuest,
    createdAt,
    updatedAt,
  ];
}

class Restaurant extends Equatable {
  final int id;
  final String logo;
  final String coverImage;
  final String restaurantName;
  final String slug;
  final String cityId;
  final String cuisines;
  final String whatsapp;
  final String address;
  final String latitude;
  final String longitude;
  final String maxDeliveryDistance;
  final String ownerName;
  final String ownerEmail;
  final String ownerPhone;
  final String name;
  final String email;
  final String password;
  final String openingHour;
  final String closingHour;
  final String minProcessingTime;
  final String maxProcessingTime;
  final String timeSlotSeparate;
  final String tags;
  final String isFeatured;
  final String isPickupOrder;
  final String isDeliveryOrder;
  final String adminApproval;
  final String isBanned;
  final String? forgetPasswordToken;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String isTrusted;

  const Restaurant({
    required this.id,
    required this.logo,
    required this.coverImage,
    required this.restaurantName,
    required this.slug,
    required this.cityId,
    required this.cuisines,
    required this.whatsapp,
    required this.address,
    required this.latitude,
    required this.longitude,
    required this.maxDeliveryDistance,
    required this.ownerName,
    required this.ownerEmail,
    required this.ownerPhone,
    required this.name,
    required this.email,
    required this.password,
    required this.openingHour,
    required this.closingHour,
    required this.minProcessingTime,
    required this.maxProcessingTime,
    required this.timeSlotSeparate,
    required this.tags,
    required this.isFeatured,
    required this.isPickupOrder,
    required this.isDeliveryOrder,
    required this.adminApproval,
    required this.isBanned,
    this.forgetPasswordToken,
    required this.createdAt,
    required this.updatedAt,
    required this.isTrusted,
  });

  Restaurant copyWith({
    int? id,
    String? logo,
    String? coverImage,
    String? restaurantName,
    String? slug,
    String? cityId,
    String? cuisines,
    String? whatsapp,
    String? address,
    String? latitude,
    String? longitude,
    String? maxDeliveryDistance,
    String? ownerName,
    String? ownerEmail,
    String? ownerPhone,
    String? name,
    String? email,
    String? password,
    String? openingHour,
    String? closingHour,
    String? minProcessingTime,
    String? maxProcessingTime,
    String? timeSlotSeparate,
    String? tags,
    String? isFeatured,
    String? isPickupOrder,
    String? isDeliveryOrder,
    String? adminApproval,
    String? isBanned,
    String? forgetPasswordToken,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? isTrusted,
  }) {
    return Restaurant(
      id: id ?? this.id,
      logo: logo ?? this.logo,
      coverImage: coverImage ?? this.coverImage,
      restaurantName: restaurantName ?? this.restaurantName,
      slug: slug ?? this.slug,
      cityId: cityId ?? this.cityId,
      cuisines: cuisines ?? this.cuisines,
      whatsapp: whatsapp ?? this.whatsapp,
      address: address ?? this.address,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      maxDeliveryDistance: maxDeliveryDistance ?? this.maxDeliveryDistance,
      ownerName: ownerName ?? this.ownerName,
      ownerEmail: ownerEmail ?? this.ownerEmail,
      ownerPhone: ownerPhone ?? this.ownerPhone,
      name: name ?? this.name,
      email: email ?? this.email,
      password: password ?? this.password,
      openingHour: openingHour ?? this.openingHour,
      closingHour: closingHour ?? this.closingHour,
      minProcessingTime: minProcessingTime ?? this.minProcessingTime,
      maxProcessingTime: maxProcessingTime ?? this.maxProcessingTime,
      timeSlotSeparate: timeSlotSeparate ?? this.timeSlotSeparate,
      tags: tags ?? this.tags,
      isFeatured: isFeatured ?? this.isFeatured,
      isPickupOrder: isPickupOrder ?? this.isPickupOrder,
      isDeliveryOrder: isDeliveryOrder ?? this.isDeliveryOrder,
      adminApproval: adminApproval ?? this.adminApproval,
      isBanned: isBanned ?? this.isBanned,
      forgetPasswordToken: forgetPasswordToken ?? this.forgetPasswordToken,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      isTrusted: isTrusted ?? this.isTrusted,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'logo': logo,
      'cover_image': coverImage,
      'restaurant_name': restaurantName,
      'slug': slug,
      'city_id': cityId,
      'cuisines': cuisines,
      'whatsapp': whatsapp,
      'address': address,
      'latitude': latitude,
      'longitude': longitude,
      'max_delivery_distance': maxDeliveryDistance,
      'owner_name': ownerName,
      'owner_email': ownerEmail,
      'owner_phone': ownerPhone,
      'name': name,
      'email': email,
      'password': password,
      'opening_hour': openingHour,
      'closing_hour': closingHour,
      'min_processing_time': minProcessingTime,
      'max_processing_time': maxProcessingTime,
      'time_slot_separate': timeSlotSeparate,
      'tags': tags,
      'is_featured': isFeatured,
      'is_pickup_order': isPickupOrder,
      'is_delivery_order': isDeliveryOrder,
      'admin_approval': adminApproval,
      'is_banned': isBanned,
      'forget_password_token': forgetPasswordToken,
      'created_at': createdAt.millisecondsSinceEpoch,
      'updated_at': updatedAt.millisecondsSinceEpoch,
      'is_trusted': isTrusted,
    };
  }

  factory Restaurant.fromMap(Map<String, dynamic> map) {
    return Restaurant(
      id: map['id'] ?? 0,
      logo: map['logo'] ?? '',
      coverImage: map['cover_image'] ?? '',
      restaurantName: map['restaurant_name'] ?? '',
      slug: map['slug'] ?? '',
      cityId: map['city_id'] ?? '',
      cuisines: map['cuisines'] ?? '',
      whatsapp: map['whatsapp'] ?? '',
      address: map['address'] ?? '',
      latitude: map['latitude'] ?? '',
      longitude: map['longitude'] ?? '',
      maxDeliveryDistance: map['max_delivery_distance'] ?? '',
      ownerName: map['owner_name'] ?? '',
      ownerEmail: map['owner_email'] ?? '',
      ownerPhone: map['owner_phone'] ?? '',
      name: map['name'] ?? '',
      email: map['email'] ?? '',
      password: map['password'] ?? '',
      openingHour: map['opening_hour'] ?? '',
      closingHour: map['closing_hour'] ?? '',
      minProcessingTime: map['min_processing_time'] ?? '',
      maxProcessingTime: map['max_processing_time'] ?? '',
      timeSlotSeparate: map['time_slot_separate'] ?? '',
      tags: map['tags'] ?? '',
      isFeatured: map['is_featured'] ?? '',
      isPickupOrder: map['is_pickup_order'] ?? '',
      isDeliveryOrder: map['is_delivery_order'] ?? '',
      adminApproval: map['admin_approval'] ?? '',
      isBanned: map['is_banned'] ?? '',
      forgetPasswordToken:
          map['forget_password_token'] != null
              ? map['forget_password_token'] as String
              : null,
      createdAt:
          map['created_at'] != null
              ? DateTime.parse(map['created_at'])
              : DateTime.now(),
      // or any default
      updatedAt:
          map['updated_at'] != null
              ? DateTime.parse(map['updated_at'])
              : DateTime.now(),
      isTrusted: map['is_trusted'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory Restaurant.fromJson(String source) =>
      Restaurant.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  List<Object?> get props => [
    id,
    logo,
    coverImage,
    restaurantName,
    slug,
    cityId,
    cuisines,
    whatsapp,
    address,
    latitude,
    longitude,
    maxDeliveryDistance,
    ownerName,
    ownerEmail,
    ownerPhone,
    name,
    email,
    password,
    openingHour,
    closingHour,
    minProcessingTime,
    maxProcessingTime,
    timeSlotSeparate,
    tags,
    isFeatured,
    isPickupOrder,
    isDeliveryOrder,
    adminApproval,
    isBanned,
    forgetPasswordToken,
    createdAt,
    updatedAt,
    isTrusted,
  ];
}

class User extends Equatable {
  final int id;
  final String name;
  final String email;
  final DateTime emailVerifiedAt;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String status;
  final String image;
  final String phone;
  final String address;
  final String verificationToken;
  final String forgetPasswordToken;
  final String isBanned;
  final String readableId;

  const User({
    required this.id,
    required this.name,
    required this.email,
    required this.emailVerifiedAt,
    required this.createdAt,
    required this.updatedAt,
    required this.status,
    required this.image,
    required this.phone,
    required this.address,
    required this.verificationToken,
    required this.forgetPasswordToken,
    required this.isBanned,
    required this.readableId,
  });

  User copyWith({
    int? id,
    String? name,
    String? email,
    DateTime? emailVerifiedAt,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? status,
    String? image,
    String? phone,
    String? address,
    String? verificationToken,
    String? forgetPasswordToken,
    String? isBanned,
    String? readableId,
  }) {
    return User(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      emailVerifiedAt: emailVerifiedAt ?? this.emailVerifiedAt,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      status: status ?? this.status,
      image: image ?? this.image,
      phone: phone ?? this.phone,
      address: address ?? this.address,
      verificationToken: verificationToken ?? this.verificationToken,
      forgetPasswordToken: forgetPasswordToken ?? this.forgetPasswordToken,
      isBanned: isBanned ?? this.isBanned,
      readableId: readableId ?? this.readableId,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'email': email,
      'email_verified_at': emailVerifiedAt.millisecondsSinceEpoch,
      'created_at': createdAt.millisecondsSinceEpoch,
      'updated_at': updatedAt.millisecondsSinceEpoch,
      'status': status,
      'image': image,
      'phone': phone,
      'address': address,
      'verification_token': verificationToken,
      'forget_password_token': forgetPasswordToken,
      'is_banned': isBanned,
      'readable_id': readableId,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['id'] ?? 0,
      name: map['name'] ?? '',
      email: map['email'] ?? '',
      emailVerifiedAt:
          map['email_verified_at'] != null
              ? DateTime.parse(map['email_verified_at'])
              : DateTime.now(),

      createdAt:
          map['created_at'] != null
              ? DateTime.parse(map['created_at'])
              : DateTime.now(),
      // or any default
      updatedAt:
          map['updated_at'] != null
              ? DateTime.parse(map['updated_at'])
              : DateTime.now(),
      status: map['status'] ?? '',
      image: map['image'] ?? '',
      phone: map['phone'] ?? '',
      address: map['address'] ?? '',
      verificationToken: map['verification_token'] ?? '',
      forgetPasswordToken: map['forget_password_token'] ?? '',
      isBanned: map['is_banned'] ?? '',
      readableId: map['readable_id'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) =>
      User.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;

  @override
  List<Object> get props {
    return [
      id,
      name,
      email,
      emailVerifiedAt,
      createdAt,
      updatedAt,
      status,
      image,
      phone,
      address,
      verificationToken,
      forgetPasswordToken,
      isBanned,
      readableId,
    ];
  }
}

class Item extends Equatable {
  final int id;
  final String orderId;
  final String productId;
  final Map<String, String> size;
  // final Map<String, String> addons;
  final List<AddonDetails>? detailsAddons;
  final String qty;
  final String total;
  final DateTime createdAt;
  final DateTime updatedAt;
  final Product? product;

  const Item({
    required this.id,
    required this.orderId,
    required this.productId,
    required this.size,
    // required this.addons,
    this.detailsAddons,
    required this.qty,
    required this.total,
    required this.createdAt,
    required this.updatedAt,
    this.product,
  });

  Item copyWith({
    int? id,
    String? orderId,
    String? productId,
    Map<String, String>? size,
    // Map<String, String>? addons,
    List<AddonDetails>? detailsAddons,
    String? qty,
    String? total,
    DateTime? createdAt,
    DateTime? updatedAt,
    Product? product,
  }) {
    return Item(
      id: id ?? this.id,
      orderId: orderId ?? this.orderId,
      productId: productId ?? this.productId,
      size: size ?? this.size,
      // addons: addons ?? this.addons,
      detailsAddons: detailsAddons ?? this.detailsAddons,
      qty: qty ?? this.qty,
      total: total ?? this.total,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      product: product ?? this.product,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'order_id': orderId,
      'product_id': productId,
      'size': jsonEncode(size),
      // 'addons': jsonEncode(addons),
      'addon_details': detailsAddons?.map((x) => x.toMap()).toList(),
      'qty': qty,
      'total': total,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
      'products': product?.toMap(),
    };
  }

  factory Item.fromMap(Map<String, dynamic> map) {
    // Safe JSON decoding helper
    Map<String, String> decodeStringMap(dynamic jsonStr) {
      if (jsonStr == null || jsonStr.toString().isEmpty) return {};
      try {
        final decoded = jsonDecode(jsonStr);
        if (decoded is Map) {
          return decoded.map(
            (key, value) => MapEntry(key.toString(), value.toString()),
          );
        }
        return {};
      } catch (_) {
        return {};
      }
    }

    return Item(
      id:
          map['id'] is int
              ? map['id']
              : int.tryParse(map['id'].toString()) ?? 0,
      orderId: map['order_id']?.toString() ?? '',
      productId: map['product_id']?.toString() ?? '',
      size: decodeStringMap(map['size']),
      detailsAddons:
          map['addon_details'] != null
              ? List<AddonDetails>.from(
                (map['addon_details'] as List).map(
                  (x) => AddonDetails.fromMap(x as Map<String, dynamic>),
                ),
              )
              : null,
      qty: map['qty']?.toString() ?? '',
      total: map['total']?.toString() ?? '',
      createdAt: DateTime.tryParse(map['created_at'] ?? '') ?? DateTime.now(),
      updatedAt: DateTime.tryParse(map['updated_at'] ?? '') ?? DateTime.now(),
      product:
          map['products'] != null && map['products'] is Map<String, dynamic>
              ? Product.fromMap(map['products'])
              : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Item.fromJson(String source) =>
      Item.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  List<Object?> get props => [
    id,
    orderId,
    productId,
    size,
    detailsAddons,
    qty,
    total,
    createdAt,
    updatedAt,
    product,
  ];
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


class Product extends Equatable {
  final int id;
  final String slug;
  final String image;
  final String categoryId;
  final String restaurantId;
  final String price;
  final String offerPrice;
  final String status;
  final List<String> addonItems;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String isFeatured;
  final String name;
  final String shortDescription;
  final Map<String, String> size;

  const Product({
    required this.id,
    required this.slug,
    required this.image,
    required this.categoryId,
    required this.restaurantId,
    required this.price,
    required this.offerPrice,
    required this.status,
    required this.addonItems,
    required this.createdAt,
    required this.updatedAt,
    required this.isFeatured,
    required this.name,
    required this.shortDescription,
    required this.size,
  });

  Product copyWith({
    int? id,
    String? slug,
    String? image,
    String? categoryId,
    String? restaurantId,
    String? price,
    String? offerPrice,
    String? status,
    List<String>? addonItems,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? isFeatured,
    String? name,
    String? shortDescription,
    Map<String, String>? size,
  }) {
    return Product(
      id: id ?? this.id,
      slug: slug ?? this.slug,
      image: image ?? this.image,
      categoryId: categoryId ?? this.categoryId,
      restaurantId: restaurantId ?? this.restaurantId,
      price: price ?? this.price,
      offerPrice: offerPrice ?? this.offerPrice,
      status: status ?? this.status,
      addonItems: addonItems ?? this.addonItems,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      isFeatured: isFeatured ?? this.isFeatured,
      name: name ?? this.name,
      shortDescription: shortDescription ?? this.shortDescription,
      size: size ?? this.size,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'slug': slug,
      'image': image,
      'category_id': categoryId,
      'restaurant_id': restaurantId,
      'price': price,
      'offer_price': offerPrice,
      'status': status,
      'addon_items': addonItems,
      'created_at': createdAt.millisecondsSinceEpoch,
      'updated_at': updatedAt.millisecondsSinceEpoch,
      'is_featured': isFeatured,
      'name': name,
      'short_description': shortDescription,
      'size': size,
    };
  }

  factory Product.fromMap(Map<String, dynamic> map) {
    return Product(
      id: map['id'] ?? 0,
      slug: map['slug'] ?? '',
      image: map['image'] ?? '',
      categoryId: map['category_id'] ?? '',
      restaurantId: map['restaurant_id'] ?? '',
      price: map['price'] ?? '',
      offerPrice: map['offer_price'] ?? '',
      status: map['status'] ?? '',
      addonItems: () {
        final raw = map['addon_items'];
        if (raw == null) return <String>[];
        if (raw is String) {
          try {
            final decoded = jsonDecode(raw);
            if (decoded is List) {
              return List<String>.from(decoded.map((e) => e.toString()));
            }
            return <String>[];
          } catch (_) {
            return <String>[];
          }
        }
        if (raw is List) {
          return List<String>.from(raw.map((e) => e.toString()));
        }
        return <String>[];
      }(),

      createdAt:
          map['created_at'] != null
              ? DateTime.tryParse(map['created_at']) ?? DateTime.now()
              : DateTime.now(),
      updatedAt:
          map['updated_at'] != null
              ? DateTime.tryParse(map['updated_at']) ?? DateTime.now()
              : DateTime.now(),
      isFeatured: map['is_featured']?.toString() ?? '0',
      name: map['name'] ?? '',
      shortDescription: map['short_description'] ?? '',
      size: () {
        final raw = map['size'];
        if (raw == null) return <String, String>{};
        if (raw is String) {
          try {
            final decoded = jsonDecode(raw);
            if (decoded is Map) {
              return Map<String, String>.from(
                decoded.map((k, v) => MapEntry(k.toString(), v.toString())),
              );
            }
            return <String, String>{};
          } catch (_) {
            return <String, String>{};
          }
        }
        if (raw is Map) {
          return Map<String, String>.from(
            raw.map((k, v) => MapEntry(k.toString(), v.toString())),
          );
        }
        return <String, String>{};
      }(),
    );
  }

  String toJson() => json.encode(toMap());

  factory Product.fromJson(String source) =>
      Product.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;

  @override
  List<Object> get props {
    return [
      id,
      slug,
      image,
      categoryId,
      restaurantId,
      price,
      offerPrice,
      status,
      addonItems,
      createdAt,
      updatedAt,
      isFeatured,
      name,
      shortDescription,
      size,
    ];
  }
}

class WithdrawHistory extends Equatable {
  final int id;
  final String amount;
  final String status;
  final String method;
  final DateTime createdAt;

  const WithdrawHistory({
    required this.id,
    required this.amount,
    required this.status,
    required this.method,
    required this.createdAt,
  });

  WithdrawHistory copyWith({
    int? id,
    String? amount,
    String? status,
    String? method,
    DateTime? createdAt,
  }) {
    return WithdrawHistory(
      id: id ?? this.id,
      amount: amount ?? this.amount,
      status: status ?? this.status,
      method: method ?? this.method,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'amount': amount,
      'status': status,
      'method': method,
      'created_at': createdAt.millisecondsSinceEpoch,
    };
  }

  factory WithdrawHistory.fromMap(Map<String, dynamic> map) {
    return WithdrawHistory(
      id: map['id'] ?? 0,
      amount: map['amount'] ?? '',
      status: map['status'] ?? '',
      method: map['method'] ?? '',
      createdAt:
          map['created_at'] != null
              ? DateTime.parse(map['created_at'])
              : DateTime.now(),
    );
  }

  String toJson() => json.encode(toMap());

  factory WithdrawHistory.fromJson(String source) =>
      WithdrawHistory.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;

  @override
  List<Object> get props {
    return [id, amount, status, method, createdAt];
  }
}
