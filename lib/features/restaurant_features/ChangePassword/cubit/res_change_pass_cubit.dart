import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foodigo/features/restaurant_features/ChangePassword/cubit/res_change_pass_state.dart';
import 'package:foodigo/features/restaurant_features/ChangePassword/model/res_change_pass_state_model.dart';
import 'package:foodigo/features/restaurant_features/ChangePassword/repository/res_change_pass_repository.dart';
import 'package:foodigo/features/restaurant_features/Login/bloc/restaurant_login_bloc.dart';

import '../../../../data/errors/failure.dart';

class ResChangePassCubit extends Cubit<ResChangePassStateModel> {
  final ResChangePassRepository _repository;
  final RestaurantLoginBloc _loginBloc;

  ResChangePassCubit({
    required ResChangePassRepository registerRepository,
    required RestaurantLoginBloc loginBloc,
  })  : _repository = registerRepository,
        _loginBloc = loginBloc,
        super(ResChangePassStateModel.init());

  Timer? _resendTimer;

  @override
  Future<void> close() {
    _resendTimer?.cancel();
    return super.close();
  }

  void changeCurrentPassword(String text) {
    emit(state.copyWith(
      changePassState: const ResChangePassInitial(),
      currentPassword: text,
    ));
  }

  void changeNewPassword(String text) {
    emit(state.copyWith(
        password: text, changePassState: const ResChangePassInitial()));
  }

  void changeConfirmPassword(String text) {
    emit(state.copyWith(
        confirmPassword: text, changePassState: const ResChangePassInitial()));
  }

  void showCurrentPassword() {
    emit(state.copyWith(
        showCurrentPassword: !state.showCurrentPassword,
        changePassState: const ResChangePassInitial()));
  }

  void showPassword() {
    emit(state.copyWith(
        showPassword: !state.showPassword,
        changePassState: const ResChangePassInitial()));
  }

  void showConfirmPassword() {
    emit(state.copyWith(
        showConPassword: !state.showConPassword,
        changePassState: const ResChangePassInitial()));
  }

  Future<void> changePass() async {
    print('ChangePass Restaurant: ${state.toMap()}');
    emit(state.copyWith(changePassState: ResChangePassStateLoading()));
    final result =
        await _repository.changePass(state, _loginBloc.userInformation!.token);
    result.fold(
      (failure) {
        if (failure is InvalidAuthData) {
          final errors = ResChangePassValidateStateError(failure.errors);
          emit(state.copyWith(changePassState: errors));
        } else {
          final errors =
              ResChangePassStateError(failure.message, failure.statusCode);
          emit(state.copyWith(changePassState: errors));
        }
      },
      (success) {
        emit(state.copyWith(
            changePassState: ResChangePassStateSuccess(success)));
      },
    );
  }

  Future<void> clearAllField() async {
    emit(ResChangePassStateModel.init());
  }
}
