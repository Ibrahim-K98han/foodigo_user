import 'package:equatable/equatable.dart';
import 'package:foodigo/features/restaurant_features/Order/model/res_order_model.dart';

import '../../RestaurantDashboard/model/res_dashboard_model.dart';


abstract class ResOrderState extends Equatable {
  const ResOrderState();

  @override
  List<Object?> get props => [];
}

class ResOrderInitial extends ResOrderState {
  const ResOrderInitial();

  @override
  List<Object?> get props => [];
}

class ResOrderLoading extends ResOrderState {
  const ResOrderLoading();

  @override
  List<Object?> get props => [];
}

class ResOrderLoaded extends ResOrderState {
  final List<ResOrderModel> resOrderModel;

  const ResOrderLoaded(this.resOrderModel);

  @override
  List<Object?> get props => [resOrderModel];
}

class ResOrderSuccess extends ResOrderState {
  final ResOrderModel resOrderModel;

  const ResOrderSuccess(this.resOrderModel);

  @override
  List<Object?> get props => [resOrderModel];
}

class ResOrderError extends ResOrderState {
  final String message;
  final int statusCode;

  const ResOrderError(this.message, this.statusCode);

  @override
  List<Object?> get props => [message, statusCode];
}

/// Success: Single Order Details
class ResOrderDetailsLoaded extends ResOrderState {
  final ResOrderModel resOrderModel;

  const ResOrderDetailsLoaded(this.resOrderModel);

  @override
  List<Object?> get props => [resOrderModel];
}

class ResOrderDetailsLoading extends ResOrderState {}
