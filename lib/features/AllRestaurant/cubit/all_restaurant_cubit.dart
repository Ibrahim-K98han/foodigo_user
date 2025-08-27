import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foodigo/features/HomeData/restaurant_model.dart';
import '../repository/all_restaurant_repository.dart';
import 'all_restaurant_state.dart';

class AllRestaurantCubit extends Cubit<AllRestaurantState> {
  final AllRestaurantRepository _repository;

  AllRestaurantCubit({required AllRestaurantRepository repository})
      : _repository = repository,
        super(AllRestaurantInitial());

  List<Restaurants> restaurants = [];

  Future<void> getAllRestaurantData() async {
    emit(AllRestaurantLoading());

    final result = await _repository.getAllRestaurantData();
    result.fold(
      (l) => emit(AllRestaurantError(l.message, l.statusCode)),
      (success) {
        restaurants = success;
        emit(AllRestaurantLoaded(success));
      },
    );
  }
}
