import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foodigo/features/register/cubit/register_state.dart';
import 'package:foodigo/features/register/model/register_state_model.dart';
import 'package:foodigo/features/register/repository/register_repository.dart';

import '../../../data/errors/failure.dart';

class RegisterCubit extends Cubit<RegisterStateModel> {
  final RegisterRepository _repository;

  RegisterCubit({
    required RegisterRepository registerRepository,
  })  : _repository = registerRepository,
        super(RegisterStateModel.init());


  Timer? _resendTimer;

  @override
  Future<void> close() {
    _resendTimer?.cancel();
    return super.close();
  }

  void changeName(String text) {
    emit(state.copyWith(name: text, registerState: const RegisterInitial()));
  }

  void changeEmail(String text) {
    emit(state.copyWith(email: text, registerState: const RegisterInitial()));
  }

  void changePassword(String text) {
    emit(
        state.copyWith(password: text, registerState: const RegisterInitial()));
  }

  void changeConPassword(String text) {
    emit(state.copyWith(
        confirmPassword: text, registerState: const RegisterInitial()));
  }

  void showPassword() {
    emit(state.copyWith(
        showPassword: !state.showPassword,
        registerState: const RegisterInitial()));
  }

  void showConfirmPassword() {
    emit(state.copyWith(
        showConPassword: !state.showConPassword,
        registerState: const RegisterInitial()));
  }

  void privacyPolicy() {
    emit(state.copyWith(
        isActive: !state.isActive, registerState: const RegisterInitial()));
  }

  void phoneNumber(String text) {
    emit(state.copyWith(phone: text, registerState: const RegisterInitial()));
  }

  void otpChange(String text) {
    emit(state.copyWith(
      otp: text,
    ));
  }

  Future<void> userRegister() async {
    print('Register: ${state.toMap()}');
    emit(state.copyWith(registerState: RegisterStateLoading()));
    final result = await _repository.signUp(state);
    result.fold(
      (failure) {
        if (failure is InvalidAuthData) {
          final errors = RegisterValidateStateError(failure.errors);
          emit(state.copyWith(registerState: errors));
        } else {
          final errors =
              RegisterStateError(failure.message, failure.statusCode);
          emit(state.copyWith(registerState: errors));
        }
      },
      (success) {
        emit(state.copyWith(registerState: RegisterStateSuccess(success)));
      },
    );
  }

  Future<void> verifyRegOtp(String email) async {
    emit(state.copyWith(registerState: RegisterOtpStateLoading()));
    final result = await _repository.verifyRegOtp(state, email);
    result.fold(
      (failure) {
        final errors =
            RegisterOtpStateError(failure.message, failure.statusCode);
        emit(state.copyWith(registerState: errors));
      },
      (success) {
        final userLoaded = RegisterOtpStateSuccess(success);
        emit(state.copyWith(registerState: userLoaded));
      },
    );
  }

  Future<void> resendVerificationCode() async {
    emit(state.copyWith(registerState: const SignUpStateResendCodeLoading()));
    final body = {'email': state.email, 'lang_code': state.languageCode};
    print('verification email $body');
    final result = await _repository.resendVerificationCode(body);
    result.fold((failure) {
      if (failure is InvalidAuthData) {
        final errors = SignUpStateFormValidate(failure.errors);
        emit(state.copyWith(registerState: errors));
      } else {
        final errors = SignUpStateError(failure.message, failure.statusCode);
        emit(state.copyWith(registerState: errors));
      }
    }, (success) {
      emit(state.copyWith(registerState: SignUpStateResendCodeLoaded(success)));
    });
  }

  Future<void> clearAllField() async {
    emit(RegisterStateModel.init());
  }
}
