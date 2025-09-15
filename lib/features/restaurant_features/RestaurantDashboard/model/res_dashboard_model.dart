// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'package:equatable/equatable.dart';

class ResDashboardModel extends Equatable {
  final bool? success;
  final String? message;
  final Data? data;

  const ResDashboardModel({
    this.success,
    this.message,
    this.data,
  });

  ResDashboardModel copyWith({
    bool? success,
    String? message,
    Data? data,
  }) {
    return ResDashboardModel(
      success: success ?? this.success,
      message: message ?? this.message,
      data: data ?? this.data,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'success': success,
      'message': message,
      'data': data?.toMap(),
    };
  }

  factory ResDashboardModel.fromMap(Map<String, dynamic> map) {
    return ResDashboardModel(
      success: map['success'] ?? false,
      message: map['message'] ?? '',
      data: map['data'] != null ? Data.fromMap(map['data']) : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory ResDashboardModel.fromJson(String source) =>
      ResDashboardModel.fromMap(json.decode(source));

  @override
  List<Object?> get props => [success, message, data];
}

class Data extends Equatable {
  final Restaurant? restaurant;
  final OrderStatistics? orderStatistics;
  final FinancialSummary? financialSummary;
  final List<RecentOrders>? recentOrders;
  final List<RecentWithdrawals>? recentWithdrawals;
  final List<MonthlyEarnings>? monthlyEarnings;

  const Data({
    this.restaurant,
    this.orderStatistics,
    this.financialSummary,
    this.recentOrders,
    this.recentWithdrawals,
    this.monthlyEarnings,
  });

  Data copyWith({
    Restaurant? restaurant,
    OrderStatistics? orderStatistics,
    FinancialSummary? financialSummary,
    List<RecentOrders>? recentOrders,
    List<RecentWithdrawals>? recentWithdrawals,
    List<MonthlyEarnings>? monthlyEarnings,
  }) {
    return Data(
      restaurant: restaurant ?? this.restaurant,
      orderStatistics: orderStatistics ?? this.orderStatistics,
      financialSummary: financialSummary ?? this.financialSummary,
      recentOrders: recentOrders ?? this.recentOrders,
      recentWithdrawals: recentWithdrawals ?? this.recentWithdrawals,
      monthlyEarnings: monthlyEarnings ?? this.monthlyEarnings,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'restaurant': restaurant?.toMap(),
      'order_statistics': orderStatistics?.toMap(),
      'financial_summary': financialSummary?.toMap(),
      'recent_orders': recentOrders?.map((x) => x.toMap()).toList(),
      'recent_withdrawals': recentWithdrawals?.map((x) => x.toMap()).toList(),
      'monthly_earnings': monthlyEarnings?.map((x) => x.toMap()).toList(),
    };
  }

  factory Data.fromMap(Map<String, dynamic> map) {
    return Data(
      restaurant: map['restaurant'] != null
          ? Restaurant.fromMap(map['restaurant'])
          : null,
      orderStatistics: map['order_statistics'] != null
          ? OrderStatistics.fromMap(map['order_statistics'])
          : null,
      financialSummary: map['financial_summary'] != null
          ? FinancialSummary.fromMap(map['financial_summary'])
          : null,

      /// Safe parse for recentOrders
      recentOrders: map['recent_orders'] is List
          ? List<RecentOrders>.from(
          (map['recent_orders'] as List)
              .map((x) => RecentOrders.fromMap(x)))
          : [],

      /// Safe parse for recentWithdrawals
      recentWithdrawals: map['recent_withdrawals'] is List
          ? List<RecentWithdrawals>.from(
          (map['recent_withdrawals'] as List)
              .map((x) => RecentWithdrawals.fromMap(x)))
          : [],

      /// Safe parse for monthlyEarnings
      monthlyEarnings: map['monthly_earnings'] is List
          ? List<MonthlyEarnings>.from(
          (map['monthly_earnings'] as List)
              .map((x) => MonthlyEarnings.fromMap(x)))
          : [],
    );
  }


  @override
  List<Object?> get props => [
    restaurant,
    orderStatistics,
    financialSummary,
    recentOrders,
    recentWithdrawals,
    monthlyEarnings,
  ];
}

class Restaurant extends Equatable {
  final int? id;
  final String? name;
  final String? logo;

  const Restaurant({this.id, this.name, this.logo});

  Restaurant copyWith({int? id, String? name, String? logo}) {
    return Restaurant(
      id: id ?? this.id,
      name: name ?? this.name,
      logo: logo ?? this.logo,
    );
  }

  Map<String, dynamic> toMap() => {'id': id, 'name': name, 'logo': logo};

  factory Restaurant.fromMap(Map<String, dynamic> map) {
    return Restaurant(
      id: map['id'] ?? 0,
      name: map['name'] ?? '',
      logo: map['logo'] ?? '',
    );
  }

  @override
  List<Object?> get props => [id, name, logo];
}

class OrderStatistics extends Equatable {
  final int? pendingOrders;
  final int? processingOrders;
  final int? completedOrders;
  final int? cancelledOrders;
  final int? totalOrders;

  const OrderStatistics({
    this.pendingOrders,
    this.processingOrders,
    this.completedOrders,
    this.cancelledOrders,
    this.totalOrders,
  });

  OrderStatistics copyWith({
    int? pendingOrders,
    int? processingOrders,
    int? completedOrders,
    int? cancelledOrders,
    int? totalOrders,
  }) {
    return OrderStatistics(
      pendingOrders: pendingOrders ?? this.pendingOrders,
      processingOrders: processingOrders ?? this.processingOrders,
      completedOrders: completedOrders ?? this.completedOrders,
      cancelledOrders: cancelledOrders ?? this.cancelledOrders,
      totalOrders: totalOrders ?? this.totalOrders,
    );
  }

  Map<String, dynamic> toMap() => {
    'pending_orders': pendingOrders,
    'processing_orders': processingOrders,
    'completed_orders': completedOrders,
    'cancelled_orders': cancelledOrders,
    'total_orders': totalOrders,
  };

  factory OrderStatistics.fromMap(Map<String, dynamic> map) {
    return OrderStatistics(
      pendingOrders: map['pending_orders'] ?? 0,
      processingOrders: map['processing_orders'] ?? 0,
      completedOrders: map['completed_orders'] ?? 0,
      cancelledOrders: map['cancelled_orders'] ?? 0,
      totalOrders: map['total_orders'] ?? 0,
    );
  }

  @override
  List<Object?> get props =>
      [pendingOrders, processingOrders, completedOrders, cancelledOrders, totalOrders];
}

class FinancialSummary extends Equatable {
  final double? totalEarnings;
  final double? adminCommission;
  final double? netEarnings;
  final int? pendingWithdrawals;
  final int? completedWithdrawals;
  final double? availableBalance;
  final String? currency;

  const FinancialSummary({
    this.totalEarnings,
    this.adminCommission,
    this.netEarnings,
    this.pendingWithdrawals,
    this.completedWithdrawals,
    this.availableBalance,
    this.currency,
  });

  FinancialSummary copyWith({
    double? totalEarnings,
    double? adminCommission,
    double? netEarnings,
    int? pendingWithdrawals,
    int? completedWithdrawals,
    double? availableBalance,
    String? currency,
  }) {
    return FinancialSummary(
      totalEarnings: totalEarnings ?? this.totalEarnings,
      adminCommission: adminCommission ?? this.adminCommission,
      netEarnings: netEarnings ?? this.netEarnings,
      pendingWithdrawals: pendingWithdrawals ?? this.pendingWithdrawals,
      completedWithdrawals: completedWithdrawals ?? this.completedWithdrawals,
      availableBalance: availableBalance ?? this.availableBalance,
      currency: currency ?? this.currency,
    );
  }

  Map<String, dynamic> toMap() => {
    'total_earnings': totalEarnings,
    'admin_commission': adminCommission,
    'net_earnings': netEarnings,
    'pending_withdrawals': pendingWithdrawals,
    'completed_withdrawals': completedWithdrawals,
    'available_balance': availableBalance,
    'currency': currency,
  };

  factory FinancialSummary.fromMap(Map<String, dynamic> map) {
    return FinancialSummary(
      totalEarnings: (map['total_earnings'] ?? 0).toDouble(),
      adminCommission: (map['admin_commission'] ?? 0).toDouble(),
      netEarnings: (map['net_earnings'] ?? 0).toDouble(),
      pendingWithdrawals: map['pending_withdrawals'] ?? 0,
      completedWithdrawals: map['completed_withdrawals'] ?? 0,
      availableBalance: (map['available_balance'] ?? 0).toDouble(),
      currency: map['currency'] ?? '',
    );
  }

  @override
  List<Object?> get props => [
    totalEarnings,
    adminCommission,
    netEarnings,
    pendingWithdrawals,
    completedWithdrawals,
    availableBalance,
    currency,
  ];
}

class RecentOrders extends Equatable {
  final int? id;
  final String? orderNumber;
  final String? customerName;
  final String? orderStatus;
  final String? orderDate;
  final double? totalAmount;
  final int? itemsCount;

  const RecentOrders({
    this.id,
    this.orderNumber,
    this.customerName,
    this.orderStatus,
    this.orderDate,
    this.totalAmount,
    this.itemsCount,
  });

  RecentOrders copyWith({
    int? id,
    String? orderNumber,
    String? customerName,
    String? orderStatus,
    String? orderDate,
    double? totalAmount,
    int? itemsCount,
  }) {
    return RecentOrders(
      id: id ?? this.id,
      orderNumber: orderNumber ?? this.orderNumber,
      customerName: customerName ?? this.customerName,
      orderStatus: orderStatus ?? this.orderStatus,
      orderDate: orderDate ?? this.orderDate,
      totalAmount: totalAmount ?? this.totalAmount,
      itemsCount: itemsCount ?? this.itemsCount,
    );
  }

  Map<String, dynamic> toMap() => {
    'id': id,
    'order_number': orderNumber,
    'customer_name': customerName,
    'order_status': orderStatus,
    'order_date': orderDate,
    'total_amount': totalAmount,
    'items_count': itemsCount,
  };

  factory RecentOrders.fromMap(Map<String, dynamic> map) {
    return RecentOrders(
      id: map['id'] ?? 0,
      orderNumber: map['order_number'] ?? '',
      customerName: map['customer_name'] ?? '',
      orderStatus: map['order_status'] ?? '',
      orderDate: map['order_date'] ?? '',
      totalAmount: (map['total_amount'] ?? 0).toDouble(),
      itemsCount: map['items_count'] ?? 0,
    );
  }

  @override
  List<Object?> get props =>
      [id, orderNumber, customerName, orderStatus, orderDate, totalAmount, itemsCount];
}

class RecentWithdrawals extends Equatable {
  final int? id;
  final int? amount;
  final String? status;
  final String? date;
  final String? transactionId;

  const RecentWithdrawals({
    this.id,
    this.amount,
    this.status,
    this.date,
    this.transactionId,
  });

  RecentWithdrawals copyWith({
    int? id,
    int? amount,
    String? status,
    String? date,
    String? transactionId,
  }) {
    return RecentWithdrawals(
      id: id ?? this.id,
      amount: amount ?? this.amount,
      status: status ?? this.status,
      date: date ?? this.date,
      transactionId: transactionId ?? this.transactionId,
    );
  }

  Map<String, dynamic> toMap() => {
    'id': id,
    'amount': amount,
    'status': status,
    'date': date,
    'transaction_id': transactionId,
  };

  factory RecentWithdrawals.fromMap(Map<String, dynamic> map) {
    return RecentWithdrawals(
      id: map['id'] ?? 0,
      amount: map['amount'] ?? 0,
      status: map['status'] ?? '',
      date: map['date'] ?? '',
      transactionId: map['transaction_id'] ?? '',
    );
  }

  @override
  List<Object?> get props => [id, amount, status, date, transactionId];
}

class MonthlyEarnings extends Equatable {
  final String? month;
  final double? earnings;

  const MonthlyEarnings({this.month, this.earnings});

  MonthlyEarnings copyWith({String? month, double? earnings}) {
    return MonthlyEarnings(
      month: month ?? this.month,
      earnings: earnings ?? this.earnings,
    );
  }

  Map<String, dynamic> toMap() => {'month': month, 'earnings': earnings};

  factory MonthlyEarnings.fromMap(Map<String, dynamic> map) {
    return MonthlyEarnings(
      month: map['month'] ?? '',
      earnings: (map['earnings'] ?? 0).toDouble(),
    );
  }

  @override
  List<Object?> get props => [month, earnings];
}
