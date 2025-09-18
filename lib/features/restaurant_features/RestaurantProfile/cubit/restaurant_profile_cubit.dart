import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foodigo/features/restaurant_features/RestaurantProfile/model/restaurant_profile_model.dart';

import '../../Login/bloc/restaurant_login_bloc.dart';
import '../repository/restaurant_profile_repository.dart';
import 'restaurant_profile_state.dart';

class RestaurantProfileCubit extends Cubit<RestaurantProfileState> {
  final RestaurantProfileRepository _repository;
  final RestaurantLoginBloc _loginBloc;

  RestaurantProfileCubit({
    required RestaurantProfileRepository repository,
    required RestaurantLoginBloc loginBloc,
  })  : _repository = repository,
        _loginBloc = loginBloc,
        super(const RestaurantProfileInitial());

  RestaurantProfileModel? restaurantProfileModel;

  ///Get Restaurant Profile
  Future<void> getRestaurantProfile() async {
    emit(const RestaurantProfileLoading());
    final result = await _repository
        .getRestaurantProfile(_loginBloc.userInformation!.token);
    result.fold(
      (l) => emit(RestaurantProfileError(l.message, l.statusCode)),
      (success) {
        restaurantProfileModel = success;
        emit(RestaurantProfileLoaded(success));
      },
    );
  }
}
