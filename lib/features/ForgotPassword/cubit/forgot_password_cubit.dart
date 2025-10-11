import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foodigo/features/ForgotPassword/cubit/forgot_password_state.dart';
import 'package:foodigo/features/ForgotPassword/cubit/forgot_password_state_model.dart';
import 'package:foodigo/features/ForgotPassword/repository/forgot_password_repository.dart';

import '../../../data/errors/failure.dart';

class ForgotPasswordCubit extends Cubit<ForgotPasswordStateModel> {
  final ForgotPasswordRepository _repository;

  ForgotPasswordCubit({
    required ForgotPasswordRepository forgotPasswordRepository,
  }) : _repository = forgotPasswordRepository,
       super(ForgotPasswordStateModel.init());

  void changeEmail(String text) {
    emit(state.copyWith(email: text));
  }

  void otpChange(String text) {
    print('state otp:$text');
    emit(state.copyWith(otp: text));
  }

  Future<void> forgotPasswordCode() async {
    emit(state.copyWith(passwordState: const ForgotPasswordStateLoading()));
    final body = {'email': state.email, 'lang_code': state.languageCode};
    print('verification email $body');
    final result = await _repository.forgotPassword(body);
    result.fold(
      (failure) {
        if (failure is InvalidAuthData) {
          final errors = ForgotPasswordFormValidateError(failure.errors);
          emit(state.copyWith(passwordState: errors));
        } else {
          final errors = ForgotPasswordStateError(
            failure.message,
            failure.statusCode,
          );
          emit(state.copyWith(passwordState: errors));
        }
      },
      (successMessage) {
        emit(
          state.copyWith(
            passwordState: ForgotPasswordStateLoaded(successMessage),
          ),
        );
      },
    );
  }

  Future<void> verifyForgetOtp(String email, String otp) async {
    print("Cubit OTP: $otp");
    emit(state.copyWith(passwordState: ForgotPassOtpStateLoading()));
    final result = await _repository.verifyForgotOtp(
      ForgotPasswordStateModel(email: state.email, otp: otp),
      email,
    );
    result.fold(
      (failure) {
        final errors = ForgotPssOtpStateError(
          failure.message,
          failure.statusCode,
        );
        emit(state.copyWith(passwordState: errors));
      },
      (success) {
        final userLoaded = ForgotPassOtpStateSuccess(success);
        emit(state.copyWith(passwordState: userLoaded));
      },
    );
  }

  // Future<void> verifyForgetNewPassOtp(String email) async {
  //   emit(state.copyWith(passwordState: ForgotPasswordOtpStateLoading()));
  //   final result = await _repository.verifyRegOtp(state, email);
  //   result.fold(
  //     (failure) {
  //       final errors = ForgotPasswordStateError(
  //         failure.message,
  //         failure.statusCode,
  //       );
  //       emit(state.copyWith(passwordState: errors));
  //     },
  //     (success) {
  //       final userLoaded = ForgotPasswordStateSuccess(success);
  //       emit(state.copyWith(passwordState: userLoaded));
  //     },
  //   );
  // }

  Future<void> updatePassword(String email, String otp) async {
    emit(state.copyWith(passwordState: const ForgotPasswordStateLoading()));
    debugPrint('update-password-languageCode ${state.languageCode}');
    final result = await _repository.resetPassword(state, email, otp);
    result.fold(
      (failure) {
        if (failure is InvalidAuthData) {
          final errors = ForgotPasswordFormValidateError(failure.errors);
          emit(state.copyWith(passwordState: errors));
        } else {
          final errors = ForgotPasswordStateError(
            failure.message,
            failure.statusCode,
          );
          emit(state.copyWith(passwordState: errors));
        }
      },
      (data) {
        emit(state.copyWith(passwordState: PasswordStateUpdated(data)));
      },
    );
  }
}
