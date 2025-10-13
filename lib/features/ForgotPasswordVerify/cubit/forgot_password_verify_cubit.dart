import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import '../repository/forgot_password_verify_repository.dart';
import 'forgot_password_verify_state.dart';
import 'forgot_password_verify_state_model.dart';

class ForgotPasswordVerifyCubit extends Cubit<ForgotPasswordVerifyStateModel> {
  final ForgotPasswordVerifyRepository _repository;

  ForgotPasswordVerifyCubit({
    required ForgotPasswordVerifyRepository forgotPasswordRepository,
  }) : _repository = forgotPasswordRepository,
       super(ForgotPasswordVerifyStateModel.init());

  void changeEmail(String text) {
    emit(state.copyWith(email: text));
  }

  void newPass(String text) {
    emit(state.copyWith(newPass: text));
  }

  void conPass(String text) {
    emit(state.copyWith(conPass: text));
  }

  void showNewPassword() {
    emit(
      state.copyWith(
        showNewPass: !state.showNewPass,
        passwordState: const ForgotPasswordVerifyStateInitial(),
      ),
    );
  }

  void showConPassword() {
    emit(
      state.copyWith(
        showConPass: !state.showConPass,
        passwordState: const ForgotPasswordVerifyStateInitial(),
      ),
    );
  }

  void otpChange(String text) {
    print('state cubit otp:$text');
    emit(state.copyWith(otp: text));
  }

  Future<void> verifyForgetPassOtp(String email, String otp) async {
    print("Cubit Forgot Pass OTP: $otp");
    emit(state.copyWith(passwordState: const VerifyingForgotPasswordLoading()));
    final result = await _repository.verifyForgotPassOtp(state);
    result.fold(
      (failure) {
        final errors = VerifyingForgotPasswordError(
          failure.message,
        );
        emit(state.copyWith(passwordState: errors));
      },
      (success) {
        final userLoaded = VerifyingForgotPasswordLoaded(success);
        emit(state.copyWith(passwordState: userLoaded));
      },
    );
  }

}
