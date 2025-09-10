import 'package:equatable/equatable.dart';
import 'package:foodigo/features/ApplyCoupon/model/apply_coupon_response_model.dart';

import '../../../data/errors/errors_model.dart';

abstract class ApplyCouponState extends Equatable {
  const ApplyCouponState();
}

class ApplyCouponStateInitial extends ApplyCouponState {
  const ApplyCouponStateInitial();

  @override
  List<Object?> get props => [];
}

class ApplyCouponStateLoading extends ApplyCouponState {
  @override
  List<Object?> get props => [];
}

class ApplyCouponStateInitialLoaded extends ApplyCouponState {
  final ApplyCouponResponseModel applyCouponResponseModel;

  const ApplyCouponStateInitialLoaded({required this.applyCouponResponseModel});

  @override
  List<Object?> get props => [applyCouponResponseModel];
}

class ApplyCouponStateError extends ApplyCouponState {
  final String message;
  final int statusCode;

  const ApplyCouponStateError(this.message, this.statusCode);

  @override
  List<Object?> get props => [message, statusCode];
}

class ApplyCouponStateSuccess extends ApplyCouponState {
  final ApplyCouponResponseModel applyCouponResponseModel;

  const ApplyCouponStateSuccess(this.applyCouponResponseModel);

  @override
  List<Object> get props => [applyCouponResponseModel];
}

class ApplyCouponStateFormValidate extends ApplyCouponState {
  final Errors errors;

  const ApplyCouponStateFormValidate(this.errors);

  @override
  List<Object?> get props => [errors];
}
