import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foodigo/features/SingleRestaurant/model/single_restaurant_model.dart';
import '../repository/single_restaurant_repository.dart';
import 'single_restaurant_state.dart';

class SingleRestaurantCubit extends Cubit<SingleRestaurantState> {
  final SingleRestaurantRepository _repository;

  SingleRestaurantCubit({required SingleRestaurantRepository repository})
      : _repository = repository,
        super(SingleRestaurantInitial());

  RestaurantDetailsModel? restaurantDetailsModel;

  Future<void> getSingleRestaurantData(String slug) async {
    emit(SingleRestaurantLoading());

    final result = await _repository.getSingleRestaurantData(slug);
    result.fold(
      (l) => emit(SingleRestaurantError(l.message, l.statusCode)),
      (success) {
        restaurantDetailsModel = success;
        emit(SingleRestaurantLoaded(success));
      },
    );
  }
}
