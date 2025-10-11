import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../data/errors/failure.dart';
import '../../../../data/remote_url.dart';
import '../model/restaurant_login_response_model.dart';
import '../model/restaurant_login_state_model.dart';
import '../repository/restaurant_login_repository.dart';
import 'restaurant_login_event.dart';
import 'restaurant_login_state.dart';

class RestaurantLoginBloc
    extends Bloc<RestaurantLoginEvent, RestaurantLoginStateModel> {
  final RestaurantLoginRepository _repository;

  RestaurantLoginResponse? _users;

  bool get isLoggedIn => _users != null && _users!.token.isNotEmpty;

  RestaurantLoginResponse? get userInformation => _users;

  set saveUserData(RestaurantLoginResponse usersData) => _users = usersData;

  RestaurantLoginBloc({required RestaurantLoginRepository repository})
      : _repository = repository,
        super(const RestaurantLoginStateModel()) {
    on<RestaurantLoginEventUserEmail>((event, emit) {
      emit(state.copyWith(
          email: event.email,
          restaurantLoginState: const RestaurantLoginStateInitial()));
    });

    on<RestaurantLoginEventPassword>((event, emit) {
      emit(state.copyWith(
          password: event.password,
          restaurantLoginState: const RestaurantLoginStateInitial()));
    });

    on<RestaurantSaveUserCredentialEvent>((event, emit) {
      emit(state.copyWith(
          isActive: event.isActive,
          restaurantLoginState: const RestaurantLoginStateInitial()));
    });

    on<RestaurantShowPasswordEvent>((event, emit) {
      emit(state.copyWith(
          show: !event.show,
          restaurantLoginState: const RestaurantLoginStateInitial()));
    });

    // on<LoginEventRememberMe>((event, emit) {
    //   emit(state.copyWith(isActive: !state.isActive));
    // });

    on<RestaurantLoginEventSubmit>(_loginEvent);
    on<RestaurantLoginEventLogout>(_logoutEvent);

    final result = _repository.getExistingRestaurantInfo();
    result.fold((failure) => _users = null, (success) {
      saveUserData = success;
      log('$success', name: 'saved-user-data');
    });
  }

  Future<void> _loginEvent(
    RestaurantLoginEventSubmit event,
    Emitter<RestaurantLoginStateModel> emit,
  ) async {
    emit(state.copyWith(restaurantLoginState: RestaurantLoginStateLoading()));

    final result = await _repository.restaurantLogin(state);

    result.fold(
      (failure) {
        if (failure is InvalidAuthData) {
          emit(
            state.copyWith(
              restaurantLoginState:
                  RestaurantLoginStateFormValidate(failure.errors),
            ),
          );
        } else {
          emit(
            state.copyWith(
              restaurantLoginState: RestaurantLoginStateError(
                message: failure.message,
                statusCode: failure.statusCode,
              ),
            ),
          );
        }
      },
      (success) {
        _users = success;
        print('restaurant Login token: ${_users?.token}');
        emit(
          state.copyWith(
            restaurantLoginState:
                RestaurantLoginStateLoaded(restaurantLoginResponse: success),
          ),
        );
      },
    );
  }

  Future<void> _logoutEvent(RestaurantLoginEventLogout event,
      Emitter<RestaurantLoginStateModel> emit) async {
    emit(state.copyWith(
        restaurantLoginState: RestaurantLoginStateLogoutLoading()));
     final url = Uri.parse(RemoteUrls.restaurantLogout).replace(queryParameters: {
      'token': userInformation!.token,
      'lang_code': state.languageCode,
    });
    final result = await _repository.restaurantLogout(url, userInformation!.token);
    result.fold(
      (failure) {
        if (failure.statusCode == 500) {
          const loadedData =
              RestaurantLoginStateLogoutLoaded('logout success', 200);
          emit(state.copyWith(restaurantLoginState: loadedData));
        } else {
          final errors = RestaurantLoginStateLogoutError(
              failure.message, failure.statusCode);
          emit(state.copyWith(restaurantLoginState: errors));
        }
      },
      (logout) {
        _users = null;
        emit(state.copyWith(
            restaurantLoginState:
                RestaurantLoginStateLogoutLoaded(logout, 200)));
        //remoteCredentials();
      },
    );
  }
}
