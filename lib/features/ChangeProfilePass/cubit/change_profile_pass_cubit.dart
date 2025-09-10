import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foodigo/features/ChangeProfilePass/cubit/change_profile_pass_state.dart';
import 'package:foodigo/features/ChangeProfilePass/model/change_profile_pass_state_model.dart';
import 'package:foodigo/features/ChangeProfilePass/repository/change_profile_pass_repository.dart';

import '../../../data/errors/failure.dart';
import '../../Login/bloc/login_bloc.dart';

class ChangeProfilePassCubit extends Cubit<ChangeProfilePassStateModel> {
  final ChangeProfilePassRepository _repository;
  final LoginBloc _loginBloc;

  ChangeProfilePassCubit({
    required ChangeProfilePassRepository registerRepository,
    required LoginBloc loginBloc,
  })  : _repository = registerRepository,
        _loginBloc = loginBloc,
        super(ChangeProfilePassStateModel.init());

  Timer? _resendTimer;

  @override
  Future<void> close() {
    _resendTimer?.cancel();
    return super.close();
  }

  void changeCurrentPassword(String text) {
    emit(state.copyWith(
        currentPassword: text,
        changeProfilePassState: const ChangeProfilePassInitial()));
  }

  void changeNewPassword(String text) {
    emit(state.copyWith(
        password: text,
        changeProfilePassState: const ChangeProfilePassInitial()));
  }

  void changeConfirmPassword(String text) {
    emit(state.copyWith(
        confirmPassword: text,
        changeProfilePassState: const ChangeProfilePassInitial()));
  }

  void showCurrentPassword() {
    emit(state.copyWith(
        showCurrentPassword: !state.showCurrentPassword,
        changeProfilePassState: const ChangeProfilePassInitial()));
  }

  void showPassword() {
    emit(state.copyWith(
        showPassword: !state.showPassword,
        changeProfilePassState: const ChangeProfilePassInitial()));
  }

  void showConfirmPassword() {
    emit(state.copyWith(
        showConPassword: !state.showConPassword,
        changeProfilePassState: const ChangeProfilePassInitial()));
  }

  Future<void> changeProfilePass() async {
    print('ChangePass: ${state.toMap()}');
    emit(state.copyWith(
        changeProfilePassState: ChangeProfilePassStateLoading()));
    final result = await _repository.changeProfilePass(
        state, _loginBloc.userInformation!.token);
    result.fold(
      (failure) {
        if (failure is InvalidAuthData) {
          final errors = ChangeProfilePassValidateStateError(failure.errors);
          emit(state.copyWith(changeProfilePassState: errors));
        } else {
          final errors =
              ChangeProfilePassStateError(failure.message, failure.statusCode);
          emit(state.copyWith(changeProfilePassState: errors));
        }
      },
      (success) {
        emit(state.copyWith(
            changeProfilePassState: ChangeProfilePassStateSuccess(success)));
      },
    );
  }

  Future<void> clearAllField() async {
    emit(ChangeProfilePassStateModel.init());
  }
}
