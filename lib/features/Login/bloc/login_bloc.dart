import 'dart:developer';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foodigo/features/Login/repository/login_repository.dart';
import '../../../data/errors/failure.dart';
import '../model/login_state_model.dart';
import '../model/user_response_model.dart';
import 'login_event.dart';
import 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginStateModel> {
  final LoginRepository _repository;

  UserResponseModel? _users;

  bool get isLoggedIn => _users != null && _users!.token.isNotEmpty;

  UserResponseModel? get userInformation => _users;

  set saveUserData(UserResponseModel usersData) => _users = usersData;

  LoginBloc({required LoginRepository repository})
      : _repository = repository,
        super(const LoginStateModel()) {
    on<LoginEventUserEmail>((event, emit) {
      emit(state.copyWith(
          email: event.email, loginState: const LoginStateInitial()));
    });

    on<LoginEventPassword>((event, emit) {
      emit(state.copyWith(
          password: event.password, loginState: const LoginStateInitial()));
    });

    on<SaveUserCredentialEvent>((event, emit) {
      emit(state.copyWith(
          isActive: event.isActive, loginState: const LoginStateInitial()));
    });

    on<ShowPasswordEvent>((event, emit) {
      emit(state.copyWith(
          show: !event.show, loginState: const LoginStateInitial()));
    });

    on<LoginEventRememberMe>((event, emit) {
      emit(state.copyWith(isActive: !state.isActive));
    });

    on<LoginEventSubmit>(_loginEvent);

    final result = _repository.getExistingUserInfo();
    result.fold((failure) => _users = null, (success) {
      saveUserData = success;
      log('$success', name: 'saved-user-data');
    });
  }

  Future<void> _loginEvent(
      LoginEventSubmit event, Emitter<LoginStateModel> emit) async {
    emit(state.copyWith(loginState: LoginStateLoading()));

    final result = await _repository.login(state);

    result.fold(
      (failure) {
        if (failure is InvalidAuthData) {
          emit(state.copyWith(
              loginState: LoginStateFormValidate(failure.errors)));
        } else {
          emit(
            state.copyWith(
              loginState: LoginStateError(
                  message: failure.message, statusCode: failure.statusCode),
            ),
          );
        }
      },
      (success) {
        _users = success;
        print('Login token: ${_users?.token}');
        emit(state.copyWith(
            loginState: LoginStateLoaded(userResponseModel: success)));
      },
    );
  }
}
