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
  })  : _repository = forgotPasswordRepository,
        super(ForgotPasswordStateModel.init());

  void changeEmail(String text) {
    emit(state.copyWith(
        email: text, passwordState: const ForgotPasswordStateInitial()));
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
          final errors =
              ForgotPasswordStateError(failure.message, failure.statusCode);
          emit(state.copyWith(passwordState: errors));
        }
      },
      (successMessage) {
        emit(state.copyWith(
            passwordState: ForgotPasswordStateLoaded(successMessage)));
      },
    );
  }

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
          final errors =
              ForgotPasswordStateError(failure.message, failure.statusCode);
          emit(state.copyWith(passwordState: errors));
        }
      },
      (data) {
        emit(state.copyWith(passwordState: PasswordStateUpdated(data)));
      },
    );
  }
}
