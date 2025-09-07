import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foodigo/features/ApplyCoupon/cubit/apply_coupon_state.dart';
import 'package:foodigo/features/ApplyCoupon/model/apply_coupon_response_model.dart';
import 'package:foodigo/features/ApplyCoupon/model/apply_coupon_state_model.dart';
import 'package:foodigo/features/ApplyCoupon/repository/apply_coupon_repository.dart';

import '../../../data/errors/failure.dart';
import '../../../data/remote_url.dart';
import '../../../utils/utils.dart';
import '../../Login/bloc/login_bloc.dart';

class ApplyCouponCubit extends Cubit<ApplyCouponStateModel> {
  final ApplyCouponRepository _repository;
  final LoginBloc _loginBloc;

  ApplyCouponCubit({
    required ApplyCouponRepository repository,
    required LoginBloc loginBloc,
  })  : _repository = repository,
        _loginBloc = loginBloc,
        super(const ApplyCouponStateModel());

  ApplyCouponResponseModel? applyCouponResponseModel;

  // couponCode
  void couponCode(String couponCode) {
    emit(state.copyWith(couponCode: couponCode));
  }

  // Add to cart
  Future<void> applyCoupon() async {
    emit(state.copyWith(applyCouponState: ApplyCouponStateLoading()));
    log("apply coupon: ${state.toMap()}");

    final uri = Utils.tokenWithCode(
      RemoteUrls.checkOut,
      _loginBloc.userInformation!.token,
      _loginBloc.state.languageCode,
    );

    print('$uri');

    final result =
        await _repository.applyCoupon(state, _loginBloc.userInformation!.token);

    result.fold(
      (failure) {
        if (failure is InvalidAuthData) {
          emit(state.copyWith(
              applyCouponState: ApplyCouponStateFormValidate(failure.errors)));
        } else {
          emit(state.copyWith(
              applyCouponState:
                  ApplyCouponStateError(failure.message, failure.statusCode)));
        }
      },
      (success) {
        applyCouponResponseModel = success;
        emit(
            state.copyWith(applyCouponState: ApplyCouponStateSuccess(success)));
      },
    );
  }
}
